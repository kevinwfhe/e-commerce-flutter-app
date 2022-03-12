import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../utils/order_status_map.dart';
import '../../utils/shared_enum.dart';
import '../../models/cart.dart';
import '../../models/order.dart';
import '../../models/shipping_address.dart';
import '../../models/product.dart';
import './component/shipping_address.dart';

Order mockOrder = Order(
  orderId: 'bef7a6a9-03c7-4bef-bd10-8ff22fdc7238',
  orderDetails: <int, int>{1: 1},
  orderTimeStamp: DateTime(2022, 2, 1),
  orderStatus: ORDER_STATUS.pending,
  totalPrice: 966,
  shippingAddress: ShippingAddress(
    fullName: 'Constancia Doerffer',
    phoneNumber: '9151881041',
    address: 'Unit 1207, 200 Rideau Street',
    city: 'El Paso',
    province: 'Texas',
    postalCode: 'K1N 9D9',
  ),
);

var mockPurchasedItems = <CartItem>[
  CartItem(product: products[2], numOfItem: 1),
  CartItem(product: products[1], numOfItem: 1),
  CartItem(product: products[0], numOfItem: 1),
  CartItem(product: products[5], numOfItem: 1),
].toList();

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

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({@PathParam() required this.orderId, Key? key})
      : super(key: key);
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(64),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16, top: 16),
                      child: const Text(
                        '1  Order Details',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Card(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 16, right: 256),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Order Number:  ${mockOrder.orderId}'),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                    'Date:  ${mockOrder.orderTimeStamp.toString()}')
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
                                    'Status:  ${ORDER_STATUS_MAP[mockOrder.orderStatus]}'),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Total Cost:  \$${mockOrder.totalPrice}')
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
                      margin: const EdgeInsets.only(bottom: 16, top: 16),
                      child: const Text(
                        '2  Shipping Address',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Card(
                  child: ShippingAddressSection(
                    shippingAddress: mockOrder.shippingAddress,
                    tailingIcon: const Spacer(),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16, top: 16),
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
                    child: OrderDetailTable(purchasedItems: mockPurchasedItems),
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
            ),
          ),
        ));
  }
}

class OrderDetailTable extends StatelessWidget {
  const OrderDetailTable({required this.purchasedItems, Key? key})
      : super(key: key);
  final List<CartItem> purchasedItems;
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
      rows: purchasedItems
          .map((prod) => DataRow(
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
                              // padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                              decoration:
                                  const BoxDecoration(color: Color(0xFFF5F6F9)),
                              child: Image.asset(
                                prod.product.image,
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                        Text(prod.product.title)
                      ],
                    ),
                  ),
                  DataCell(Text(prod.product.price.toString())),
                  DataCell(Text(prod.numOfItem.toString())),
                  DataCell(Text('${prod.numOfItem * prod.product.price}'))
                ],
              ))
          .toList(),
    );
  }
}
