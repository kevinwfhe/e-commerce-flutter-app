import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/screens/client/authentification_buyer_screen.dart';
import 'package:csi5112group1project/screens/client/sign_up_body.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../routes/router.gr.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AuthentificationBuyerScreen()));
          },
        ),
        actions: const <Widget>[SizedBox(width: kDefaultPadding / 2)],
      ),
      body: const SignUpBody(),
    );
  }
}
