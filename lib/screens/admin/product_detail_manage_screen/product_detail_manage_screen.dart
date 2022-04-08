import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../../apis/request.dart';
import '../../../constants.dart';
import '../../../models/category.dart';
import '../../../models/product.dart';
import '../../../utils/base64.dart';

class ProductDetailManageScreen extends StatefulWidget {
  final String productId;
  const ProductDetailManageScreen({
    Key? key,
    @PathParam() required this.productId,
  }) : super(key: key);

  @override
  _ProductDetailManageScreenState createState() =>
      _ProductDetailManageScreenState();
}

class _ProductDetailManageScreenState extends State<ProductDetailManageScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final sizeController = TextEditingController();
  final newCategoryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _titelCtrlKey = GlobalKey<FormFieldState>();
  final _descCtrlKey = GlobalKey<FormFieldState>();
  final _priceCtrlKey = GlobalKey<FormFieldState>();

  late Future<Product> fProduct;
  late Future<List<Category>> fCategories;
  String? seletedCategoryId;
  Uint8List? pickedImage;

  Future<Product> getProduct() async {
    var response = await Request.get('/Product/${widget.productId}');
    var product = Product.fromJson(jsonDecode(response.body));
    return product;
  }

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
    setState(() {
      newCategoryController.text = '';
    });
  }

  void deleteProduct() async {
    var response = await Request.delete('/Product/${widget.productId}');
    if (response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(deleteSuccessSnackBar);
      context.popRoute();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(operationFailedSnackBar);
    }
  }

  void updateProduct() async {
    if (_formKey.currentState!.validate()) {
      Product originProduct = await fProduct;
      Product productToUpdate = Product(
        id: originProduct.id,
        image: pickedImage != null
            ? uint8ListToBase64Image(pickedImage!)
            : originProduct.image,
        title: titleController.text,
        price: double.parse(priceController.text),
        description: descriptionController.text,
        category: seletedCategoryId ?? originProduct.category,
      );
      if (sizeController.text != '') {
        productToUpdate.size = double.parse(sizeController.text);
      }
      var response = await Request.put(
        '/Product/${widget.productId}',
        jsonEncode(productToUpdate),
      );
      if (response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(updateSuccessSnackBar);
        context.router.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(operationFailedSnackBar);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    pickedImage = null;
    fCategories = getCategories();
    fProduct = getProduct();
    fProduct.then((product) async {
      var categories = await fCategories;
      bool ifCategoryIdExist =
          categories.map((c) => c.id).contains(product.category);
      seletedCategoryId = ifCategoryIdExist ? product.category : '';
      titleController.text = product.title;
      descriptionController.text = product.description;
      priceController.text = product.price.toString();
      sizeController.text = product.size != null ? product.size.toString() : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAdminBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => context.popRoute(),
          icon: const Icon(
            Icons.arrow_back,
            color: kAdminPrimaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(const Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                spreadRadius: .3,
                blurRadius: .3,
                blurStyle: BlurStyle.outer,
              )
            ],
          ),
          padding: const EdgeInsets.all(32),
          child: FutureBuilder(
            future: fProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final product = snapshot.data as Product;
                return Padding(
                  padding: const EdgeInsets.all(32),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              const SizedBox(
                                  width: 130, child: Text('Product name')),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  width: 600,
                                  child: TextFormField(
                                    key: _descCtrlKey,
                                    minLines: 3,
                                    maxLines: 3,
                                    controller: descriptionController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter product description',
                                    ),
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
                              const SizedBox(
                                  width: 130, child: Text('Product price')),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    key: _priceCtrlKey,
                                    keyboardType: TextInputType.number,
                                    controller: priceController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText:
                                          'Enter product price (per unit)',
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
                              const SizedBox(
                                  width: 130, child: Text('Product size')),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                    var categories =
                                        snapshot.data as List<Category>;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SizedBox(
                                        width: 300,
                                        child: DropdownButton<String>(
                                          hint: const Text(
                                              'No category to select'),
                                          value: seletedCategoryId,
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.blue,
                                          ),
                                          onChanged: (newValue) {
                                            setState(() {
                                              seletedCategoryId =
                                                  newValue as String;
                                            });
                                          },
                                          items: categories
                                              .map((Category category) =>
                                                  DropdownMenuItem<String>(
                                                    value: category.id,
                                                    child: SizedBox(
                                                      width: 270,
                                                      child:
                                                          Text(category.name),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: TextButton(
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: pickedImage != null
                                    ? Image.memory(
                                        pickedImage!,
                                        height: 150,
                                      )
                                    : Image.network(
                                        '$s3BaseUrl${product.image}',
                                        height: 150,
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
                                  child: const Text('Update'),
                                ),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                height: 50,
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      content: const Text(
                                          'You are deleting this product.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => {
                                            deleteProduct(),
                                            Navigator.pop(context)
                                          },
                                          child: const Text('Confirm'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Colors.red, // set the background color
                                  ),
                                  child: const Text('Delete'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return const Text('error');
              }
              return const Text('Loading...');
            },
          ),
        ),
      ),
    );
  }
}

const updateSuccessSnackBar = SnackBar(
    content: Text(
  'Product updated.',
  textAlign: TextAlign.center,
));

const deleteSuccessSnackBar = SnackBar(
    content: Text(
  'Product deleted.',
  textAlign: TextAlign.center,
));

const operationFailedSnackBar = SnackBar(
    content: Text(
  'Service unavailable, please try again later.',
  textAlign: TextAlign.center,
));

const categoryExistSnackBar = SnackBar(
  content: Text(
    'Category already exist!',
    textAlign: TextAlign.center,
  ),
);
