import './product.dart';

class Client {
  final String userId, username, password, firstName, lastName;
  final List<Product>? orderHistory;
  Client({
    required this.userId,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.orderHistory,
  });
}

Client mockClient = Client(
    userId: "test123",
    username: "group1",
    password: "123123",
    firstName: "firstname",
    lastName: "lastname",
    orderHistory: products.sublist(0, 4));
