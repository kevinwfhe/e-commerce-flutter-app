import 'dart:convert';

import 'user.dart';

class AuthenticationRequestBody {
  String username, password;
  AuthenticationRequestBody({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {"username": username, "password": password};
  }
}

class AuthenticationResponseBody {
  User user;
  String jwtToken;
  AuthenticationResponseBody({
    required this.user,
    required this.jwtToken,
  });

  AuthenticationResponseBody.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']),
        jwtToken = json['jwtToken'];
}
