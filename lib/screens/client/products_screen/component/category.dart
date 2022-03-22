import 'package:flutter/material.dart';
import 'dart:convert';

import '../../../../constants.dart';
import '../../../../apis/request.dart';
import '../../../../models/category.dart' as cate;

class Category extends StatefulWidget {
  final Function onCategoryChanged;
  const Category({
    Key? key,
    required this.onCategoryChanged,
  }) : super(key: key);

  @override
  _categoryState createState() => _categoryState();
}

class _categoryState extends State<Category> {
  // Future<List<cate.Category>> getCategories() async {
  //   var response = await Request.get('/Category');
  //   final List list = jsonDecode(response.body);
  //   return list.map((c) => cate.Category.fromJson(c)).toList();
  // }

  // late List<cate.Category> list;

  // void getAllCate() async {
  //   late Future<List<cate.Category>> fCategories = getCategories();
  //   list = await fCategories;
  // }

  List<String> categories = [
    "All",
    "Shoes",
    "Clothes",
    "Electronics",
    "Toys",
    "Food"
  ];

  // The default category is All
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    // getAllCate();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = index;
          widget.onCategoryChanged(selectedCategory.toString());
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedCategory == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPadding / 4), //top padding 5
              height: 2,
              width: 30,
              color:
                  selectedCategory == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
