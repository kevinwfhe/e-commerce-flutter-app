import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/models/authentication.dart';
import 'package:csi5112group1project/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../apis/request.dart';
import '../../../../context/user_context.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrlKey = GlobalKey<FormFieldState>();
  final _passwordCtrlKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    super.initState();
    usernameController.text = 'jellum0@netlog.com';
    passwordController.text = 'Hlua5QW';
    usernameController.addListener(() {
      if (usernameController.text != '') {
        _usernameCtrlKey.currentState!.validate();
      }
    });
    passwordController.addListener(() {
      if (passwordController.text != '') {
        _passwordCtrlKey.currentState!.validate();
      }
    });
  }

  void signin() async {
    if (_formKey.currentState!.validate()) {
      final body = AuthenticationRequestBody(
        username: usernameController.text,
        password: passwordController.text,
      );
      var response = await Request.post('/login', jsonEncode(body));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        var res = AuthenticationResponseBody.fromJson(jsonBody);
        var user = Provider.of<UserContext>(context, listen: false);
        await user.setUser(res.jwtToken, res.user);
        context.navigateTo(const AdminMainRoute());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(loginFailedSnackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Form(
        key: _formKey,
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
                key: _usernameCtrlKey,
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
                validator: (value) {
                  if (usernameController.text.isEmpty) {
                    return 'Please enter your email address or usernmae.';
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 300,
              child: TextFormField(
                key: _passwordCtrlKey,
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
                validator: (value) {
                  if (passwordController.text.isEmpty) {
                    return 'Please enter your password.';
                  }
                },
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
                onPressed: signin,
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
      ),
    );
  }
}

const loginFailedSnackBar = SnackBar(
    content: Text(
  'Your authentication information is incorrect. Please try again.',
  textAlign: TextAlign.center,
));
