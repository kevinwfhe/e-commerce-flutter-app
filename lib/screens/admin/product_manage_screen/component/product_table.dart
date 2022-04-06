import 'dart:convert';
import 'package:csi5112group1project/apis/request.dart';
import 'package:flutter/material.dart';
import 'package:advanced_datatable/advanced_datatable_source.dart';
import '../../../../models/product.dart';

class ProductTableSource extends AdvancedDataTableSource<Product> {
  final Map<String, String> categories;
  final List<String> selectedIds = [];
  String lastSearchTerm = '';
  final Function onClickDetails;
  final Function updateSource;
  ProductTableSource({
    Key? key,
    required this.onClickDetails,
    required this.categories,
    required this.updateSource,
  });

  String? getCategory(categoryId) => categories[categoryId];

  showDetailPage(String productId) => onClickDetails(productId);

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.trim();
    setNextView();
  }

  void clearSelectedRow() => selectedIds.clear();

  @override
  int get selectedRowCount => selectedIds.length;

  void selectedRow(String id, bool newSelectState) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    updateSource();
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    final currentRowData = lastDetails!.rows[index];
    return DataRow(
      selected: selectedIds.contains(currentRowData.id),
      onSelectChanged: (selected) => selectedRow(currentRowData.id, selected!),
      cells: [
        DataCell(
          Text(currentRowData.id.toString()),
        ),
        DataCell(
          Text(currentRowData.title),
        ),
        DataCell(
          Builder(
            builder: ((context) {
              var categoryName = getCategory(currentRowData.category);
              // category name null check
              if (categoryName != null) {
                return Text(categoryName);
              } else {
                return const Text('');
              }
            }),
          ),
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
      ],
    );
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

    final String requestQueryParams = Uri(
        queryParameters: queryParameter.map(
            (key, value) => MapEntry(key, value?.toString()))).query.toString();

    final response = await Request.get('/Product?$requestQueryParams');
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
