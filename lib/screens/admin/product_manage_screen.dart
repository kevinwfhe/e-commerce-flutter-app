import 'package:flutter/material.dart';
import './component/product_manage_body.dart';

class ProductManageScreen extends StatelessWidget {
  const ProductManageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Product list"),
      ),
      body: const ProductManageBody(),
    );
  }
}
