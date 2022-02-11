import 'package:csi5112group1project/screens/order_placed_screen.dart';
import 'package:csi5112group1project/screens/shipping_screen.dart';
import 'package:flutter/material.dart';
import '../models/Cart.dart';
import '../models/shipping_address.dart';
import './component/shipping_address.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({required this.cart, Key? key}) : super(key: key);
  final List<Cart> cart;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Place Your Order'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(64),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16, top: 16),
                      child: const Text(
                        '1  Shipping Address',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Card(
                  child: ShippingAddressSection(
                    onTapCallback: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ShippingScreen(),
                      ),
                    ),
                    shippingAddress: ShippingAddress(
                      fullName: 'Kevin He',
                      phoneNumber: '4001234321',
                      address: '75 Laurier Ave. East',
                      city: 'Ottawa',
                      province: 'Ontario',
                      postalCode: 'K1N 6N5',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16, top: 16),
                      child: const Text(
                        '2  Review Items',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Card(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: CheckoutTable(cart: cart),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Order Total:  \$${cart.map((e) => e.product.price * e.numOfItem).reduce((value, element) => value + element).toString()}',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFA12B16)),
                        ),
                      ],
                    ),
                    Container(
                      height: 64,
                      width: 192,
                      margin: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OrderPlacedScreen(),
                            ),
                          ),
                        },
                        child: const Text(
                          'Place your order',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class CheckoutTable extends StatelessWidget {
  const CheckoutTable({required this.cart, Key? key}) : super(key: key);
  final List<Cart> cart;
  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowHeight: 150,
      columns: const <DataColumn>[
        DataColumn(label: Text('Item')),
        DataColumn(label: Text('Price')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Subtotal')),
      ],
      rows: cart
          .map((prod) => DataRow(
                cells: [
                  DataCell(
                    Row(
                      children: [
                        Container(
                          width: 88,
                          margin: const EdgeInsets.only(right: 32),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              // padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                              decoration:
                                  const BoxDecoration(color: Color(0xFFF5F6F9)),
                              child: Image.asset(
                                prod.product.image,
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                        Text(prod.product.title)
                      ],
                    ),
                  ),
                  DataCell(Text(prod.product.price.toString())),
                  DataCell(Text(prod.numOfItem.toString())),
                  DataCell(Text('${prod.numOfItem * prod.product.price}'))
                ],
              ))
          .toList(),
    );
  }
}
