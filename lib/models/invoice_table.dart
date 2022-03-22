import 'dart:convert';
import 'package:csi5112group1project/apis/request.dart';
import 'package:csi5112group1project/utils/order_status_map.dart';
import 'package:flutter/material.dart';
import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:intl/intl.dart';
import './order.dart';

class InvoiceTableSource extends AdvancedDataTableSource<Order> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';
  final Function onClickDetails;
  InvoiceTableSource({
    Key? key,
    required this.onClickDetails,
  });

  showDetailPage(String orderId) => onClickDetails(orderId);

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.trim();
    setNextView();
  }

  @override
  int get selectedRowCount => selectedIds.length;

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
        Text(currentRowData.orderId.toString()),
      ),
      DataCell(
        Text(ORDER_STATUS_TO_STRING[currentRowData.orderStatus]!),
      ),
      DataCell(
        Text(DateFormat('yyyy-dd-MM HH:mm:ss').format(currentRowData.orderTimeStamp)),
      ),
      DataCell(
        Text(currentRowData.totalPrice.toString()),
      ),
      DataCell(
        TextButton(
          onPressed: () {
            final orderId = currentRowData.orderId;
            showDetailPage(orderId);
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
  Future<RemoteDataSourceDetails<Order>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    //the remote data source has to support the pagaing and sorting
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset,
      'pageSize': pageRequest.pageSize,
      'sortIndex': ((pageRequest.columnSortIndex ?? 0)),
      'sortAsc': ((pageRequest.sortAscending ?? true) ? 1 : 0),
      if (lastSearchTerm.isNotEmpty) 'keyword': lastSearchTerm,
    };

    final String requestQueryParams = Uri(
        queryParameters: queryParameter.map(
            (key, value) => MapEntry(key, value?.toString()))).query.toString();

    final response = await Request.get('/Order?$requestQueryParams');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return RemoteDataSourceDetails(
        int.parse(data['totalRows'].toString()),
        (data['rows'] as List)
            .map(
              (json) => Order.fromJson(json),
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
