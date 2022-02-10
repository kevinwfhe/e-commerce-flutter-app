import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import 'admin_screen.dart';
import 'component/product_manage_body.dart';
import 'product_detail_manage_screen.dart';

class ProductManageScreen extends StatelessWidget {
  const ProductManageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Default sort';

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Product list"),
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
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProductDetailManageScreen()));
              },
              child: const Text(
                'Create New',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            SizedBox(width: kDefaultPadding / 2)
          ],
        ),
        body: ProductManageBody());
  }
}
