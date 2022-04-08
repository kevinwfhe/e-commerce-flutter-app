import 'package:csi5112group1project/context/cart_context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';
import '../../../../models/product.dart';
import '../../../../constants.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function onTap;

  const ItemCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  void addToCart(BuildContext context) {
    var cart = Provider.of<CartContext>(context, listen: false);
    cart.add(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${product.title} has been added to your cart.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SizedBox(
                    child: Image.network(
                      '$s3BaseUrl${product.image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                product.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Text(
                "\$${product.price}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 150,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFF222222),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () => addToCart(context),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
