import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_route/auto_route.dart';
import '../../constants.dart';
import './component/body.dart';
import '../../routes/router.gr.dart';
// flutter pub add flutter_svg

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

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
      body: Body(),
    );
  }
}
