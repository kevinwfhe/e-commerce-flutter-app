import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../routes/router.gr.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Placed'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 128,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  // navigate to order screen while poping the underlying routes back to CartRoute,
                  // to prevent another CartRoute stacking on top of the original one
                  onPressed: () => context.router.pushAndPopUntil(
                    const ClientMainRoute(
                      children: [
                        OrderRouter(
                          children: [
                            OrderScreen(),
                          ],
                        ),
                      ],
                    ),
                    predicate: (route) => route.settings.name == 'CartRoute',
                  ),
                  child: const Text('Check your orders', style: TextStyle(fontSize: 20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
