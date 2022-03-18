// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
//
// class CartItem {
//   final String productID, name, image;
//   final int quantity, price;
//
//   CartItem({
//     required this.productID,
//     required this.name,
//     required this.image,
//     required this.quantity,
//     required this.price,
//   });
// }
//
// class Cart with ChangeNotifier {
//   Map<String, CartItem> _items ={};
//
//   Map<String, CartItem> get items {
//     return {..._items};
//   }
//
//   int get itemQuantity {
//     return _items.length;
//   }
//
//   void addItem( String id, String name, int price, String img){
//     if(_items.containsKey(id)){
//       _items.update(id,
//               (existingCartItem)=> CartItem(
//                   productID: DateTime.now().toString(),
//                   name: existingCartItem.name,
//                   quantity: existingCartItem.quantity+1,
//                   image: existingCartItem.image,
//                   price: existingCartItem.price));
//     }else{
//       _items.putIfAbsent(id, ()=> CartItem(
//         name: name,
//         productID: DateTime.now().toString(),
//         image: img,
//         quantity: 1,
//         price: price,
//       ));
//     }
//   }
//
//   void removeItem(String id){
//     _items.remove(id);
//   }
//
//   // void removeSingleItem(String id){
//   //   if(_items[id].quantity>=2){
//   //     _items.update(id,(existingCartItem)=>CartItem(
//   //         productID: DateTime.now().toString(),
//   //         name: existingCartItem.name,
//   //         quantity: existingCartItem.quantity-1,
//   //         image: existingCartItem.image,
//   //         price: existingCartItem.price));
//   //   }else{
//   //     removeItem(id);
//   //   }
//   // }
//
//   void clearCart(){
//     _items={};
//   }
// }
//

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
