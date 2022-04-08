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
  int _numberToAdd = 1;
  Future<Product> getProduct() async {
    var response = await Request.get('/Product/${widget.productId}');
    var res = Product.fromJson(jsonDecode(response.body));
    return res;
  }

  void addToCart(BuildContext context) async {
    var cart = Provider.of<CartContext>(context, listen: false);
    var productToAdd = await fProduct;
    cart.add(productToAdd, number: _numberToAdd);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${productToAdd.title} has been added to your cart.',
          textAlign: TextAlign.center,
        ),
      ),
    );
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
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: const Color(0xFF0F1111),
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

                body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .2,
                    vertical: MediaQuery.of(context).size.height * .05,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                '$s3BaseUrl${product.image}',
                                fit: BoxFit.fitWidth,
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Product Details',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                product.description,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  height: 1.8,
                                ),
                              )
                            ],
                          )),
                      const SizedBox(width: 50),
                      Container(
                        width: MediaQuery.of(context).size.width * .2,
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Chip(label: Text(product.category!)),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    product.title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.5,
                                      fontSize: 32,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Product Number:',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  product.id,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                const Text(
                                  "Price: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    fontSize: 36,
                                  ),
                                ),
                                Text(
                                  "\$${product.price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    fontSize: 36,
                                  ),
                                ),
                              ], // end reviews
                            ),
                            const SizedBox(height: 15),
                            const Divider(
                              height: 1,
                              thickness: 1.5,
                            ),
                            const SizedBox(height: 80),
                            Row(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    onPressed: () => setState(() {
                                      if (_numberToAdd == 1) return;
                                      _numberToAdd = _numberToAdd - 1;
                                    }),
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Text(
                                    _numberToAdd.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    onPressed: () => setState(() {
                                      _numberToAdd = _numberToAdd + 1;
                                    }),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              height: 50,
                              width: double.maxFinite,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xFF222222),
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
                            const SizedBox(height: 100),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    blurStyle: BlurStyle.outer,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.store),
                                      SizedBox(width: 10),
                                      Text(
                                        'Free In-Store Pickup',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    margin: const EdgeInsets.only(left: 35),
                                    child: const Text(
                                        'Available for Same-Day Pickup. Order now and pickup as early as today.'),
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(
                                    height: 1,
                                    thickness: 1.5,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: const [
                                      Icon(Icons.delivery_dining),
                                      SizedBox(width: 10),
                                      Text(
                                        'Home Delivery',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    margin: const EdgeInsets.only(left: 35),
                                    child: const Text(
                                        'Order now and get it delivered in 3-5 business days.'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // add to shopping cart -button-
                floatingActionButton: FloatingActionButton(
                  onPressed: () => addToCart(context),
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
