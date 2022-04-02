import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/models/page_data.dart';
import 'package:csi5112group1project/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../apis/request.dart';
import '../../../utils/order_status_map.dart';
import '../../../models/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<PageData<Order>> fOrders;
  Future<PageData<Order>> getOrders() async {
    var response = await Request.get('/Order');
    final pagedOrder = jsonDecode(response.body);
    return PageData<Order>.fromJson(pagedOrder);
  }

  @override
  void initState() {
    super.initState();
    fOrders = getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              FutureBuilder(
                  future: fOrders,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final orders = snapshot.data as PageData<Order>;
                      if (orders.totalRows == 0) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(64),
                          child: Center(
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.list_alt_rounded,
                                  color: Colors.grey,
                                  size: 128,
                                ),
                                SizedBox(height: 40),
                                Text(
                                  'You have not placed any orders yet.',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Card(
                        child: SizedBox(
                          width: double.maxFinite,
                          child: OrderTable(orders: orders.rows),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    return const Text('Loading');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderTable extends StatelessWidget {
  const OrderTable({required this.orders, Key? key}) : super(key: key);
  final List<Order> orders;
  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowHeight: 150,
      columns: const <DataColumn>[
        DataColumn(label: Text('Order Number')),
        DataColumn(label: Text('Order Placed')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Total')),
        DataColumn(label: Text(''))
      ],
      rows: orders
          .map((item) => DataRow(
                key: ValueKey(item.orderId),
                cells: [
                  DataCell(Text(item.orderId)),
                  DataCell(Text(
                      DateFormat.yMMMMEEEEd().format(item.orderTimeStamp))),
                  DataCell(Text(
                      ORDER_STATUS_TO_STRING[item.orderStatus].toString())),
                  DataCell(Text('CAD\$ ${item.totalPrice.toString()}')),
                  DataCell(
                    TextButton(
                      onPressed: () => context.router
                          .navigate(OrderDetailScreen(orderId: item.orderId)),
                      child: const Text('Details'),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
