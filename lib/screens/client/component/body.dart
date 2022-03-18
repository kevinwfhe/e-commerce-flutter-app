import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import '../../../routes/router.gr.dart';
import './category.dart';
import './item_card.dart';

class Body extends StatelessWidget {
  final Future<List<Product>> fProducts;
  const Body({Key? key, required this.fProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Category(),
        FutureBuilder<List>(
            future: fProducts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    child: GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: kDefaultPadding,
                        crossAxisSpacing: kDefaultPadding,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final Product product = snapshot.data![index];
                        return ItemCard(
                          key: ValueKey(product.id),
                          product: product,
                          onTap: () => context.router.navigate(
                            ProductDetailRoute(
                              productId: product.id,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return const Text('error');
              }
              return const Text('loading...');
            }),
      ],
    );
  }
}
