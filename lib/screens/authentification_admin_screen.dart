import 'package:flutter/material.dart';
import 'package:csi5112group1project/constants.dart';
import 'package:flutter_svg/svg.dart';

import 'login_screen.dart';
import 'component/authentification_admin_body.dart';

class AuthentificationAdminScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("icons/back.svg", color: Colors.black),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          },
        ), // icon - - back
        actions: <Widget>[SizedBox(width: kDefaultPadding / 2)],
      ),
      body: AuthentificationAdminBody(),
    );
  }
}