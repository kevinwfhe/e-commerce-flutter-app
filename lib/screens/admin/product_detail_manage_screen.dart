import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../apis/request.dart';
import '../../models/product.dart';
import './component/product_detail_manage_body.dart';

class ProductDetailManageScreen extends StatefulWidget {
  final Product product;
  final String productId;
  const ProductDetailManageScreen({
    Key? key,
    @PathParam() required this.productId,
    required this.product,
  }) : super(key: key);

  @override
  _ProductDetailManageScreenState createState() =>
      _ProductDetailManageScreenState();
}

class _ProductDetailManageScreenState extends State<ProductDetailManageScreen> {
  late Future<Product> fProduct;
  Future<Product> getProduct() async {
    var response = await Request.get('/Product/${widget.productId}');
    var product = Product.fromJson(jsonDecode(response.body));
    return product;
  }

  @override
  void initState() {
    super.initState();
    fProduct = getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Product manage"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.popRoute(),
        ),
      ),
      body: ProductDetailManageBody(
        fProduct: fProduct,
      ),
    );
  }
}
