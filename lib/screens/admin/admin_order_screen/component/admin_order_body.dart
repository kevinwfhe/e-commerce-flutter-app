import 'package:advanced_datatable/datatable.dart';
import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/screens/common/component/loading_indicator.dart';
import 'package:flutter/material.dart';
import '../../../../routes/router.gr.dart';
import 'invoice_table.dart';

class AdminOrderBody extends StatefulWidget {
  const AdminOrderBody({Key? key}) : super(key: key);

  @override
  State<AdminOrderBody> createState() => OrderTableState();
}

class OrderTableState extends State<AdminOrderBody> {
  late Future<InvoiceTableSource> fTableSource;
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  var sortIndex = 1;
  var sortAsc = true;
  final searchController = TextEditingController();
  var customFooter = true;

  Future<InvoiceTableSource> initSource() async {
    return InvoiceTableSource(
      onClickDetails: (orderId) => context.router.push(
        AdminOrderRouter(
          children: [AdminOrderDetail(orderId: orderId)],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fTableSource = initSource();
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
        children: [
          FutureBuilder(
            future: fTableSource,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final _source = snapshot.data as InvoiceTableSource;
                return AdvancedPaginatedDataTable(
                  loadingWidget: () => const Text(''),
                  source: _source,
                  sortAscending: sortAsc,
                  sortColumnIndex: sortIndex,
                  showFirstLastButtons: true,
                  rowsPerPage: rowsPerPage,
                  availableRowsPerPage: const [10, 15, 20],
                  onRowsPerPageChanged: (newRowsPerPage) {
                    if (newRowsPerPage != null) {
                      setState(() {
                        rowsPerPage = newRowsPerPage;
                      });
                    }
                  },
                  actions: [
                    ElevatedButton(
                      onPressed: () => _source.setNextView(),
                      child: const Text('Refresh'),
                    )
                  ],
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              labelText: 'Search by order number or user id',
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
                  columns: [
                    const DataColumn(
                      label: Text('No.'),
                      numeric: true,
                    ),
                    DataColumn(
                      label: const Text('Status'),
                      onSort: setSort,
                    ),
                    DataColumn(
                      label: const Text('Create Time'),
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
                return const Text("Error");
              }
              return const LoadingIndicator();
            }),
          )
        ],
      ),
    );
  }
}
