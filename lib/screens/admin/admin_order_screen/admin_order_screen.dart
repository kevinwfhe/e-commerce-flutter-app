import 'package:flutter/material.dart';
import 'component/admin_order_body.dart';

class AdminOrderScreen extends StatelessWidget {
  const AdminOrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Orders"),
        ),
        body: const AdminOrderBody());
  }
}
