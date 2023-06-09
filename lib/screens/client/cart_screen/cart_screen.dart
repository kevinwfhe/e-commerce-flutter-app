import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/constants.dart';
import 'package:csi5112group1project/context/user_context.dart';
import 'package:csi5112group1project/screens/common/component/no_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/cart.dart';
import '../../../routes/router.gr.dart';
import '../../../context/cart_context.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  void checkout(BuildContext context) {
    var user = Provider.of<UserContext>(context, listen: false);
    if (user.exist) {
      context.router.push(
        const CheckoutRouter(
          children: [
            CheckoutRoute(),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(signinFirstSnackbar);
      context.router.push(const LoginRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CartContext(),
        child: CartConsumer(
          builder: (context, cart, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF0F1111),
              title: Column(
                children: const [
                  Text("Shopping Cart"),
                ],
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.popRoute(),
              ),
            ),
            body: Builder(builder: ((context) {
              if (cart.items.isNotEmpty) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.only(
                          bottom: 96, left: 64, right: 64, top: 20),
                      child: Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: CartTable(
                            items: cart.items,
                            onItemSelecetedChange: (productId) =>
                                cart.select(productId),
                            onItemQuantityChange: (reference, operation) => {
                              // reference is of type 'Product' for 'add' method
                              // while is of 'productId' for 'subtract' method
                              // TODO: modify the Cart model to unify reference type
                              if (operation == 'add')
                                cart.add(reference)
                              else if (operation == 'subtract')
                                cart.subtract(reference)
                            },
                            onItemRemove: (productId) => {
                              showDialog(
                                context: context,
                                builder: (context) => RemoveItemModal(
                                  onConfirmRemove: () => cart.remove(productId),
                                ),
                              )
                            },
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 96,
                        padding: const EdgeInsets.only(left: 64, right: 64),
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 5),
                                blurStyle: BlurStyle.outer,
                              )
                            ]),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: cart.allSelected,
                                    onChanged: (checked) =>
                                        cart.selectAll(checked),
                                  ),
                                  const Text('Sellect All')
                                ],
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'Total:  ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '\$${cart.totalPrice.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                height: 50,
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () => checkout(context),
                                  child: const Text('Proceed to checkout'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return NoContent(
                  icon: Icons.shopping_cart_outlined,
                  message:
                      'Your cart is empty. Fill it with clothing, household supplies, electronics and more.',
                );
              }
            })),
          ),
        ));
  }
}

class CartTable extends StatelessWidget {
  final List<CartItem> items;
  final Function onItemSelecetedChange;
  final Function onItemQuantityChange;
  final Function onItemRemove;
  const CartTable({
    Key? key,
    required this.items,
    required this.onItemSelecetedChange,
    required this.onItemQuantityChange,
    required this.onItemRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowHeight: 150,
      columns: const <DataColumn>[
        DataColumn(label: Text('')),
        DataColumn(label: Text('Item')),
        DataColumn(label: Text('Price')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Subtotal')),
        DataColumn(label: Text('')),
      ],
      rows: items
          .map((item) => DataRow(
                cells: [
                  DataCell(
                    SizedBox(
                      width: 20,
                      child: Checkbox(
                        value: item.selected,
                        onChanged: (value) =>
                            onItemSelecetedChange(item.product.id),
                      ),
                    ),
                  ),
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
                  DataCell(
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                            ),
                            onPressed: () => item.numOfItem == 1
                                ? null
                                : onItemQuantityChange(
                                    item.product.id, 'subtract'),
                            child: const Text('-'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(item.numOfItem.toString()),
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                            ),
                            onPressed: () =>
                                onItemQuantityChange(item.product, 'add'),
                            child: const Text('+'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text((item.numOfItem * item.product.price)
                      .toStringAsFixed(2))),
                  DataCell(
                    Row(
                      children: [
                        // TODO: 'Save for later' feature
                        TextButton(
                          onPressed: () => onItemRemove(item.product.id),
                          child: const Text('Remove'),
                        ),
                      ],
                    ),
                  )
                ],
              ))
          .toList(),
    );
  }
}

class RemoveItemModal extends StatelessWidget {
  final Function onConfirmRemove;
  const RemoveItemModal({
    Key? key,
    required this.onConfirmRemove,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove Item'),
      content: const Text('This will remove the item from your shopping cart.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => {onConfirmRemove(), Navigator.pop(context)},
          child: const Text('Remove'),
        ),
      ],
    );
  }
}

const signinFirstSnackbar = SnackBar(
  content: Text(
    'Please sign in first.',
    textAlign: TextAlign.center,
  ),
);
