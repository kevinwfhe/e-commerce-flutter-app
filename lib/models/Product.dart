import 'package:flutter/material.dart';

class Product {
  final String id, image, title, description, category;
  final double price;
  double? size;
  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    this.size,
  });

  Product.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        image = json['image'],
        title = json['title'],
        price = json['price'],
        description = json['description'],
        size = json['size'],
        category = json['category'];

  Map<String, dynamic> toJson() {
    var res = {
      'id': id,
      'image': image,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
    };
    if (size != null) {
      res['size'] = size!;
    }
    return res;
  }
}

// Manually add 15 items, 3 categories and 5 for each.

String des =
    "BEST SHOES EVER.\n A shoe is an item of footwear intended to protect and comfort the human foot. Shoes are also used as an item of decoration and fashion. ... Traditionally, shoes have been made from leather, wood or canvas, but are increasingly being made from rubber, plastics, and other petrochemical-derived materials.";
List<Product> products = [
  Product(
      id: '1',
      title: "Addis Runner",
      price: 233,
      size: 9,
      description: des,
      image: "images/shoe1.png",
      category: "shoe"),
  Product(
      id: '2',
      title: "NB runner",
      price: 198,
      size: 8,
      description: des,
      image: "images/shoe2.png",
      category: "shoe"),
  Product(
      id: '3',
      title: "Nike Runner",
      price: 456,
      size: 7,
      description: des,
      image: "images/shoe3.png",
      category: "shoe"),
  Product(
      id: '4',
      title: "Champion Runner",
      price: 150,
      size: 8,
      description: des,
      image: "images/shoe4.png",
      category: "shoe"),
  Product(
      id: '5',
      title: "Addis sliper",
      price: 99,
      size: 11,
      description: des,
      image: "images/shoe5.png",
      category: "shoe"),
  Product(
      id: '6',
      title: "Baby hooded sweater",
      price: 79,
      size: 6,
      description: des,
      image: "images/cloth1.png",
      category: "clothes"),
  Product(
      id: '7',
      title: "Baby cloth",
      price: 45,
      size: 3,
      description: des,
      image: "images/cloth2.png",
      category: "clothes"),
  Product(
      id: '8',
      title: "High rise pant",
      price: 199,
      size: 8,
      description: des,
      image: "images/cloth3.png",
      category: "clothes"),
  Product(
      id: '9',
      title: "Mountain jacket",
      price: 46,
      size: 12,
      description: des,
      image: "images/cloth4.png",
      category: "clothes"),
  Product(
      id: '10',
      title: "Spider jacket",
      price: 666,
      size: 11,
      description: des,
      image: "images/cloth5.png",
      category: "clothes"),
  Product(
      id: '11',
      title: "Samsung Computer",
      price: 249,
      size: 0,
      description: des,
      image: "images/electric1.png",
      category: "electronic"),
  Product(
      id: '12',
      title: "Samsung Watch",
      price: 229,
      size: 0,
      description: des,
      image: "images/electric2.png",
      category: "electronic"),
  Product(
      id: '13',
      title: "Canon EOS R5 Camera",
      price: 4999,
      size: 0,
      description: des,
      image: "images/electric3.png",
      category: "electronic"),
  Product(
      id: '14',
      title: "Nintendo Switch",
      price: 319,
      size: 0,
      description: des,
      image: "images/electric4.png",
      category: "electronic"),
  Product(
      id: '15',
      title: "Guild Guitar",
      price: 666,
      size: 0,
      description: des,
      image: "images/electric5.png",
      category: "electronic"),
  Product(
      id: '16',
      title: "Jellycat Cloud Plush",
      price: 24,
      size: 0,
      description: des,
      image: "images/toy1.png",
      category: "toy"),
  Product(
      id: '17',
      title: "Hill's Science Dog Food",
      price: 68,
      size: 0,
      description: des,
      image: "images/food1.png",
      category: "food"),
];
