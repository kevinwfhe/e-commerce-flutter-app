import 'package:csi5112group1project/context/cart_context.dart';
import 'package:csi5112group1project/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:csi5112group1project/models/Cart.dart';
import 'package:csi5112group1project/screens/component/body_cart.dart';

class Shopping_cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartContext(),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: const [
              Text("Shopping cart"),
            ],
          ),
        ),
        body: Stack(
          children: [
            Body(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 96,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: CartConsumer(
                  builder: (context, cart, child) => Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Row(
                            // Placeholder Checkbox
                            // TODO: need a stateful widget to toggle the checkbox
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (checked) => print('check'),
                              ),
                              const Text('Sellect All')
                            ]),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('Total:'),
                                Text('\$${cart.totalPrice}'),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutScreen(cart: cart.cart),
                            ),
                          ),
                          child: const Text('Checkout'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
