import 'dart:convert';
import 'package:csi5112group1project/models/category.dart';
import 'package:flutter/material.dart';
import '../../../apis/request.dart';
import '../../../constants.dart';
import '../../../models/page_data.dart';
import '../../../models/product.dart';
import '../../common/component/loading_indicator.dart';
import '../../common/component/no_content.dart';

class CategoryManageScreen extends StatefulWidget {
  const CategoryManageScreen({Key? key}) : super(key: key);

  @override
  _CategoryManageScreenState createState() => _CategoryManageScreenState();
}

class _CategoryManageScreenState extends State<CategoryManageScreen> {
  late Future<List<Category>> fCategory;
  late Future<PageData<Product>> fProducts;
  late String selectedCategoryId;
  final newCategoryController = TextEditingController();
  final updateCategoryController = TextEditingController();
  final _newCtrlKey = GlobalKey<FormFieldState>();
  final _updateCtrlKey = GlobalKey<FormFieldState>();

  Future<List<Category>> getCategories() async {
    var response = await Request.get('/Category');
    var categories = jsonDecode(response.body) as List;
    return categories.map((q) => Category.fromJson(q)).toList();
  }

  Future<PageData<Product>> getProducts() async {
    if (selectedCategoryId.isEmpty) {
      return PageData(rows: [], totalRows: 0);
    }
    var response = await Request.get('/Product?category=$selectedCategoryId');
    return PageData<Product>.fromJson(jsonDecode(response.body));
  }

  void selectCategory(String selectedId) {
    if (selectedCategoryId == selectedId) return;
    setState(() {
      selectedCategoryId = selectedId;
      fProducts = getProducts();
    });
  }

  Future<bool> createCategory(Conte) async {
    if (_newCtrlKey.currentState!.validate()) {
      var categoryToCreate = Category(id: '', name: newCategoryController.text);
      var response =
          await Request.post('/Category', jsonEncode(categoryToCreate));
      if (response.statusCode == 201) {
        var newCategory = Category.fromJson(jsonDecode(response.body));
        setState(() {
          fCategory = getCategories();
          fCategory.then((categories) {
            selectedCategoryId = newCategory.id;
            fProducts = getProducts();
            newCategoryController.text = '';
          });
        });
        return true;
      } else {
        if (response.body == 'category exist') {
          ScaffoldMessenger.of(context).showSnackBar(categoryExistSnackbar);
        }
        return false;
      }
    }
    return false;
  }

  Future<bool> putCategory() async {
    if (_updateCtrlKey.currentState!.validate()) {
      var categoryToUpdate =
          Category(id: '', name: updateCategoryController.text);
      var response = await Request.put(
          '/Category/$selectedCategoryId', jsonEncode(categoryToUpdate));
      if (response.statusCode == 204) {
        setState(() {
          fCategory = getCategories();
          newCategoryController.text = '';
        });
        return true;
      } else {
        if (response.body == 'category exist') {
          ScaffoldMessenger.of(context).showSnackBar(categoryExistSnackbar);
        }
        return false;
      }
    }
    return false;
  }

  void deleteCategory() async {
    var response = await Request.delete('/Category/$selectedCategoryId');
    if (response.statusCode == 204) {
      setState(() {
        fCategory = getCategories();
        fCategory.then((categories) {
          if (categories.isNotEmpty) {
            selectedCategoryId = categories.first.id;
          } else {
            selectedCategoryId = '';
          }
          fProducts = getProducts();
        });
      });
    }
  }

  void addCategory() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Category Name'),
        content: TextFormField(
          key: _newCtrlKey,
          controller: newCategoryController,
          validator: (value) {
            if (newCategoryController.text.isEmpty) {
              return 'Please enter category name.';
            }
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              var res = await createCategory(context);
              if (res) Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void updateCategory() async {
    var categories = await fCategory;
    var selectedCategoryName =
        categories.firstWhere((c) => c.id == selectedCategoryId).name;
    setState(() {
      updateCategoryController.text = selectedCategoryName;
    });
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Category Name'),
        content: TextFormField(
          key: _updateCtrlKey,
          controller: updateCategoryController,
          validator: (value) {
            if (updateCategoryController.text.isEmpty) {
              return 'Please enter category name.';
            }
            if (updateCategoryController.text == selectedCategoryName) {
              return 'Please enter a new category name.';
            }
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              var res = await putCategory();
              if (res) Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void removeCategory() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text(
            'You are deleting this category, products under this category will stay around.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {deleteCategory(), Navigator.pop(context)},
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fCategory = getCategories();
    fCategory.then((categories) {
      if (categories.isNotEmpty) {
        selectedCategoryId = categories.first.id;
      } else {
        selectedCategoryId = '';
      }
      fProducts = getProducts();
    });
    newCategoryController.addListener(() {
      if (newCategoryController.text != '') {
        _newCtrlKey.currentState!.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          future: fCategory,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var categories = snapshot.data as List<Category>;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 300,
                          child: DropdownButton<String>(
                            hint: const SizedBox(
                              width: 270,
                              child: Text('No category to select'),
                            ),
                            value: selectedCategoryId,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.blue,
                            ),
                            onChanged: (newValue) => selectCategory(newValue!),
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
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: addCategory,
                                child: const Text('Add category'),
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              height: 40,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: selectedCategoryId.isEmpty
                                    ? null
                                    : updateCategory,
                                child: const Text('Update category'),
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              height: 40,
                              width: 200,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                onPressed: selectedCategoryId.isEmpty
                                    ? null
                                    : removeCategory,
                                child: const Text('Delete category'),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  FutureBuilder(
                    future: fProducts,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final products = snapshot.data as PageData<Product>;
                        if (categories.isEmpty) {
                          return NoContent(
                            icon: Icons.category_outlined,
                            message: 'Create a category first.',
                          );
                        }
                        if (products.rows.isEmpty && selectedCategoryId == '') {
                          return NoContent(
                            icon: Icons.category_outlined,
                            message: 'No category selected.',
                          );
                        }
                        if (products.rows.isEmpty) {
                          return NoContent(
                            icon: Icons.category_outlined,
                            message: 'No products under current category.',
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Products under the selected category:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 400,
                              child: SingleChildScrollView(
                                child: ProductTable(
                                  products: products.rows,
                                ),
                              ),
                            )
                          ],
                        );
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      return const LoadingIndicator();
                    },
                  )
                ],
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const Text('Error');
            }
            return const LoadingIndicator();
          },
        ),
      ),
    );
  }
}

class ProductTable extends StatelessWidget {
  const ProductTable({
    Key? key,
    required this.products,
  }) : super(key: key);
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowHeight: 120,
      headingRowHeight: 40,
      columns: <DataColumn>[
        DataColumn(label: Container()),
        const DataColumn(label: Text('Name')),
        const DataColumn(label: Text('Price')),
      ],
      rows: products
          .map(
            (item) => DataRow(
              cells: [
                DataCell(
                  Row(
                    children: [
                      Container(
                        width: 88,
                        margin: const EdgeInsets.only(right: 32),
                        child: AspectRatio(
                          aspectRatio: 0.88,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5F6F9),
                            ),
                            child: Image.network(
                              '$s3BaseUrl${item.image}',
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DataCell(Text(item.title)),
                DataCell(Text(item.price.toString())),
              ],
            ),
          )
          .toList(),
    );
  }
}

const categoryExistSnackbar = SnackBar(
    content: Text(
  'Category name already exist, please use another one.',
  textAlign: TextAlign.center,
));
