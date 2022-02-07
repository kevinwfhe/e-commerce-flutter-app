import 'package:csi5112group1project/models/Client.dart';

//merchant
class Customer {
  final String userId, username, password, firstName, lastName;
  final List<Client>? clients;
  Customer({
    required this.userId,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.clients,
  });
}

Customer mockSeller = Customer(
    userId: "test123",
    username: "admin",
    password: "123123",
    firstName: "firstname",
    lastName: "lastname",
    clients: [mockClient]);
