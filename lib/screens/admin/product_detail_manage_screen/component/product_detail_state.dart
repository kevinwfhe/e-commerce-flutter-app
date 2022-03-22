import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../../../apis/request.dart';
import '../../../../constants.dart';
import '../../../../models/category.dart';
import '../../../../models/product.dart';
import 'product_detail_manage_body.dart';
import '../../../../utils/base64.dart';

class ProductDetailTableState extends State<ProductDetailManageBody> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final sizeController = TextEditingController();
  final newCategoryController = TextEditingController();
  late Future<List<Category>> fCategories;
  String? seletedCategoryId;
  Uint8List? pickedImage;

  Future<List<Category>> getCategories() async {
    var response = await Request.get('/Category');
    final List list = jsonDecode(response.body);
    return list.map((c) => Category.fromJson(c)).toList();
  }

  void addNewCategory(categoryName) async {
    Category newCategory = Category(id: '', name: categoryName);
    var response = await Request.post('/Category', jsonEncode(newCategory));
    if (response.statusCode == 201) {
      String newCategoryId = Category.fromJson(jsonDecode(response.body)).id;
      setState(() {
        fCategories = getCategories();
        // select the newly created category
        fCategories.then((categories) => seletedCategoryId = newCategoryId);
      });
    }
  }

  void updateProduct() async {
    // var response = await Request.put('/Product/${widget.')
    print('update product');
  }

  @override
  void initState() {
    super.initState();
    fCategories = getCategories();
    widget.fProduct.then((product) {
      seletedCategoryId = product.category;
      titleController.text = product.title;
      descriptionController.text = product.description;
      priceController.text = product.price.toString();
      sizeController.text = product.size != null ? product.size.toString() : '';
      pickedImage = base64ImageToUint8List(product.image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.fProduct,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data as Product;
            return Padding(
              padding: const EdgeInsets.all(32),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        const SizedBox(width: 130, child: Text('Product name')),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: 300,
                            child: TextField(
                              controller: titleController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter product name',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(
                          width: 130,
                          child: Text('Product description'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                              width: 600,
                              child: TextField(
                                maxLines: null,
                                controller: descriptionController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter product description',
                                ),
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(
                            width: 130, child: Text('Product price')),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                              width: 300,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: priceController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter product price (per unit)',
                                ),
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 130, child: Text('Product size')),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                              width: 300,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: sizeController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter product size',
                                ),
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(
                          width: 130,
                          child: Text('Product category'),
                        ),
                        FutureBuilder(
                          future: fCategories,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var categories = snapshot.data as List<Category>;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  width: 300,
                                  child: DropdownButton<String>(
                                    value: seletedCategoryId,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                    ),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        seletedCategoryId = newValue as String;
                                      });
                                    },
                                    items: categories
                                        .map((Category category) =>
                                            DropdownMenuItem<String>(
                                              value: category.id,
                                              child: SizedBox(
                                                width: 270,
                                                child: Text(category.name),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              print(snapshot.error);
                              return const Text('Error');
                            }
                            return const Text('Loading');
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: TextButton(
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Category Name'),
                                content: TextField(
                                  controller: newCategoryController,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      addNewCategory(
                                          newCategoryController.text),
                                      Navigator.pop(context)
                                    },
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
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: 130,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Product picture'),
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: pickedImage != null
                              ? Image.memory(
                                  pickedImage!,
                                  height: 150,
                                )
                              : TextButton(
                                  onPressed: () async {
                                    Uint8List? fromPicker =
                                        await ImagePickerWeb.getImageAsBytes();
                                    setState(() {
                                      pickedImage = fromPicker;
                                    });
                                  },
                                  child: const Text(
                                    'Upload image (.png only)',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () => updateProduct(),
                            child: const Text('Update product'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('error');
          }
          return const Text('Loading...');
        });
  }
}
