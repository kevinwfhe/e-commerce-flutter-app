import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/models/order.dart';
import 'package:csi5112group1project/utils/shared_enum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../apis/request.dart';
import '../../../constants.dart';
import '../../../routes/router.gr.dart';
import '../../../context/cart_context.dart';
import '../../../models/cart.dart';
import '../../../models/shipping_address.dart';
import './component/shipping_address_selector.dart';
import 'component/shipping_address_edit_modal.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Future<List<ShippingAddress>> fAddress;
  String? selectedAddressId;
  Future<List<ShippingAddress>> getAddress() async {
    // var response = await Request.get('/ShippingAddress');
    var response = await Request.get('/ShippingAddress');
    final List list = jsonDecode(response.body);
    var res = list.map((addr) => ShippingAddress.fromJson(addr)).toList();
    return res;
  }

  void addNewAddress() {
    showDialog(
      context: context,
      builder: (context) => EditAddressModal(
        addressToEdit: ShippingAddress(
          id: '',
          fullname: '',
          phoneNumber: '',
          addressFirstLine: '',
          addressSecondLine: '',
          city: '',
          province: '',
          postalCode: '',
        ),
        onSaveEdit: (createdAddress) {
          createAddress(createdAddress);
        },
      ),
    );
  }

  void createAddress(address) async {
    var response = await Request.post(
      '/ShippingAddress',
      jsonEncode(address),
    );
    if (response.statusCode == 201) {
      String newAddressId =
          ShippingAddress.fromJson(jsonDecode(response.body)).id;
      setState(() {
        fAddress = getAddress();
        // select the newly created address
        fAddress.then((addresses) => selectedAddressId = newAddressId);
      });
    }
  }

  void updateAddress(address) async {
    var response = await Request.put(
      '/ShippingAddress/${address.id}',
      jsonEncode(address),
    );
    if (response.statusCode == 204) {
      setState(() {
        fAddress = getAddress();
      });
    }
  }

  void deleteAddress(id) async {
    var response = await Request.delete('/ShippingAddress/${id}');
    if (response.statusCode == 204) {
      setState(() {
        fAddress = getAddress();
        fAddress.then((addresses) {
          if (addresses.isEmpty || id == selectedAddressId) {
            selectedAddressId = '';
          }
        });
      });
    }
  }

  void placeOrder() async {
    var orderToPlace = Order(
      orderId: '',
      orderTimeStamp: DateTime.now(),
      orderStatus: ORDER_STATUS.placed,
      totalPrice: CartContext().totalPrice,
      shippingAddressId: selectedAddressId,
      // convert Map<String(productId), int(quantity)>
      // to List<PurchasedItem> to comply with api services
      purchasedItems: CartContext()
          .itemsToCheckout
          .entries
          .map(
              (e) => PurchasedItem(id: '', productId: e.key, quantity: e.value))
          .toList(),
    );
    var response = await createOrder(orderToPlace);
    if (response.statusCode == 201) {
      CartContext().clear();
      context.router.replace(const CheckoutSuccessScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(placeOrderFailedSnackBar);
    }
  }

  Future<http.Response> createOrder(Order order) async {
    return Request.post(
      '/Order',
      jsonEncode(order),
    );
  }

  @override
  void initState() {
    super.initState();
    fAddress = getAddress();
    fAddress.then((addresses) {
      if (addresses.isNotEmpty) {
        selectedAddressId = addresses[0].id;
      } else {
        selectedAddressId = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartContext(),
      child: CartConsumer(
        builder: (context, cart, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Place Your Order'),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                context.router.pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(64),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 16,
                          top: 16,
                        ),
                        child: const Text(
                          '1  Shipping Address',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Card(
                    child: FutureBuilder(
                      future: fAddress,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final addresses =
                              snapshot.data as List<ShippingAddress>;
                          return Column(
                            children: [
                              if (addresses.isNotEmpty)
                                Column(
                                  children: [
                                    AddressSelector(
                                      addresses: addresses,
                                      selectedAddressId: selectedAddressId,
                                      onAddressSelected: (id) => {
                                        setState(() {
                                          selectedAddressId = id;
                                        }),
                                      },
                                      onEditAddress: (id) {
                                        final addressToEdit =
                                            addresses.firstWhere(
                                                (addr) => addr.id == id);
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              EditAddressModal(
                                                  addressToEdit: addressToEdit,
                                                  onSaveEdit: (savedAddress) {
                                                    updateAddress(savedAddress);
                                                  }),
                                        );
                                      },
                                      onDeleteAddress: (id) {
                                        deleteAddress(id);
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextButton(
                                        child:
                                            const Text('Use another address'),
                                        onPressed: () => addNewAddress(),
                                      ),
                                    ),
                                  ],
                                ),
                              if (addresses.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                          'You don\'t have any addresses yet, '),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                        ),
                                        onPressed: () => addNewAddress(),
                                        child: const Text('create one'),
                                      ),
                                      const Text('.')
                                    ],
                                  ),
                                )
                            ],
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Text('error');
                        }
                        return const Text('Loading...');
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 16,
                          top: 16,
                        ),
                        child: const Text(
                          '2  Review Items',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Card(
                    child: SizedBox(
                      width: double.maxFinite,
                      child: CheckoutTable(
                          // checkout the selected items in the cart
                          items: cart.items.where((i) => i.selected).toList()),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Order Total:  \$${cart.totalPrice}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFA12B16),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 64,
                        width: 192,
                        margin: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          onPressed: () => selectedAddressId == ''
                              // notify if there's no seleted address
                              ? {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(selectAddressSnackBar)
                                }
                              : placeOrder(),
                          child: const Text(
                            'Place your order',
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
          ),
        ),
      ),
    );
  }
}

class CheckoutTable extends StatelessWidget {
  const CheckoutTable({required this.items, Key? key}) : super(key: key);
  final List<CartItem> items;
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
      rows: items
          .map((prod) => DataRow(
                cells: [
                  DataCell(
                    Row(
                      children: [
                        Container(
                          width: 88,
                          margin: const EdgeInsets.only(
                            right: 32,
                          ),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFF5F6F9),
                              ),
                              child: Image.network(
                                '$s3BaseUrl${prod.product.image}',
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

const selectAddressSnackBar = SnackBar(
    content: Text(
  'You need to select a shipping address before placing the order.',
  textAlign: TextAlign.center,
));

const placeOrderFailedSnackBar = SnackBar(
    content: Text(
  'Service unavailable, please try again later.',
  textAlign: TextAlign.center,
));
