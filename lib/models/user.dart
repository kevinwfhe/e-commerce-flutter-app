class User {
  final String userId, username, emailAddress, role;
  User({
    required this.userId,
    required this.username,
    required this.emailAddress,
    required this.role,
  });

  User.fromJson(Map<dynamic, dynamic> json)
      : userId = json['id'],
        username = json['username'],
        emailAddress = json['emailAddress'],
        role = json['role'];

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'username': username,
      'emailAddress': emailAddress,
      'role': role
    };
  }
}

class SignUpUser {
  final String userId, username, password, emailAddress, role;
  SignUpUser({
    this.userId = '',
    required this.username,
    required this.password,
    required this.emailAddress,
    this.role = 'client',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'username': username,
      'password': password,
      'emailAddress': emailAddress,
      'role': role
    };
  }
}
