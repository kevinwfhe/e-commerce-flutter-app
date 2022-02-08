import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:csi5112group1project/constants.dart';

class Shopping_cart extends StatelessWidget {
  // final String title, image;
  // final int price;




  // Shopping_cart({
  //   required this.title,
  //   required this.price,
  //   required this.image,
  // });

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping cart"),
      ),

      // should able to display everything that was being added to the cart and calculate the total for checkout
      // idea: a linked list to add take everything
      // would it be able to delete few orders, linked list is not a good idea

      floatingActionButton: FloatingActionButton(
        onPressed: (){}, // idea for click the checkout button, move to the summary page and could download a specific invoice.
        tooltip: 'Add to shopping cart',
        child: const Icon(Icons.add),
      ),
    );
  }
}