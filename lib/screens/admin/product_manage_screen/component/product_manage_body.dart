import 'dart:convert';

import 'package:advanced_datatable/datatable.dart';
import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/screens/common/component/loading_indicator.dart';
import 'package:flutter/material.dart';
import '../../../../apis/request.dart';
import '../../../../models/category.dart';
import 'product_table.dart';
import '../../../../routes/router.gr.dart';

class ProductManageBody extends StatefulWidget {
  const ProductManageBody({Key? key}) : super(key: key);

  @override
  State<ProductManageBody> createState() => ProductTableState();
}

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
      updateSource: () => setState(() {}),
    );
  }

  void deleteAll() async {
    var productIdToDelete = _source.selectedIds;
    var response = await Request.post(
      '/Product/BatchDelete',
      jsonEncode(productIdToDelete),
    );
    if (response.statusCode == 204) {
      _source.clearSelectedRow();
      _source.setNextView();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(requestFailedSnackbar);
    }
  }

  @override
  void initState() {
    super.initState();
    fTableSource = initSource();
    fTableSource.then((source) => _source = source);
    searchController.text = '';
  }

  void setSort(int i, bool asc) {
    setState(() {
      sortIndex = i;
      sortAsc = asc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: fTableSource,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AdvancedPaginatedDataTable(
                  // To use loading indicator of the future builder
                  // add a placeholder for the AdvancedTable component
                  loadingWidget: () => const Text(''),
                  source: _source,
                  sortAscending: sortAsc,
                  sortColumnIndex: sortIndex,
                  showFirstLastButtons: true,
                  showCheckboxColumn: true,
                  rowsPerPage: rowsPerPage,
                  availableRowsPerPage: const [10, 15, 20],
                  onRowsPerPageChanged: (newRowsPerPage) {
                    if (newRowsPerPage != null) {
                      setState(() {
                        rowsPerPage = newRowsPerPage;
                      });
                    }
                  },
                  header: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              labelText:
                                  'Search by product name or description',
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
                  actions: [
                    ElevatedButton(
                      onPressed:
                          _source.selectedRowCount == 0 ? null : deleteAll,
                      child: const Text('Delete'),
                    ),
                    ElevatedButton(
                      onPressed: () => _source.setNextView(),
                      child: const Text('Refresh'),
                    )
                  ],
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
                      label: const Text('Category'),
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
              return const LoadingIndicator();
            },
          )
        ],
      ),
    );
  }
}

const requestFailedSnackbar = SnackBar(
  content: Text(
    'Service unavailable, please try again later.',
    textAlign: TextAlign.center,
  ),
);
