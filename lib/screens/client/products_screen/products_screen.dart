import 'dart:convert';
import 'package:csi5112group1project/context/user_context.dart';
import 'package:csi5112group1project/models/category.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
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
  late Future<List<Category>> fCategories;
  String searchKeyword = '';
  String selectedCategoryId = '';

  Future<List<Category>> getCategories() async {
    var response = await Request.get('/Category');
    List list = jsonDecode(response.body);
    return list.map((cat) => Category.fromJson(cat)).toList();
  }

  Future<PageData<Product>> getProducts() async {
    final queryParameter = <String, dynamic>{
      if (selectedCategoryId != '') 'category': selectedCategoryId,
      if (searchKeyword.isNotEmpty) 'keyword': searchKeyword,
    };

    final String requestQueryParams = Uri(
        queryParameters: queryParameter.map(
            (key, value) => MapEntry(key, value?.toString()))).query.toString();

    var url = requestQueryParams != null
        ? '/Product?$requestQueryParams'
        : '/Product';

    var response = await Request.get(url);
    final jsonResponse = jsonDecode(response.body);
    return PageData<Product>.fromJson(jsonResponse);
  }

  void onKeywordChange(keyword) {
    setState(() {
      searchKeyword = keyword;
    });
    searchProduct();
  }

  void onCategoryChange(categoryId) {
    setState(() {
      selectedCategoryId = categoryId;
    });
    searchProduct();
  }

  void searchProduct() {
    setState(() {
      fProducts = getProducts();
    });
  }

  void signout() async {
    Request.get('/logout').then((response) async {
      if (response.statusCode == 200) {
        var user = Provider.of<UserContext>(context, listen: false);
        await user.clear();
        ScaffoldMessenger.of(context).showSnackBar(printLogoutSnackBar);
        context.navigateTo(const LoginRoute());
      }
    }).catchError((error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(logoutFailedSnackBar);
    });
  }

  @override
  void initState() {
    super.initState();
    fProducts = getProducts();
    fCategories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: null,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.12),
            child: SearchBar(
              onSearchKeywordChange: (keyword) => onKeywordChange(keyword),
              onSearchConfirm: (keyword) => onKeywordChange(keyword),
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ),
          UserConsumer(
            builder: ((context, user, child) {
              if (user.exist) {
                return PopupMenuButton(
                  key: ValueKey(user.id),
                  child: const Icon(
                    Icons.account_circle_outlined,
                    size: 32,
                  ),
                  itemBuilder: ((context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          child: Text(user.username as String),
                        ),
                        PopupMenuItem(
                          child: const Text('Your Account'),
                          onTap: () => print('Go to account page.'),
                        ),
                        PopupMenuItem(
                          child: const Text('Sign Out'),
                          onTap: () => signout(),
                        ),
                      ]),
                );
              } else {
                return IconButton(
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    size: 32,
                  ),
                  onPressed: () {
                    context.navigateTo(const LoginRoute());
                  },
                );
              }
            }),
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 32,
            ),
            onPressed: () {
              context.router.navigate(const StandAloneCartRoute());
            },
          ),
          const SizedBox(width: kDefaultPadding / 2)
        ],
      ),
      body: ProductScreenBody(
        fCategory: fCategories,
        fProducts: fProducts,
        onCategoryChange: (categoryId) => onCategoryChange(categoryId),
      ),
    );
  }
}

const printLogoutSnackBar = SnackBar(
    content: Text(
  'You have sign out!',
  textAlign: TextAlign.center,
));

const logoutFailedSnackBar = SnackBar(
    content: Text(
  'Sign out failed, please try again later.',
  textAlign: TextAlign.center,
));
