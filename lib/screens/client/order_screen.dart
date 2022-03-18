import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/routes/router.gr.dart';
import 'package:flutter/material.dart';
import '../../apis/request.dart';
import '../../utils/order_status_map.dart';
import '../../models/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<List<Order>> fOrders;
  Future<List<Order>> getOrders() async {
    // var response = await Request.get('/Order');
    var response =
        await Request.base('get', 'https://localhost:7098/api/Order');
    final List list = jsonDecode(response.body);
    return list.map((o) => Order.fromJson(o)).toList();
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
                      final order = snapshot.data as List<Order>;
                      return Card(
                        child: SizedBox(
                          width: double.maxFinite,
                          child: OrderTable(orders: order),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    return Text('Loading');
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
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Cost')),
        DataColumn(label: Text(''))
      ],
      rows: orders
          .map((item) => DataRow(
                key: ValueKey(item.orderId),
                cells: [
                  DataCell(Text(item.orderId)),
                  DataCell(Text(item.orderTimeStamp.toString())),
                  DataCell(Text(
                      ORDER_STATUS_TO_STRING[item.orderStatus].toString())),
                  DataCell(Text(item.totalPrice.toString())),
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
