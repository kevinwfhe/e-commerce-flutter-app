import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../routes/router.gr.dart';

class AuthentificationAdminBody extends StatelessWidget {
  const AuthentificationAdminBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 300,
              height: 200,
              child: Image.asset('images/logo.jpg'),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 300,
            child: TextFormField(
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
              onPressed: () => context.navigateTo(
                const AdminMainRoute(),
              ),
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
