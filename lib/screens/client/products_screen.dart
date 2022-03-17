import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import '../../models/product.dart';
import '../../constants.dart';
import './component/body.dart';
import '../../routes/router.gr.dart';
// flutter pub add flutter_svg

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Product>> products;

  Future<List<Product>> apitest() async {
    var url = Uri.parse('http://3.99.187.201/api/Product');
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    var jsonResponse = jsonDecode(response.body) as List;
    return jsonResponse.map<Product>((p) => Product.fromJson(p)).toList();
  }

  @override
  void initState() {
    super.initState();
    products = apitest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("icons/back.svg", color: Colors.black),
          onPressed: () {
            // print(context.router.stack);
            context.router.pushNamed('/');
          },
        ), // icon - - back

        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            onPressed: () => context.router.push(const LoginRoute()),
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              context.router.navigate(const StandAloneCartRoute());
            },
          ),
          const SizedBox(width: kDefaultPadding / 2)
        ],
      ),
      body: Body(products: products),
    );
  }
}
