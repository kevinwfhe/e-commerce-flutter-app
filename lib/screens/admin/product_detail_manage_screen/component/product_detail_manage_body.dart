import 'package:flutter/material.dart';
import '../../../../models/product.dart';
import 'product_detail_state.dart';

class ProductDetailManageBody extends StatefulWidget {
  final Future<Product> fProduct;
  const ProductDetailManageBody({
    Key? key,
    required this.fProduct,
  }) : super(key: key);

  @override
  State<ProductDetailManageBody> createState() => ProductDetailTableState();
}
