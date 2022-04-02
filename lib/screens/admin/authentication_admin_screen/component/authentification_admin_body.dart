import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/models/authentication.dart';
import 'package:csi5112group1project/storage/storage.dart';
import 'package:flutter/material.dart';
import '../../../../apis/request.dart';
import '../../../../routes/router.gr.dart';

class AuthentificationAdminBody extends StatefulWidget {
  const AuthentificationAdminBody({Key? key}) : super(key: key);

  @override
  _AuthentificationAdminBodyState createState() =>
      _AuthentificationAdminBodyState();
}

class _AuthentificationAdminBodyState extends State<AuthentificationAdminBody> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    usernameController.text = 'jellum0@netlog.com';
    passwordController.text = 'Hlua5QW';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: <Widget>[
          const Center(
            child: SizedBox(
              width: 300,
              height: 200,
              child: Image(image: AssetImage('assets/images/logo.jpg')),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                  color: Color.fromARGB(255, 93, 93, 93),
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                  color: Color.fromARGB(255, 93, 93, 93),
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 50,
            width: 300,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                final body = AuthenticationRequestBody(
                  username: usernameController.text,
                  password: passwordController.text,
                );
                Request.post('/login', jsonEncode(body)).then((response) async {
                  if (response.statusCode == 200) {
                    var res = AuthenticationResponseBody.fromJson(
                        jsonDecode(response.body));
                    await storage.write(key: 'token', value: res.jwtToken);
                    context.navigateTo(
                      const AdminMainRoute(),
                    );
                  }
                }).catchError((error) {
                  print(error);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(loginFailedSnackBar);
                });
              },
              child: const Text(
                'Login In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const loginFailedSnackBar = SnackBar(
    content: Text(
  'Your authentication information is incorrect. Please try again.',
  textAlign: TextAlign.center,
));
