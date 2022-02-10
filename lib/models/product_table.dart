import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:csi5112group1project/models/Product.dart';
import 'package:flutter/material.dart';

import '../screens/product_detail_manage_screen.dart';

class ProductTableSource extends AdvancedDataTableSource<Product> {
  final data = products;

  final BuildContext context;
  ProductTableSource({required this.context});

  String formatText(String text) {
    if (text.length > 120) {
      final subStrings = text.substring(0, 120);
      return subStrings + '...';
    }

    return text;
  }

  showDetailPage(Product product) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ProductDetailManageScreen(product: product)));
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
        Text(formatText(currentRowData.description)),
      ),
      DataCell(
        Text(currentRowData.category),
      ),
      DataCell(
        Text(currentRowData.price.toString()),
      ),
      DataCell(
        Text(currentRowData.size.toString()),
      ),
      DataCell(Container(
          width: 200, height: 150, child: Image.asset(currentRowData.image))),
      DataCell(
        TextButton(
          onPressed: () {
            final product = currentRowData;
            showDetailPage(product);
          },
          child: const Text(
            'View',
            style: TextStyle(color: Colors.blue, fontSize: 15),
          ),
        ),
      ),
    ]);
  }

  @override
  int get selectedRowCount => 0;

  @override
  Future<RemoteDataSourceDetails<Product>> getNextPage(
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
