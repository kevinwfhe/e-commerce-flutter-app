import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/screens/client/component/authentification_buyer_body.dart';
import 'package:flutter/material.dart';

import '../../apis/request.dart';
import '../../models/client.dart';
import '../../routes/router.gr.dart';
import 'authentification_buyer_screen.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final usernameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordCheckController = TextEditingController();
  @override
  void initState() {
    super.initState();
    usernameController.text = '';
    emailAddressController.text = '';
    passwordController.text = '';
    passwordCheckController.text = '';
  }

  void signUp() async {
    if (passwordController.text != passwordCheckController.text) {
      return;
    }
    Client newClient = Client(
      userId: '',
      username: usernameController.text,
      password: passwordController.text,
      emailAddress: emailAddressController.text,
    );
    Request.post('/Authentication', jsonEncode(newClient)).then((response) {
      if (response.statusCode == 200) {
        context.navigateTo(const ClientMainRoute());
      }
    }).catchError((error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(loginFailedSnackBar);
    });
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
                labelText: 'UserName',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                  color: Color.fromARGB(255, 93, 93, 93),
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.name,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: emailAddressController,
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
          const SizedBox(height: 15),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: passwordCheckController,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
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
              onPressed: () => signUp(),
              child: const Text(
                'Sign Up',
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
