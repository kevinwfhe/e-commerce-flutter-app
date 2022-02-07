import 'package:flutter/material.dart';

import 'package:csi5112group1project/constants.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child:  Image.asset(
                  image,
                  height: 50,
                  width: 200,
                  fit: BoxFit.fitWidth,
                )
              ),
          ),

        ],
      ),

    );
  }


}