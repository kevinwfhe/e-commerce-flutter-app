import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../apis/request.dart';
import '../../../../models/user.dart';
import '../../../../routes/router.gr.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrlKey = GlobalKey<FormFieldState>();
  final _emailAddressCtrlKey = GlobalKey<FormFieldState>();
  final _passwordCtrlKey = GlobalKey<FormFieldState>();
  final _passwordCheckCtrlKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    super.initState();
    usernameController.text = '';
    emailAddressController.text = '';
    passwordController.text = '';
    passwordCheckController.text = '';
    usernameController.addListener(() {
      if (usernameController.text != '') {
        _usernameCtrlKey.currentState!.validate();
      }
    });
    emailAddressController.addListener(() {
      if (emailAddressController.text != '') {
        _emailAddressCtrlKey.currentState!.validate();
      }
    });
    passwordController.addListener(() {
      if (passwordController.text != '') {
        _passwordCtrlKey.currentState!.validate();
      }
    });
    passwordCheckController.addListener(() {
      if (passwordCheckController.text != '') {
        _passwordCheckCtrlKey.currentState!.validate();
      }
    });
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      var newUser = SignUpUser(
        username: usernameController.text,
        password: passwordController.text,
        emailAddress: emailAddressController.text,
      );
      Request.post('/signup', jsonEncode(newUser)).then((response) {
        if (response.statusCode == 201) {
          context.navigateTo(const LoginRoute());
        }
        if (response.statusCode == 400) {
          if (response.body == 'username exist') {
            ScaffoldMessenger.of(context)
                .showSnackBar(usernameDuplicateSnackBar);
          }
          if (response.body == 'email exist') {
            ScaffoldMessenger.of(context).showSnackBar(emailDuplicateSnackBar);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                width: 300,
                height: 200,
                child: Image(image: AssetImage('assets/images/logo.jpg')),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        key: _usernameCtrlKey,
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
                        validator: (value) {
                          if (usernameController.text.isEmpty) {
                            return 'Please enter your usernmae.';
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        key: _emailAddressCtrlKey,
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
                        validator: (value) {
                          if (emailAddressController.text.isEmpty) {
                            return 'Please enter your email address';
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
                            return 'Please enter your password';
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        key: _passwordCheckCtrlKey,
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
                        validator: (value) {
                          if (passwordCheckController.text.isEmpty) {
                            return 'Please enter your password again';
                          }
                          if (passwordCheckController.text.isNotEmpty &&
                              passwordController.text !=
                                  passwordCheckController.text) {
                            return 'Passwords not match';
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

const usernameDuplicateSnackBar = SnackBar(
  content: Text(
    'Username already exist.',
    textAlign: TextAlign.center,
  ),
);

const emailDuplicateSnackBar = SnackBar(
  content: Text(
    'Eamil address already exist.',
    textAlign: TextAlign.center,
  ),
);
