import 'package:csi5112group1project/models/product.dart';

class PageData<T> {
  final List<T> rows;
  final int totalRows;
  PageData({
    required this.rows,
    required this.totalRows,
  });

  factory PageData.fromJson(Map<dynamic, dynamic> json) {
    var list = json['rows'] as List;
    List tList = list;
    if (T == Product) {
      tList = list.map((p) => Product.fromJson(p)).toList();
    }
    return PageData(
      rows: tList as List<T>,
      totalRows: json['totalRows'],
    );
  }
}
