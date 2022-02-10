
import '../constants.dart';

class User {
  String email, password, role;
  User({
    required this.email,
    required this.password,
    required this.role,
  });
}

List<User> users = [
  User(
    email: "admin@test.com",
    password: "123",
    role: adminRole
  ),
  User(
    email: "client@test.com",
    password: "321",
    role: clientRole
  ),
  ];