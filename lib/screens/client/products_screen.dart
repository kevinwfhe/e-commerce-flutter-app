import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import './authentification_buyer_screen.dart';
import './component/body.dart';
import './shopping_cart_screen.dart';
// flutter pub add flutter_svg

class products_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("icons/back.svg", color: Colors.black),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AuthentificationBuyerScreen()));
          },
        ), // icon - - back

        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("icons/search.svg", color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset("icons/cart.svg", color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Shopping_cart()));
            },
          ),
          SizedBox(width: kDefaultPadding / 2)
        ],
      ),
      body: Body(),
    );
  }
}
