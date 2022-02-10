import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../models/Product.dart';
import 'component/product_detail_manage_body.dart';
import 'product_manage_screen.dart';

class ProductDetailManageScreen extends StatelessWidget {
  final Product? product;

  ProductDetailManageScreen({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Product manage"),
          leading: IconButton(
            icon: SvgPicture.asset("icons/back.svg", color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ProductManageScreen()));
            },
          ),
        ),
        body: ProductDetailManageBody(
          product: product,
        ));
  }
}
