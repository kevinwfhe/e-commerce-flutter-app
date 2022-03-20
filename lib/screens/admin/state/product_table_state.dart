import 'dart:convert';

import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import '../../../apis/request.dart';
import '../../../models/product.dart';
import '../../../models/product_table.dart';
import '../component/product_manage_body.dart';

class ProductTableState extends State<ProductManageBody> {
  late Future<List<Product>> fProducts;
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  var sortIndex = 0;
  var sortAsc = true;
  final searchController = TextEditingController();
  var customFooter = true;

  Future<List<Product>> getProducts() async {
    var response = await Request.get('/Product');
    final List list = jsonDecode(response.body);
    return list.map((p) => Product.fromJson(p)).toList();
  }

  @override
  void initState() {
    super.initState();
    fProducts = getProducts();
  }

  void setSort(int i, bool asc) => setState(
        () {
          sortIndex = i;
          sortAsc = asc;
        },
      );

  @override
  Widget build(BuildContext context) {
    {
      return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search by title',
                      ),
                      onSubmitted: (vlaue) {},
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      searchController.text = '';
                    });
                  },
                  icon: const Icon(Icons.clear),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            FutureBuilder(
              future: fProducts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final products = snapshot.data as List<Product>;
                  final source = ProductTableSource(
                    context: context,
                    data: products,
                  );
                  return AdvancedPaginatedDataTable(
                    addEmptyRows: false,
                    source: source,
                    sortAscending: sortAsc,
                    sortColumnIndex: sortIndex,
                    showFirstLastButtons: true,
                    rowsPerPage: 10,
                    availableRowsPerPage: const [10, 20, 30, 50],
                    onRowsPerPageChanged: (newRowsPerPage) {
                      if (newRowsPerPage != null) {
                        setState(() {
                          rowsPerPage = newRowsPerPage;
                        });
                      }
                    },
                    columns: [
                      DataColumn(
                        label: const Text('No.'),
                        numeric: true,
                        onSort: setSort,
                      ),
                      DataColumn(
                        label: const Text('Name'),
                        onSort: setSort,
                      ),
                      DataColumn(
                        label: const Text('category'),
                        onSort: setSort,
                      ),
                      DataColumn(
                        label: const Text('price'),
                        onSort: setSort,
                      ),
                      // DataColumn(
                      //   label: const Text('size'),
                      //   onSort: setSort,
                      // ),
                      // DataColumn(
                      //   label: const Text('picture'),
                      //   onSort: setSort,
                      // ),
                      DataColumn(
                        label: const Text('view detail'),
                        onSort: setSort,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Text('Error');
                }
                return const Text('Loading');
              },
            ),
          ],
        ),
      );
    }
  }
}
