import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import '../component/product_detail_manage_body.dart';
import '../../../utils/base64.dart';

class ProductDetailTableState extends State<ProductDetailManageBody> {
  final productTitleController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  final productSizeController = TextEditingController();
  final productNewCategoryController = TextEditingController();

  String dropdownValue = 'electronic';
  Uint8List? pickedImage;

  @override
  void initState() {
    super.initState();
    pickedImage = null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.fProduct,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data as Product;
            return ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 5,
                          ),
                          child: Text('Product Title'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 5,
                          ),
                          child: SizedBox(
                            width: 250,
                            child: TextField(
                              controller: productTitleController
                                ..text = product.title,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter product title/name'),
                            ),
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 5,
                        ),
                        child: Text('Product Description'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 155),
                        child: SizedBox(
                            width: 250,
                            child: TextField(
                              maxLines: null,
                              controller: productDescriptionController
                                ..text = product.description,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter product Description',
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 5,
                        ),
                        child: Text('Product Price'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 196),
                        child: SizedBox(
                            width: 250,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: productPriceController
                                ..text = product.price.toString(),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter product price',
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 5,
                        ),
                        child: Text('Product Size'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 200),
                        child: SizedBox(
                            width: 250,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: productSizeController
                                ..text = product.size?.toString() ?? "",
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter product size',
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 5,
                          ),
                          child: Text('Product Category'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 170),
                          child: SizedBox(
                              width: 250,
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: const TextStyle(
                                  color: Colors.deepPurple,
                                ),
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
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ),
                            child: const Text(
                              'Add new category',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 5),
                        child: Text('Product Picture'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 5,
                        ),
                        child: Visibility(
                            child: pickedImage != null
                                ? Image.memory(pickedImage!)
                                : Image.memory(
                                    base64ImageToUint8List(product.image))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: SizedBox(
                          width: 250,
                          child: TextButton(
                            onPressed: () async {
                              Uint8List? fromPicker =
                                  await ImagePickerWeb.getImageAsBytes();
                              setState(() {
                                pickedImage = fromPicker;
                              });
                            },
                            child: const Text(
                              'Pick new image',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => {print('update product')},
                        child: Text('Update product'),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('error');
          }
          return const Text('Loading...');
        });
  }
}
