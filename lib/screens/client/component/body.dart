import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import './category.dart';
import './item_card.dart';

class Body extends StatelessWidget {
  final Future<List<Product>> products;
  const Body({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Category(),
        FutureBuilder<List>(
            future: products,
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
                      itemBuilder: (context, index) => ItemCard(
                        product: snapshot.data![index],
                        press: () {},
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return const Text('error');
              }
              return const Text('loading');
            }),
      ],
    );
  }
}
