import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../state/product_detail_state.dart';

class ProductDetailManageBody extends StatefulWidget {
  final Product? product;
  const ProductDetailManageBody({Key? key, this.product}) : super(key: key);

  @override
  State<ProductDetailManageBody> createState() => ProductDetailTableState();
}
