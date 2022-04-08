import 'dart:convert';

import 'package:csi5112group1project/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../apis/request.dart';
import '../models/user.dart';

Future<User?> _initUser() async {
  User? initUser;
  var token = await storage.read(key: "token");
  if (token == null) {
    initUser = null;
    return initUser;
  } else {
    var res = await Request.get('/user');
    if (res.statusCode == 200) {
      var user = User.fromJson(jsonDecode(res.body));
      initUser = user;
    } else {
      initUser = null;
    }
    return initUser;
  }
}

class UserContext extends ChangeNotifier {
  User? _user;

  UserContext() {
    storage.read(key: "token").then((token) {
      if (token == null) {
        _user = null;
      } else {
        Request.get('/user').then((res) {
          if (res.statusCode == 200) {
            var user = User.fromJson(jsonDecode(res.body));
            _user = user;
          } else {
            _user = null;
          }
          // notify the listners to rerender no matter the validation success or not
          notifyListeners();
        });
      }
    });
  }
  User? get instance => _user;
  bool get exist => _user != null;
  String? get username => _user?.username;
  String? get emailAddress => _user?.emailAddress;
  String? get role => _user?.role;
  String? get id => _user?.userId;

  Future<void> setUser(String token, User user) async {
    await storage.write(key: 'token', value: token);
    _user = user;
    notifyListeners();
  }

  Future<void> clear() async {
    await storage.delete(key: "token");
    _user = null;
    notifyListeners();
  }
}

class UserConsumer extends StatelessWidget {
  const UserConsumer({required this.builder, Key? key}) : super(key: key);
  final Widget Function(BuildContext, UserContext, Widget?) builder;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: builder);
  }
}
