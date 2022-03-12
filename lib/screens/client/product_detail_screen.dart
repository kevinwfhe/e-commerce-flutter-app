import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import '../../context/cart_context.dart';
import '../../routes/router.gr.dart';
import '../../models/product.dart';
import '../../models/cart.dart';
import '../../constants.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    Key? key,
    @PathParam() required this.productId,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.product,
  }) : super(key: key);
  final String title, description, image;
  final int price, productId;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartContext(),
      child: CartConsumer(
        builder: (context, cart, child) => Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: <Widget>[
              IconButton(
                icon: SvgPicture.asset("icons/cart.svg", color: Colors.black),
                onPressed: () =>
                    context.router.push(const StandAloneCartRoute()),
              ),
              const SizedBox(width: kDefaultPadding / 2)
            ],
          ),

          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .5,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    scale: .5,
                    image: AssetImage(image),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: 440,
                child: Container(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.5,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.5,
                          fontSize: 30,
                        ),
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
                            const Text(
                              '4.1 (170 Reviews)',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                letterSpacing: 0.5,
                                fontSize: 15,
                              ),
                            ),
                          ], // end reviews
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            const Text(
                              "\n\nPrice: \n\n",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Roboto',
                                letterSpacing: 0.5,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "\$${price}",
                              style: const TextStyle(
                                color: Colors.red,
                                fontFamily: 'Roboto',
                                letterSpacing: 0.5,
                                fontSize: 16,
                              ),
                            ),
                          ], // end reviews
                        ),
                      ),
                      const Text(
                        "Product Description",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.5,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.5,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // add to shopping cart -button-
          floatingActionButton: FloatingActionButton(
            onPressed: () => cart.add(product),
            tooltip: 'Add to shopping cart',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
