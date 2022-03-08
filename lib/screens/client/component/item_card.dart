import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import '../products_details_screen.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;

  const ItemCard({
    required this.product,
    required this.press,
  });

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Details_product(
                  product: product,
                  title: product.title,
                  price: product.price,
                  description: product.description,
                  image: product.image,
                )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${product.id}",
                child: Image.asset(product.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
            child: Text(
              // products is out demo list
              product.title,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\$${product.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
