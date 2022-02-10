import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:csi5112group1project/constants.dart';
import 'package:csi5112group1project/screens/shopping_cart_screen.dart';
class Details_product extends StatelessWidget {
  final String title, description, image;
  final int price;

  Details_product({
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context){
    int _count = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget> [
          IconButton(
            icon: SvgPicture.asset("icons/cart.svg", color: Colors.black), onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Shopping_cart(
                )
            ));
          },
          ),
          SizedBox(width: kDefaultPadding / 2)
        ],
      ),
      // detail info for the product that the user has selected
      body: Center(
        child:
          Column(
            children: [
              // product image
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(kDefaultPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child:  Image.asset(
                      image,
                      height: 10,
                      width: 200,
                      fit: BoxFit.fitWidth,
                    )
                ),
              ),
              // product price
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children:[
                      TextSpan(text: "Price\n"),
                      TextSpan(
                        text: "\$${price}\n",
                        style: TextStyle(fontSize: 30 ,color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
      // add to shopping cart -button-
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Add to shopping cart',
        child: const Icon(Icons.add),
      ),
    );
  }




}