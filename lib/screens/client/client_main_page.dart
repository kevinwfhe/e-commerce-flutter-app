import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../routes/router.gr.dart';

class ClientMainPage extends StatelessWidget {
  const ClientMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      backgroundColor: Colors.indigo,
      routes: const [
        ProductRoute(),
        CartRoute(),
        OrderRouter(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Products',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.reorder),
              label: 'Order',
              backgroundColor: Colors.purple,
            ),
          ],
          currentIndex: tabsRouter.activeIndex,
          selectedItemColor: Colors.amber[800],
          onTap: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
