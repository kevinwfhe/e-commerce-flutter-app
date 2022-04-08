import 'package:csi5112group1project/context/cart_context.dart';
import 'package:csi5112group1project/screens/client/products_screen/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/router.gr.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => CartContext(),
        builder: (p1, cart) => const ProductsScreen(),
      ),
    );
  }
}
