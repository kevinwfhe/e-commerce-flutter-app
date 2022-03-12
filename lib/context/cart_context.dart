import 'package:csi5112group1project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartContext extends ChangeNotifier {
  final Cart _cart = mockCart;

  Cart get instance => _cart;
  List<CartItem> get items => _cart.items;
  bool get allSelected => _cart.items.every((i) => i.selected);

  int get totalPrice {
    var selectedItems = _cart.items.where((item) => item.selected);
    if (selectedItems.isNotEmpty) {
      return selectedItems
          .map((item) => item.product.price * item.numOfItem)
          .reduce((value, element) => value + element);
    } else {
      return 0;
    }
  }

  void add(Product product) {
    var itemAdded = _cart.items.where((i) => i.product.id == product.id);
    if (itemAdded.isNotEmpty) {
      itemAdded.first.numOfItem += 1;
    } else {
      var itemToBeAdded = CartItem(
        numOfItem: 1,
        product: product,
        selected: true,
      );
      _cart.items.add(itemToBeAdded);
    }
    notifyListeners();
  }

  void subtract(int productId) {
    var itemToSubtract =
        _cart.items.firstWhere((i) => i.product.id == productId);
    itemToSubtract.numOfItem -= 1;
    notifyListeners();
  }

  void remove(int productId) {
    var itemToRemove = _cart.items.firstWhere((i) => i.product.id == productId);
    _cart.items.remove(itemToRemove);
    notifyListeners();
  }

  void select(int productId) {
    var itemToSelect = _cart.items.firstWhere((i) => i.product.id == productId);
    itemToSelect.selected = !itemToSelect.selected;
    notifyListeners();
  }

  void selectAll(boolValue) {
    if (_cart.items.isNotEmpty) {
      _cart.items.forEach((i) => i.selected = boolValue);
      notifyListeners();
    }
  }

  void clear() {
    _cart.items.clear();
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
