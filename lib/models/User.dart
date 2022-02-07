import 'package:csi5112group1project/models/Product.dart';
import 'package:flutter/material.dart';

class User {
  final String userId, username, password, firstName, lastName;
  final List<Product>? orderHistory;
  User({
    required this.userId,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.orderHistory,
  });
}

User mockUser = User(
    userId: "test123",
    username: "group1",
    password: "123123",
    firstName: "firstname",
    lastName: "lastname",
    orderHistory: products.sublist(0, 4));
