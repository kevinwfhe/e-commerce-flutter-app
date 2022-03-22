import 'dart:convert';

import 'package:advanced_datatable/datatable.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../apis/request.dart';
import '../../../../models/category.dart';
import '../../../../models/product.dart';
import '../../../../models/page_data.dart';
import '../../../../models/product_table.dart';
import '../../../../routes/router.gr.dart';
import 'product_manage_body.dart';

class ProductTableState extends State<ProductManageBody> {
  late Future<ProductTableSource> fTableSource;
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  var sortIndex = 1;
  var sortAsc = true;
  final searchController = TextEditingController();
  var customFooter = true;
  late ProductTableSource _source;

  Future<List<Category>> getCategories() async {
    var response = await Request.get('/Category');
    final List list = jsonDecode(response.body);
    return list.map((c) => Category.fromJson(c)).toList();
  }

  Future<ProductTableSource> initSource() async {
    var categories = await getCategories();
    return ProductTableSource(
      categories: {for (var c in categories) c.id: c.name},
      onClickDetails: (productId) => context.router.push(
        AdminProductRouter(
          children: [
            AdminProductDetail(productId: productId),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fTableSource = initSource();
    fTableSource.then((source) => _source = source);
    searchController.text = '';
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
                        labelText: 'Search by title or description',
                      ),
                      onSubmitted: (value) =>
                          _source.filterServerSide(searchController.text),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    searchController.text = '';
                    sortIndex = 1;
                    sortAsc = true;
                    _source.filterServerSide(searchController.text);
                  },
                  icon: const Icon(Icons.clear),
                ),
                IconButton(
                  onPressed: () =>
                      _source.filterServerSide(searchController.text),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            FutureBuilder(
                future: fTableSource,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final _source = snapshot.data as ProductTableSource;
                    return AdvancedPaginatedDataTable(
                      addEmptyRows: false,
                      source: _source,
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
                        const DataColumn(
                          label: Text('No.'),
                          numeric: true,
                        ),
                        DataColumn(
                          label: const Text('Name'),
                          onSort: setSort,
                        ),
                        DataColumn(
                          label: const Text('Category No.'),
                          onSort: setSort,
                        ),
                        DataColumn(
                          label: const Text('Price'),
                          onSort: setSort,
                        ),
                        const DataColumn(
                          label: Text(''),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text(snapshot.error.toString());
                  }
                  return Text('Loading...');
                })
          ],
        ),
      );
    }
  }
}
