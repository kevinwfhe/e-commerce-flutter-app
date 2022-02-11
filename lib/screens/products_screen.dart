import 'package:csi5112group1project/screens/authentification_buyer_screen.dart';
import 'package:csi5112group1project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:csi5112group1project/constants.dart';

import 'package:csi5112group1project/screens/component/body.dart';
import 'package:csi5112group1project/screens/shopping_cart_screen.dart';
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
                context, MaterialPageRoute(builder: (_) => AuthentificationBuyerScreen()));
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
