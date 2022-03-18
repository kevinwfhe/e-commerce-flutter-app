import 'package:flutter/material.dart';
import '../../../context/cart_context.dart';
import './cart_item.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return CartConsumer(
      builder: (context, cart, child) => Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 100),
        // EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(cart.items[index].product.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) =>
                  cart.remove(cart.items[index].product.id),
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: CartCard(item: cart.items[index]),
            ),
          ),
        ),
      ),
    );
  }
}
