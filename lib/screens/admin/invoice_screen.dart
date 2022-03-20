import 'package:flutter/material.dart';
import './component/invoice_body.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Invoice/order list"),
        ),
        body: const InvoiceBody());
  }
}
