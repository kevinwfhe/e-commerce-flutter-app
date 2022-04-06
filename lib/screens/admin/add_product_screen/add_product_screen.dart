import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:csi5112group1project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../../models/category.dart';
import '../../../apis/request.dart';
import '../../../utils/base64.dart';

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

  final _formKey = GlobalKey<FormState>();
  final _titelCtrlKey = GlobalKey<FormFieldState>();
  final _descCtrlKey = GlobalKey<FormFieldState>();
  final _priceCtrlKey = GlobalKey<FormFieldState>();

  String seletedCategoryId = '';
  Uint8List? pickedImage;
  bool creatingProduct = false;

  Future<List<Category>> getCategories() async {
    var response = await Request.get('/Category');
    final List list = jsonDecode(response.body);
    var res = list.map((c) => Category.fromJson(c)).toList();
    res.insert(0, Category(id: '', name: 'Choose a category'));
    return res;
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
    } else {
      if (response.body == 'category exist') {
        ScaffoldMessenger.of(context).showSnackBar(categoryExistSnackBar);
      }
    }
  }

  void addProduct() async {
    if (creatingProduct) return;
    if (_formKey.currentState!.validate()) {
      if (pickedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(imageRequiredSnackBar);
        return;
      }
      var newProduct = Product(
        id: '',
        image: pickedImage != null ? uint8ListToBase64Image(pickedImage!) : '',
        title: titleController.text,
        price: double.parse(priceController.text),
        description: descriptionController.text,
        category: seletedCategoryId,
      );
      // set it conditionally since Product.size is not a required property
      if (sizeController.text != '') {
        newProduct.size = double.parse(sizeController.text);
      }
      setState(() {
        creatingProduct = true;
      });
      var response = await Request.post(
        '/Product',
        jsonEncode(newProduct),
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(productCreatedSnackBar);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(operationFailedSnackBar);
      }
      setState(() {
        creatingProduct = false;
      });
    }
  }

  void reset() {
    setState(() {
      titleController.text = '';
      descriptionController.text = '';
      priceController.text = '';
      sizeController.text = '';
      newCategoryController.text = '';
      seletedCategoryId = '';
      pickedImage = null;
    });
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
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    const SizedBox(width: 130, child: Text('Product name')),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          key: _titelCtrlKey,
                          controller: titleController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter product name',
                          ),
                          validator: (value) {
                            if (titleController.text.isEmpty) {
                              return 'Please enter product name.';
                            }
                          },
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
                        child: TextFormField(
                          key: _descCtrlKey,
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter product description',
                          ),
                          minLines: 3,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          validator: (value) {
                            if (descriptionController.text.isEmpty) {
                              return 'Please enter product description.';
                            }
                          },
                        ),
                      ),
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
                        child: TextFormField(
                          key: _priceCtrlKey,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]')),
                          ],
                          keyboardType: TextInputType.number,
                          controller: priceController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter product price (per unit)',
                          ),
                          validator: (value) {
                            if (priceController.text.isEmpty) {
                              return 'Please enter product price.';
                            }
                          },
                        ),
                      ),
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
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9].')),
                          ],
                          keyboardType: TextInputType.number,
                          controller: sizeController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter product size',
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
                                hint: const Text('No category to select'),
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
                        return const CircularProgressIndicator();
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
                          onPressed: () =>
                              creatingProduct ? null : addProduct(),
                          child: Row(
                            children: [
                              const Text('Add product'),
                              if (creatingProduct) const SizedBox(width: 10),
                              if (creatingProduct)
                                const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          )),
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
      ),
    );
  }
}

const imageRequiredSnackBar = SnackBar(
    content: Text(
  'Product image is required.',
  textAlign: TextAlign.center,
));

const operationFailedSnackBar = SnackBar(
    content: Text(
  'Service unavailable, please try again later.',
  textAlign: TextAlign.center,
));

const productCreatedSnackBar = SnackBar(
  content: Text(
    'Product created!',
    textAlign: TextAlign.center,
  ),
);

const categoryExistSnackBar = SnackBar(
  content: Text(
    'Category already exist!',
    textAlign: TextAlign.center,
  ),
);
