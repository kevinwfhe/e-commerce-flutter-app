import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'package:csi5112group1project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../apis/request.dart';
import '../../constants.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final sizeController = TextEditingController();
  final newCategoryController = TextEditingController();
  late Future<List<String>> fCategories;

  String seletedCategory = 'Electronic';
  bool _isVisible = false;
  Uint8List? pickedImage;

  Future<List<String>> getCategories() async {
    List<String> categories = ['Shoe', 'Clothes', 'Toy', 'Food', 'Electronic'];
    return Future(() => categories);
  }

  Future<http.Response> createProduct(Product product) async {
    return Request.post(
      '/Product',
      jsonEncode(product),
    );
  }

  String uint8ListToBase64Image(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    String header = "data:image/png;base64,";
    return header + base64String;
  }

  void addProduct() async {
    var newProduct = Product(
        id: '',
        image: pickedImage != null ? uint8ListToBase64Image(pickedImage!) : '',
        title: titleController.text,
        price: double.parse(priceController.text),
        description: descriptionController.text,
        category: seletedCategory,
        size: int.parse(sizeController.text));
    var response = await createProduct(newProduct);
    if (response.statusCode == 201) {
      context.popRoute();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Product created',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fCategories = getCategories();
    titleController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    sizeController.text = '';
    newCategoryController.text = '';
    pickedImage = null;
    _isVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: ListView(
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
                        controller: titleController,
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
                        controller: descriptionController,
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
                        controller: priceController,
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
                        controller: sizeController,
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
                  FutureBuilder(
                    future: fCategories,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var categories = snapshot.data as List<String>;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 170),
                          child: SizedBox(
                              width: 250,
                              child: DropdownButton<String>(
                                value: seletedCategory,
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
                                    seletedCategory = newValue as String;
                                  });
                                },
                                items: categories
                                    .map((String value) =>
                                        DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ))
                                    .toList(),
                              )),
                        );
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text('Error');
                      }
                      return Text('Loading');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: TextButton(
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('New Category Name'),
                          content: TextField(
                            controller: newCategoryController,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding * 5),
                  child: Text('Product Picture'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 5,
                  ),
                  child: Visibility(
                    // visible: _isVisible,
                    child: _isVisible
                        ? Image.memory(pickedImage!)
                        : TextButton(
                            onPressed: () async {
                              Uint8List? fromPicker =
                                  await ImagePickerWeb.getImageAsBytes();

                              setState(() {
                                pickedImage = fromPicker;
                                _isVisible = true;
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
              ],
            ),
          ),
          TextButton(
            onPressed: () => addProduct(),
            child: const Text('Add product'),
          )
        ],
      ),
    );
  }
}
