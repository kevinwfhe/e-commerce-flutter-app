class AuthenticationBody {
  String username, password;
  AuthenticationBody({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password
    };
  }
}
