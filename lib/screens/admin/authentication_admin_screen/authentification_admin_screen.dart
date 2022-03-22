import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import 'component/authentification_admin_body.dart';

class AuthentificationAdminScreen extends StatelessWidget {
  const AuthentificationAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.router.pop()), // icon - - back
        actions: const <Widget>[SizedBox(width: kDefaultPadding / 2)],
      ),
      body: const AuthentificationAdminBody(),
    );
  }
}
