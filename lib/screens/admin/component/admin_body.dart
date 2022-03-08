import 'package:flutter/material.dart';
import '../invoice_screen.dart';
import '../product_manage_screen.dart';

class AdminBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 20),
            child: Center(
              child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('images/logo.jpg')),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 20),
            child: Center(
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductManageScreen()));
                  },
                  child: const Text(
                    'Check Product',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 20),
            child: Center(
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => InvoiceScreen()));
                  },
                  child: const Text(
                    'Check Orders',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 130,
          ),
        ],
      ),
    );
  }
}
