import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/routes/router.gr.dart';
import 'package:flutter/material.dart';
import '../../utils/shared_enum.dart';
import '../../utils/order_status_map.dart';
import '../../models/order.dart';
import '../../models/shipping_address.dart';

List<Order> mockOrders = [
  Order(
    orderId: 'bef7a6a9-03c7-4bef-bd10-8ff22fdc7238',
    orderDetails: <int, int>{1: 1},
    orderTimeStamp: DateTime(2022, 2, 1),
    orderStatus: ORDER_STATUS.pending,
    totalPrice: 32,
    shippingAddress: ShippingAddress(
      fullName: 'Constancia Doerffer',
      phoneNumber: '9151881041',
      address: 'Unit 1207, 200 Rideau Street',
      city: 'El Paso',
      province: 'Texas',
      postalCode: 'K1N 9D9',
    ),
  ),
  Order(
    orderId: '9ad4e6f1-309d-4b77-8708-088ece0d2048',
    orderDetails: <int, int>{2: 1, 4: 1},
    orderTimeStamp: DateTime(2022, 1, 30),
    orderStatus: ORDER_STATUS.paid,
    totalPrice: 64,
    shippingAddress: ShippingAddress(
      fullName: 'Lester Lockney',
      phoneNumber: '9518645439',
      address: '1 Magdeline Lane',
      city: 'Moreno Valley',
      province: 'California',
      postalCode: 'M2N 7V3',
    ),
  ),
  Order(
    orderId: '71294aa6-a1c3-4046-9230-5792c2941e70',
    orderDetails: <int, int>{3: 1, 9: 4},
    orderTimeStamp: DateTime(2022, 1, 20),
    orderStatus: ORDER_STATUS.placed,
    totalPrice: 128,
    shippingAddress: ShippingAddress(
      fullName: 'Lester Lockney',
      phoneNumber: '9518645439',
      address: '1 Magdeline Lane',
      city: 'Moreno Valley',
      province: 'California',
      postalCode: 'M2N 7V3',
    ),
  ),
  Order(
    orderId: 'cec6a7f7-7117-4333-9917-e64d23912abd',
    orderDetails: <int, int>{5: 2},
    orderTimeStamp: DateTime(2022, 1, 10),
    orderStatus: ORDER_STATUS.shipping,
    totalPrice: 256,
    shippingAddress: ShippingAddress(
      fullName: 'Lester Lockney',
      phoneNumber: '9518645439',
      address: '1 Magdeline Lane',
      city: 'Moreno Valley',
      province: 'California',
      postalCode: 'M2N 7V3',
    ),
  ),
  Order(
      orderId: '5e2ba045-2779-4404-b511-f7c5c8d3ea37',
      orderDetails: <int, int>{7: 1, 1: 1},
      orderTimeStamp: DateTime(2022, 1, 1),
      orderStatus: ORDER_STATUS.shipped,
      totalPrice: 512,
      shippingAddress: ShippingAddress(
        fullName: 'Garnet Doumer',
        phoneNumber: '4025285834',
        address: '15 Dryden Point',
        city: 'Lincoln',
        province: 'Nebraska',
        postalCode: 'L3V 1K3',
      )),
];

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
              Card(
                child: SizedBox(
                  width: double.maxFinite,
                  child: OrderTable(orders: mockOrders),
                ),
              ),
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
      rows: mockOrders
          .map((item) => DataRow(
                cells: [
                  DataCell(Text(item.orderId)),
                  DataCell(Text(item.orderTimeStamp.toString())),
                  DataCell(Text(ORDER_STATUS_MAP[item.orderStatus].toString())),
                  DataCell(Text(item.totalPrice.toString())),
                  DataCell(
                    TextButton(
                      onPressed: () =>
                          context.router.navigate(OrderDetailScreen(
                            orderId: item.orderId
                          )),
                      child: const Text('Details'),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
