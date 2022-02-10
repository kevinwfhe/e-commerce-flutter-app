import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:csi5112group1project/constants.dart';
import 'package:csi5112group1project/models/Cart.dart';
import 'package:csi5112group1project/screens/component/cart_item.dart';
import 'package:csi5112group1project/screens/component/body_cart.dart';


class Shopping_cart extends StatelessWidget {


  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Shopping cart"),

          ]
        ),
      ),
      body: Body(),


    );
  }
}