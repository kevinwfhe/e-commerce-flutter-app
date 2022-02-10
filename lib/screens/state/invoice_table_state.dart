import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';

import '../../models/invoice_table.dart';
import '../component/invoice_body.dart';

class InvoiceTableState extends State<InvoiceBody> {
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
    final source = InvoiceTableSource(context: context);
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
                        labelText: 'Search by invoice/order',
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
                  label: const Text('Invoice ID'),
                  numeric: true,
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('Produce ID'),
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('product Title'),
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('Customer Name'),
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
                  label: const Text('Billing Address'),
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('Shipping Address'),
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
