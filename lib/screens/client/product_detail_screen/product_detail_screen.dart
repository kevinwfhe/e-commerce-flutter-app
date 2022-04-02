import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import '../../../apis/request.dart';
import '../../../context/cart_context.dart';
import '../../../routes/router.gr.dart';
import '../../../models/product.dart';
import '../../../constants.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({
    Key? key,
    @PathParam() required this.productId,
  }) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Product> fProduct;
  Future<Product> getProduct() async {
    var response = await Request.get('/Product/${widget.productId}');
    var res = Product.fromJson(jsonDecode(response.body));
    return res;
  }

  @override
  void initState() {
    super.initState();
    fProduct = getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartContext(),
      child: CartConsumer(
        builder: (context, cart, child) => FutureBuilder<Product>(
          future: fProduct,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              Product product = snapshot.data as Product;
              return Scaffold(
                appBar: AppBar(
                  title: Text(product.title),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.popRoute(),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined),
                      onPressed: () =>
                          context.router.push(const StandAloneCartRoute()),
                    ),
                    const SizedBox(width: kDefaultPadding / 2)
                  ],
                ),

                body: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      height: MediaQuery.of(context).size.height,
                      child: Image.network('$s3BaseUrl${product.image}'),
                    ),
                    SizedBox(
                      width: 440,
                      child: Container(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Roboto',
                                letterSpacing: 0.5,
                                fontSize: 30,
                              ),
                            ),
                            Row(
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
                            Row(
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
                                  "\$${product.price}",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.5,
                                    fontSize: 16,
                                  ),
                                ),
                              ], // end reviews
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
                              product.description,
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
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const Text('error');
            }
            return const Text('');
          }),
        ),
      ),
    );
  }
}
