import 'package:csi5112group1project/screens/common/component/on_hover.dart';
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
    return Container(
      height: 50,
      width: 600,
      padding: const EdgeInsets.symmetric(horizontal: 128),
      decoration: const BoxDecoration(color: Color(0xFF232f3e)),
      child: Center(
        child: FutureBuilder(
          future: widget.fCategory,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var categories = snapshot.data as List<Category>;
              categories = [Category(id: '', name: 'All'), ...categories];
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                      categories.map<Widget>((c) => buildCategory(c)).toList(),
                ),
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

  Widget buildCategory(Category c) {
    return OnHover(
      builder: ((isHovered) => GestureDetector(
            onTap: () => onTapCategory(c.id),
            child: Row(
              children: [
                Text(
                  c.name,
                  style: TextStyle(
                    fontSize: 16,
                    color: isHovered || (selectedCategoryId == c.id)
                        ? Colors.white
                        : kTextLightColor,
                  ),
                ),
                const SizedBox(
                  width: 30,
                )
              ],
            ),
          )),
    );
  }
}
