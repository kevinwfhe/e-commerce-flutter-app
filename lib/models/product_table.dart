import 'dart:convert';
import 'package:csi5112group1project/apis/request.dart';
import 'package:flutter/material.dart';
import 'package:advanced_datatable/advanced_datatable_source.dart';
import './product.dart';

class ProductTableSource extends AdvancedDataTableSource<Product> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';
  final Function onClickDetails;
  ProductTableSource({
    Key? key,
    required this.onClickDetails,
  });

  showDetailPage(String productId) => onClickDetails(productId);

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.trim();
    setNextView();
  }

  @override
  int get selectedRowCount => selectedIds.length;

  // ignore: avoid_positional_boolean_parameters
  void selectedRow(String id, bool newSelectState) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    final currentRowData = lastDetails!.rows[index];
    return DataRow(cells: [
      DataCell(
        Text(currentRowData.id.toString()),
      ),
      DataCell(
        Text(currentRowData.title),
      ),
      DataCell(
        Text(currentRowData.category),
      ),
      DataCell(
        Text(currentRowData.price.toString()),
      ),
      DataCell(
        TextButton(
          onPressed: () {
            final productId = currentRowData.id;
            showDetailPage(productId);
          },
          child: const Text(
            'Details',
            style: TextStyle(color: Colors.blue, fontSize: 15),
          ),
        ),
      ),
    ]);
  }

  @override
  Future<RemoteDataSourceDetails<Product>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    //the remote data source has to support the pagaing and sorting
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      'pageSize': pageRequest.pageSize.toString(),
      'sortIndex': ((pageRequest.columnSortIndex ?? 0)).toString(),
      'sortAsc': ((pageRequest.sortAscending ?? true) ? 1 : 0).toString(),
      if (lastSearchTerm.isNotEmpty) 'keyword': lastSearchTerm,
    };

    final requestUri = Uri.https(
      // 'csi5112group1project-service.kevinhe.dev',
      'localhost:7098',
      '/api/Product',
      queryParameter,
    ).toString();

    final response = await Request.base('get', requestUri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return RemoteDataSourceDetails(
        int.parse(data['totalRows'].toString()),
        (data['rows'] as List)
            .map(
              (json) => Product.fromJson(json),
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? (data['rows'] as List<dynamic>).length
            : null,
      );
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}
