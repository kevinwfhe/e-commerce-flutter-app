import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../routes/router.gr.dart';
import '../../constants.dart';
import './component/authentification_buyer_body.dart';

class AuthentificationBuyerScreen extends StatelessWidget {
  const AuthentificationBuyerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("icons/back.svg", color: Colors.black),
          onPressed: () => context.navigateTo(const ClientMainRoute()),
        ),
        actions: const <Widget>[SizedBox(width: kDefaultPadding / 2)],
      ),
      body: const AuthentificationBuyerBody(),
    );
  }
}
