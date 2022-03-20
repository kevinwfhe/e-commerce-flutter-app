import 'package:auto_route/auto_route.dart';
import '../../../routes/router.gr.dart';
import 'package:flutter/material.dart';

class AuthentificationBuyerBody extends StatelessWidget {
  const AuthentificationBuyerBody({Key? key}) : super(key: key);

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
          const SizedBox(height: 30),
          SizedBox(
            height: 50,
            width: 300,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () => context.navigateTo(
                const ClientMainRoute(),
              ),
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
