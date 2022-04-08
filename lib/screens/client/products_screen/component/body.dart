import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/models/page_data.dart';
import 'package:csi5112group1project/screens/common/component/loading_indicator.dart';
import 'package:csi5112group1project/screens/common/component/no_content.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../models/product.dart';
import '../../../../routes/router.gr.dart';
import '../../../../models/category.dart';
import 'item_card.dart';
import 'category.dart';

class ProductScreenBody extends StatelessWidget {
  final Function onCategoryChange;
  late Future<PageData<Product>> fProducts;
  late Future<List<Category>> fCategory;
  ProductScreenBody({
    Key? key,
    required this.fProducts,
    required this.fCategory,
    required this.onCategoryChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Expanded(
                child: CategorySelector(
                  fCategory: fCategory,
                  onCategoryChanged: onCategoryChange,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: FutureBuilder(
              future: fProducts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final products = snapshot.data as PageData<Product>;
                  if (products.totalRows == 0) {
                    return NoContent(
                      icon: Icons.search_off_outlined,
                      message:
                          'Didn\'t find what you want? Search another keyword!',
                    );
                  }
                  return Container(
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        bottom: 100,
                        left: MediaQuery.of(context).size.width * 0.2,
                        right: MediaQuery.of(context).size.width * 0.2,
                      ),
                      itemCount: products.rows.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
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
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Text('error');
                }
                return const LoadingIndicator();
              }),
        ),
      ],
    );
  }
}
