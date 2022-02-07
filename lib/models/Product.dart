import 'package:flutter/material.dart';


class Product {
  final String image, title, description, category;
  final int price, size, id;
  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.size,
    required this.category,
  });
}


// Manually add 15 items, 3 categories and 5 for each.

String des = "BEST SHOES EVER";
List<Product> products = [
  Product(
      id: 1,
      title: "Addis Runner",
      price: 233,
      size: 9,
      description: des,
      image: "images/shoe1.png",
      category: "shoe"
  ),

  Product(
      id: 2,
      title: "NB runner",
      price: 198,
      size: 8,
      description: des,
      image: "images/shoe2.png",
      category: "shoe"
  ),
  Product(
      id: 3,
      title: "Nike Runner",
      price: 456,
      size: 7,
      description: des,
      image: "images/shoe3.png",
      category: "shoe"
  ),
  Product(
      id: 4,
      title: "Champion Runner",
      price: 150,
      size: 8,
      description: des,
      image: "images/shoe4.png",
      category: "shoe"
  ),
  Product(
      id: 5,
      title: "Addis sliper",
      price: 99,
      size: 11,
      description: des,
      image: "images/shoe5.png",
      category: "shoe"
  ),
];