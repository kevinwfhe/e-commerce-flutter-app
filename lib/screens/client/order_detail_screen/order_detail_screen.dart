import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../apis/request.dart';
import '../../../constants.dart';
import '../../../utils/order_status_map.dart';
import '../../../models/order.dart';
import '../../common/component/shipping_address_section.dart';

const printQuestionSnackBar = SnackBar(
    content: Text(
  'Question submitted!',
  textAlign: TextAlign.center,
));
const printInvoiceSnackBar = SnackBar(
    content: Text(
  'Invoice Printed!',
  textAlign: TextAlign.center,
));
const emailInvoiceSnackBar = SnackBar(
    content: Text(
  'Invoice Emailed!',
  textAlign: TextAlign.center,
));

class OrderDetailScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailScreen({
    Key? key,
    @PathParam() required this.orderId,
  }) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late Future<DetailedOrder> fOrder;
  Future<DetailedOrder> getOrder() async {
    var response = await Request.get('/Order/${widget.orderId}');
    var order = DetailedOrder.fromJson(jsonDecode(response.body));
    return order;
  }

  @override
  void initState() {
    super.initState();
    fOrder = getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.popRoute(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(64),
              child: FutureBuilder(
                future: fOrder,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final order = snapshot.data as DetailedOrder;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 16,
                                top: 16,
                              ),
                              child: const Text(
                                '1  Order Details',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        Card(
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 16,
                              bottom: 16,
                              left: 16,
                              right: 256,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Order Number:  ${order.orderId}'),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                            'Placed on:  ${DateFormat.yMMMMEEEEd().format(order.orderTimeStamp)}')
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                            'Status:  ${ORDER_STATUS_TO_STRING[order.orderStatus]}'),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text('Total: CAD\$ ${order.totalPrice}')
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 16, top: 16),
                              child: const Text(
                                '2  Shipping Address',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: ShippingAddressSection(
                                shippingAddress: order.shippingAddress,
                                readOnly: true),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 16, top: 16),
                              child: const Text(
                                '3  Purchased Items',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Card(
                          child: SizedBox(
                            width: double.maxFinite,
                            child: OrderDetailTable(
                                purchasedProducts: order.purchasedProducts),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 16, top: 16),
                              child: const Text(
                                '4  Ask any question',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Card(
                          child: SizedBox(
                            width: double.maxFinite,
                            child: QuestionDetailTable(
                                purchasedProducts: order.purchasedProducts),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 64,
                              width: 192,
                              margin: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () => ScaffoldMessenger.of(context)
                                    .showSnackBar(printQuestionSnackBar),
                                child: const Text(
                                  'Submit a request',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 64,
                              width: 192,
                              margin: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () => ScaffoldMessenger.of(context)
                                    .showSnackBar(printInvoiceSnackBar),
                                child: const Text(
                                  'Print Invoice',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 64,
                              width: 192,
                              margin: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () => ScaffoldMessenger.of(context)
                                    .showSnackBar(emailInvoiceSnackBar),
                                child: const Text(
                                  'Email Invoice',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  return const Text('');
                },
              )),
        ));
  }
}

class OrderDetailTable extends StatelessWidget {
  const OrderDetailTable({required this.purchasedProducts, Key? key})
      : super(key: key);
  final List<PurchasedProduct> purchasedProducts;
  @override
  Widget build(BuildContext context) {
    return DataTable(
        dataRowHeight: 150,
        columns: const <DataColumn>[
          DataColumn(label: Text('Item')),
          DataColumn(label: Text('Price')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Subtotal')),
        ],
        rows: purchasedProducts
            .map(
              (item) => DataRow(
                cells: [
                  DataCell(
                    Row(
                      children: [
                        Container(
                          width: 88,
                          margin: const EdgeInsets.only(right: 32),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFF5F6F9),
                              ),
                              child: Image.network(
                                '$s3BaseUrl${item.product.image}',
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                        Text(item.product.title)
                      ],
                    ),
                  ),
                  DataCell(Text(item.product.price.toString())),
                  DataCell(Text(item.quantity.toString())),
                  DataCell(Text('${item.quantity * item.product.price}'))
                ],
              ),
            )
            .toList());
  }
}

class QuestionDetailTable extends StatelessWidget {
  const QuestionDetailTable({required this.purchasedProducts, Key? key})
      : super(key: key);
  final List<PurchasedProduct> purchasedProducts;
  @override
  Widget build(BuildContext context) {
    return DataTable(
        dataRowHeight: 150,
        columns: const <DataColumn>[
          DataColumn(label: Text('Case Number')),
          DataColumn(label: Text('Content')),
          DataColumn(label: Text('Response')),
        ],
        rows: purchasedProducts
            .map(
              (item) => DataRow(
                cells: [
                  DataCell(Text(item.product.title.toString())),
                  const DataCell(Text("This product is not good")),
                  const DataCell(Text("Sorry")),
                ],
              ),
            )
            .toList());
  }
}
