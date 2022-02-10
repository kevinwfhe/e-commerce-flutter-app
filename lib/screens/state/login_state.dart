import 'package:csi5112group1project/constants.dart';
import 'package:flutter/material.dart';
import '../../models/users.dart';
import '../admin_screen.dart';
import '../buyer_main_screen.dart';
import '../login_screen.dart';

class LoginState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  validUserAndRedirect() {
    final email = emailController.text;
    final pass = passwordController.text;
    if (users.any((user) =>
        user.email == email &&
        user.password == pass &&
        user.role == clientRole)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => Buyer_screen()));
    }

    if (users.any((user) =>
        user.email == email &&
        user.password == pass &&
        user.role == adminRole)) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AdminScreen()));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 20),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('images/logo.jpg')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 750),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@def.com'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 750),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 20),
              child: Center(
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      validUserAndRedirect();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            const Text('New User? Create Account')
          ],
        ),
      ),
    );
  }
}
