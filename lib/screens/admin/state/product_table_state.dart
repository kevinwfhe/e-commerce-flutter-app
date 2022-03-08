import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import '../../../models/product_table.dart';
import '../component/product_manage_body.dart';

class ProductTableState extends State<ProductManageBody> {
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  var sortIndex = 0;
  var sortAsc = true;
  final searchController = TextEditingController();
  var customFooter = true;

  void setSort(int i, bool asc) => setState(() {
        sortIndex = i;
        sortAsc = asc;
      });

  @override
  Widget build(BuildContext context) {
    final source = ProductTableSource(context: context);
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
                DataColumn(
                  label: const Text('ID'),
                  numeric: true,
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('title'),
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('description'),
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
                DataColumn(
                  label: const Text('size'),
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('picture'),
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('view detail'),
                  onSort: setSort,
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
