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
        backgroundColor: Color(0xFF0F1111),
      ),
      body: const AuthentificationAdminBody(),
    );
  }
}
