import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/models/page_data.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import '../../../routes/router.gr.dart';
import './category.dart';
import './item_card.dart';

class Body extends StatelessWidget {
  final Function onCategoryChange;
  Future<PageData<Product>> fProducts;
  Body({
    Key? key,
    required this.fProducts,
    required this.onCategoryChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Category(onCategoryChanged: onCategoryChange),
        FutureBuilder(
            future: fProducts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data as PageData<Product>;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    child: GridView.builder(
                      itemCount: products.rows.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: kDefaultPadding,
                        crossAxisSpacing: kDefaultPadding,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final Product product = products.rows[index];
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
