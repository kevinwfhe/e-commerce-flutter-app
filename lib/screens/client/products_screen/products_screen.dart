import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../models/page_data.dart';
import '../../../routes/router.gr.dart';
import '../../../apis/request.dart';
import '../../../models/product.dart';
import '../../../constants.dart';
import 'component/body.dart';
import '../component/search_bar.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<PageData<Product>> fProducts;
  String searchKeyword = '';
  String selectedCategory = '';
  Future<PageData<Product>> getProducts() async {
    var response = await Request.get('/Product');
    final jsonResponse = jsonDecode(response.body);
    return PageData<Product>.fromJson(jsonResponse);
  }

  Future<PageData<Product>> getProductsByKeyword(keyword, category) async {
    var response = await Request.get(
        '/Product?${keyword == '' ? '' : 'keyword=$keyword'}${category == '0' ? '' : '&category=$category'}');
    final jsonResponse = jsonDecode(response.body);
    return PageData<Product>.fromJson(jsonResponse);
  }

  void searchProduct() {
    if (searchKeyword != '' || selectedCategory != '') {
      setState(() {
        fProducts = getProductsByKeyword(searchKeyword, selectedCategory);
      });
    } else {
      setState(() {
        fProducts = getProducts();
        searchKeyword = '';
      });
    }
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
        toolbarHeight: 70,
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.12),
            child: SearchBar(
              onSearchKeywordChange: (keyword) {
                searchKeyword = keyword;
                searchProduct();
              },
              onSearchConfirm: (keyword) {
                searchKeyword = keyword;
                searchProduct();
              },
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
            ),
            onPressed: () => {
              ScaffoldMessenger.of(context).showSnackBar(printLogoutSnackBar),
              context.router.push(const LoginRoute())
            },
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
      body: Body(
        fProducts: fProducts,
        onCategoryChange: (category) => {
          selectedCategory = category,
          searchProduct(),
        },
      ),
    );
  }
}

const printLogoutSnackBar = SnackBar(
    content: Text(
  'You have logged out!',
  textAlign: TextAlign.center,
));
