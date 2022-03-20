import 'package:csi5112group1project/models/client.dart';

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
