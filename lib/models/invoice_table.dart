import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:flutter/material.dart';

import 'invoice.dart';

class InvoiceTableSource extends AdvancedDataTableSource<Invoice> {
  final data = invoices;

  final BuildContext context;
  InvoiceTableSource({required this.context});

  String formatText(String text) {
    if (text.length > 120) {
      final subStrings = text.substring(0, 120);
      return subStrings + '...';
    }

    return text;
  }

  @override
  DataRow? getRow(int index) {
    final currentRowData = lastDetails!.rows[index];
    return DataRow(cells: [
      DataCell(
        Text(currentRowData.invoiceId),
      ),
      DataCell(
        Text(currentRowData.productId),
      ),
      DataCell(
        Text(formatText(currentRowData.productTitle)),
      ),
      DataCell(
        Text(currentRowData.customerName),
      ),
      DataCell(
        Text(currentRowData.price.toString()),
      ),
      DataCell(
        Text(currentRowData.size.toString()),
      ),
      DataCell(
        Text(currentRowData.billingAdd),
      ),
      DataCell(
        Text(currentRowData.shippingAdd),
      ),
    ]);
  }

  @override
  int get selectedRowCount => 0;

  @override
  Future<RemoteDataSourceDetails<Invoice>> getNextPage(
      NextPageRequest pageRequest) async {
    return RemoteDataSourceDetails(
      data.length,
      data
          .skip(pageRequest.offset)
          .take(pageRequest.pageSize)
          .toList(), //again in a real world example you would only get the right amount of rows
    );
  }
}
