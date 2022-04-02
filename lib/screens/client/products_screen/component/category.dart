import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../models/category.dart';

class CategorySelector extends StatefulWidget {
  final Function onCategoryChanged;
  Future<List<Category>> fCategory;
  CategorySelector({
    Key? key,
    required this.fCategory,
    required this.onCategoryChanged,
  }) : super(key: key);

  @override
  CategorySelectorState createState() => CategorySelectorState();
}

class CategorySelectorState extends State<CategorySelector> {
  late String selectedCategoryId;

  @override
  void initState() {
    super.initState();
    selectedCategoryId = "-1";
  }

  void onTapCategory(String categoryId) {
    setState(() {
      selectedCategoryId = categoryId;
    });
    widget.onCategoryChanged(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    // getAllCate();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: SizedBox(
        height: 50,
        child: FutureBuilder(
          future: widget.fCategory,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var categories = snapshot.data as List<Category>;
              categories = [Category(id: '', name: 'All'), ...categories];
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) =>
                    buildCategory(index, categories),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const Text("Error");
            }
            return const Text('Loading...');
          },
        ),
      ),
    );
  }

  Widget buildCategory(int index, List<Category> categories) {
    return GestureDetector(
      onTap: () => onTapCategory(categories[index].id),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedCategoryId == categories[index].id
                    ? kTextColor
                    : kTextLightColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: kDefaultPadding / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedCategoryId == categories[index].id
                  ? Colors.black
                  : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
