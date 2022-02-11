import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:csi5112group1project/models/Product.dart';
import 'package:csi5112group1project/constants.dart';
import 'package:csi5112group1project/screens/shopping_cart_screen.dart';
import 'package:csi5112group1project/models/Cart.dart';
class Details_product extends StatelessWidget {
  final String title, description, image;
  final int price;
  final Product product;

  Details_product({
    required this.product,
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

      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container (
            width: MediaQuery.of(context).size.width* .5,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(

                    scale: .5,
                    image: AssetImage(image),
                    fit: BoxFit.contain)),
          ),
          SizedBox(
            width: 440,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.category.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                        fontSize: 18,
                        )),
                  Text(title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                        fontSize: 30,
                        )
                  ),
                  Container(
                    child: Row(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.yellow[500]),
                            Icon(Icons.star, color: Colors.yellow[500]),
                            Icon(Icons.star, color: Colors.yellow[500]),
                            Icon(Icons.star, color: Colors.yellow[500]),
                            const Icon(Icons.star, color: Colors.grey),
                          ],
                        ),
                        Text(
                          '4.1 (170 Reviews)',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.5,
                            fontSize: 15,
                          ),
                        ),], // end reviews
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("\n\nPrice: \n\n", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.5,
                          fontSize: 15,
                        )),
                        Text(
                          "\$${price}",
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.5,
                            fontSize: 16,
                          ),
                        ),], // end reviews
                    ),
                  ),
                  Text("Product Description", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                    fontSize: 15,
                  )),
                  Text(description, style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                    fontSize: 13,
                  )),
                ],
              ),
            ),
          ),
        ],
      ),



      // add to shopping cart -button-
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          demoCarts.add(Cart(product: product, numOfItem:1));
          },
        tooltip: 'Add to shopping cart',
        child: const Icon(Icons.add),
      ),
    );
  }




}