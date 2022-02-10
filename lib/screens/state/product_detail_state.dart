import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../constants.dart';
import '../../models/Product.dart';
import '../component/product_detail_manage_body.dart';

class ProductDetailTableState extends State<ProductDetailManageBody> {
  final productTitleController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  final productSizeController = TextEditingController();
  final productNewCategoryController = TextEditingController();

  String dropdownValue = 'electronic';
  bool _isVisible = true;
  Image? pickedImage = null;

  //ProductDetailManageBody({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
            height: 50,
            child: Row(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding * 5),
                  child: Text('Product Title'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 5),
                  child: Container(
                      width: 250,
                      child: TextField(
                        controller: productTitleController
                          ..text = widget.product?.title ?? "",
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter product title/name'),
                      )),
                )
              ],
            )),
        Container(
            height: 150,
            child: Row(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding * 5),
                  child: Text('Product Description'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 155),
                  child: Container(
                      width: 250,
                      child: TextField(
                        maxLines: null,
                        controller: productDescriptionController
                          ..text = widget.product?.description ?? "",
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter product Description'),
                      )),
                )
              ],
            )),
        Container(
            height: 50,
            child: Row(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding * 5),
                  child: Text('Product Price'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 196),
                  child: Container(
                      width: 250,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: productPriceController
                          ..text = widget.product?.price.toString() ?? "",
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter product price'),
                      )),
                )
              ],
            )),
        Container(
            height: 150,
            child: Row(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding * 5),
                  child: Text('Product Size'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200),
                  child: Container(
                      width: 250,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: productSizeController
                          ..text = widget.product?.size.toString() ?? "",
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter product size'),
                      )),
                )
              ],
            )),
        Container(
            height: 100,
            child: Row(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding * 5),
                  child: Text('Product Category'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 170),
                  child: Container(
                      width: 250,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>[
                          'shoe',
                          'clothes',
                          'toy',
                          'food',
                          'electronic'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: TextButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('New Category Name'),
                        content: TextField(
                          onChanged: (value) {},
                          controller: productNewCategoryController,
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    child: const Text(
                      'Add new category',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ),
              ],
            )),
        Container(
            height: 150,
            child: Row(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding * 5),
                  child: Text('Product Picture'),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding * 5),
                  child: Visibility(
                      visible: _isVisible,
                      child: pickedImage ??
                          Image.asset(widget.product?.image ??
                              "images/No_image_available.png")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Container(
                    width: 250,
                    child: TextButton(
                      onPressed: () async {
                        Image? fromPicker =
                            await ImagePickerWeb.getImageAsWidget();
                      },
                      child: const Text(
                        'Pick new image',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }
}
