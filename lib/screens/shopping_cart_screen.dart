import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import 'package:csi5112group1project/constants.dart';
import 'package:csi5112group1project/models/cart.dart';


class Shopping_cart extends StatelessWidget {
  // final String name, image, id;
  // final int price, quantity;




  // Shopping_cart({
  //   required this.name,
  //   required this.price,
  //   required this.image,
  //   required this.id,
  //   required this.quantity,
  // });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping cart"),
      ),
      // body: Column(
      //   children: <Widget>[
      //     Expanded(
      //       child: ListView.builder(
      //           itemCount: cart.items.length,
      //           itemBuilder: (ctx, i) => CartPdt(
      //               cart.items.values.toList()[i].id,
      //               cart.items.keys.toList()[i],
      //               cart.items.values.toList()[i].price,
      //               cart.items.values.toList()[i].quantity,
      //               cart.items.values.toList()[i].name)),
      //     ),

        // ],
      // ),



      floatingActionButton: FloatingActionButton(
        onPressed: (){}, // idea for click the checkout button, move to the summary page and could download a specific invoice.
        tooltip: 'Add to shopping cart',
        child: const Icon(Icons.add),
      ),
    );
  }
}