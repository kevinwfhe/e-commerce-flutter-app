import 'package:csi5112group1project/screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import 'component/invoice_body.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Invoice/order list"),
          leading: IconButton(
            icon: SvgPicture.asset("icons/back.svg", color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AdminScreen()));
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset("icons/search.svg", color: Colors.black),
              onPressed: () {},
            ),
            SizedBox(width: kDefaultPadding / 2)
          ],
        ),
        body: InvoiceBody());
  }
}
