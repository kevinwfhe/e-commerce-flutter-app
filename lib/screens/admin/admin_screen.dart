import 'package:flutter/material.dart';
import '../../../constants.dart';
import './authentification_admin_screen.dart';
import './component/admin_body.dart';
// flutter pub add flutter_svg

class AdminScreen extends StatelessWidget {
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
                    builder: (_) => AuthentificationAdminScreen()));
          },
        ), // icon - - back
        actions: const <Widget>[SizedBox(width: kDefaultPadding / 2)],
      ),
      body: AdminBody(),
    );
  }
}
