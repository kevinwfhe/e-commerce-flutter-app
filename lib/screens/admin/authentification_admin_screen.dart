import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import './component/authentification_admin_body.dart';

class AuthentificationAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("icons/back.svg", color: Colors.black),
          onPressed: () => context.router.pop()
        ), // icon - - back
        actions: const <Widget>[SizedBox(width: kDefaultPadding / 2)],
      ),
      body: AuthentificationAdminBody(),
    );
  }
}
