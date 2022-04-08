import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../routes/router.gr.dart';
import '../../../constants.dart';
import 'component/authentification_client_body.dart';

class AuthentificationClientScreen extends StatelessWidget {
  const AuthentificationClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F1111),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.navigateTo(const MainRoute()),
        ),
        actions: const <Widget>[SizedBox(width: kDefaultPadding / 2)],
      ),
      body: const AuthentificationBuyerBody(),
    );
  }
}
