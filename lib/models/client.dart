import './product.dart';

class Client {
  final String userId, username, password, emailAddress;
  // final List<Product>? orderHistory;
  Client({
    required this.userId,
    required this.username,
    required this.password,
    required this.emailAddress,
    // required this.firstName,
    // required this.lastName,
    // this.orderHistory,
  });

  Client.fromJson(Map<dynamic, dynamic> json)
      : userId = json['id'],
        username = json['name'],
        password = json['password'],
        emailAddress = json['emailAddress'];

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'username': username,
      'password': password,
      'emailAddress': emailAddress
    };
  }
}
