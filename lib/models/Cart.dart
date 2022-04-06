import 'product.dart';

class CartItem {
  final Product product;
  int numOfItem;
  bool selected;
  CartItem({
    required this.product,
    required this.numOfItem,
    this.selected = true,
  });
}

class Cart {
  final List<CartItem> items;
  Cart({required this.items});
}
