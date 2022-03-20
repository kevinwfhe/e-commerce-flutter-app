import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../routes/router.gr.dart';
import 'authentification_buyer_screen.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AuthentificationBuyerScreen()));
              },
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
