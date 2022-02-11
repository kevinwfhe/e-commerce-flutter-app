import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Cart.dart';

class CartContext extends ChangeNotifier {
  final List<Cart> _cart = demoCarts;

  UnmodifiableListView<Cart> get cart => UnmodifiableListView(_cart);

  int get totalPrice => _cart
      .map((item) => item.product.price * item.numOfItem)
      .reduce((value, element) => value + element);

  void add(Cart cart) {
    _cart.add(cart);
    notifyListeners();
  }

  void remove(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }
}

class CartConsumer extends StatelessWidget {
  const CartConsumer({required this.builder, Key? key}) : super(key: key);
  final Widget Function(BuildContext, CartContext, Widget?) builder;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartContext>(builder: builder);
  }
}
