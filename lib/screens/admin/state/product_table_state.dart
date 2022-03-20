import 'dart:convert';

import 'package:advanced_datatable/datatable.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../apis/request.dart';
import '../../../models/category.dart';
import '../../../models/product.dart';
import '../../../models/page_data.dart';
import '../../../models/product_table.dart';
import '../../../routes/router.gr.dart';
import '../component/product_manage_body.dart';

class ProductTableState extends State<ProductManageBody> {
  late Future<PageData<Product>> fProducts;
  late Future<List<Category>> fCategories;
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  var sortIndex = 1;
  var sortAsc = true;
  final searchController = TextEditingController();
  var customFooter = true;
  late ProductTableSource source;

  Future<List<Category>> getCategories() async {
    var response = await Request.get('/Category');
    final List list = jsonDecode(response.body);
    return list.map((c) => Category.fromJson(c)).toList();
  }

  @override
  void initState() {
    super.initState();
    fCategories = getCategories();
    source = ProductTableSource(
      onClickDetails: (productId) => context.router.push(
        AdminProductRouter(
          children: [AdminProductDetail(productId: productId)],
        ),
      ),
    );
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
                          source.filterServerSide(searchController.text),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    searchController.text = '';
                    sortIndex = 1;
                    sortAsc = true;
                    source.filterServerSide(searchController.text);
                  },
                  icon: const Icon(Icons.clear),
                ),
                IconButton(
                  onPressed: () =>
                      source.filterServerSide(searchController.text),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            AdvancedPaginatedDataTable(
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
            )
          ],
        ),
      );
    }
  }
}
