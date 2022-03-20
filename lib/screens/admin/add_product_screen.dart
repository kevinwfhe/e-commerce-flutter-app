import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'package:csi5112group1project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../models/category.dart';
import '../../apis/request.dart';
import '../../utils/base64.dart';

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

  Future<http.Response> createProduct(Product product) async {
    return Request.post(
      '/Product',
      jsonEncode(product),
    );
  }

  void addProduct() async {
    // TODO: input validation
    var newProduct = Product(
      id: '',
      image: pickedImage != null ? uint8ListToBase64Image(pickedImage!) : '',
      title: titleController.text,
      price: double.parse(priceController.text),
      description: descriptionController.text,
      category: seletedCategoryId!,
    );
    // since Product.size is not a required property
    // we should set it conditionally
    if (sizeController.text != '') {
      newProduct.size = double.parse(sizeController.text);
    }
    var response = await createProduct(newProduct);
    if (response.statusCode == 201) {
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

  void reset() {
    titleController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    sizeController.text = '';
    newCategoryController.text = '';
    fCategories.then((categories) {
      if (categories.isNotEmpty) {
        seletedCategoryId = categories[0].id;
      } else {
        seletedCategoryId = '';
      }
    });
    setState(() {
      pickedImage = null;
    });
  }

  @override
  void initState() {
    super.initState();
    fCategories = getCategories();
    fCategories.then((categories) {
      if (categories.isNotEmpty) {
        seletedCategoryId = categories[0].id;
      } else {
        seletedCategoryId = '';
      }
    });
    titleController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    sizeController.text = '';
    newCategoryController.text = '';
    pickedImage = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Padding(
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
                  const SizedBox(width: 130, child: Text('Product price')),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              )),
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
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => {
                                addNewCategory(newCategoryController.text),
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
                      onPressed: () => addProduct(),
                      child: const Text('Add product'),
                    ),
                  ),
                  const SizedBox(width: 50),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => reset(),
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
