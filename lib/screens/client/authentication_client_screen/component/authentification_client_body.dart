import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/models/authentication_body.dart';
import 'package:csi5112group1project/screens/client/sign_up_screen/sign_up_screen.dart';
import '../../../../apis/request.dart';
import '../../../../routes/router.gr.dart';
import 'package:flutter/material.dart';

class AuthentificationBuyerBody extends StatefulWidget {
  const AuthentificationBuyerBody({Key? key}) : super(key: key);

  @override
  _AuthentificationBuyerBodyState createState() =>
      _AuthentificationBuyerBodyState();
}

class _AuthentificationBuyerBodyState extends State<AuthentificationBuyerBody> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    usernameController.text = 'dilchenko1@jiathis.com';
    passwordController.text = 'doI6vF';
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
              child: Image(
                image: AssetImage('assets/images/logo.jpg'),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
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
            // ElevatedButton(
            //   child: const Text("Send Code"),
            //   onPressed: () {},
            // ),
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
                final body = AuthenticationBody(
                  username: usernameController.text,
                  password: passwordController.text,
                );
                Request.post('/Authentication/client', jsonEncode(body))
                    .then((response) {
                  if (response.statusCode == 200) {
                    context.navigateTo(
                      const ClientMainRoute(),
                    );
                  }
                }).catchError((error) {
                  print(error);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(loginFailedSnackBar);
                });
              },
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text('New User?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const SignUpScreen()));
                      print('create account');
                    },
                    child: const Text('Sign Up'),
                  )
                ],
              ),
              const Text('|'),
              TextButton(
                onPressed: () => context.navigateTo(
                  const AdminRouter(
                    children: [
                      AdminLoginRoute(),
                    ],
                  ),
                ),
                child: const Text('Admin Login'),
              )
            ],
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
