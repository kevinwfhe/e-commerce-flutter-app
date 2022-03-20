import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../routes/router.gr.dart';
import '../../apis/request.dart';
import '../../models/product.dart';
import '../../constants.dart';
import './component/body.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Product>> fProducts;

  Future<List<Product>> getProducts() async {
    var response = await Request.get('/Product');
    final List list = jsonDecode(response.body);
    return list.map<Product>((p) => Product.fromJson(p)).toList();
  }

  @override
  void initState() {
    super.initState();
    fProducts = getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search_outlined,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
            ),
            onPressed: () => context.router.push(const LoginRoute()),
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
            onPressed: () {
              context.router.navigate(const StandAloneCartRoute());
            },
          ),
          const SizedBox(width: kDefaultPadding / 2)
        ],
      ),
      body: Body(fProducts: fProducts),
    );
  }
}
