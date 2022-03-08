import 'package:flutter/material.dart';
import '../../common/login_screen.dart';
import '../../admin/authentification_admin_screen.dart';
import '../../client/authentification_buyer_screen.dart';

class LoginState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  redirectAdmin() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => AuthentificationAdminScreen()));
  }

  redirectClient() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => AuthentificationBuyerScreen()));
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
                      redirectAdmin();
                    },
                    child: const Text(
                      'Login as Admin',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
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
                      redirectClient();
                    },
                    child: const Text(
                      'Login as Client(buyer)',
                      style: TextStyle(color: Colors.white, fontSize: 15),
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