import 'package:flutter/material.dart';
import 'package:csi5112group1project/screens/admin/add_product_screen.dart';
import 'package:csi5112group1project/screens/admin/invoice_screen.dart';
import 'package:csi5112group1project/screens/admin/product_manage_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              const AdminUserInfoSection(
                username: 'Julina Ellum',
                emailAddress: 'jellum0@netlog.com',
              ),
              const Divider(
                height: 1,
                thickness: 1.5,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.inventory),
                          title: const Text('Products'),
                          selected: _selectedDestination == 0,
                          onTap: () => selectDestination(0),
                          hoverColor: Colors.blue.shade100,
                        ),
                        ListTile(
                          title: const Padding(
                            padding: EdgeInsets.only(left: 48),
                            child: Text('Add Product'),
                          ),
                          selected: _selectedDestination == 1,
                          onTap: () => selectDestination(1),
                          hoverColor: Colors.blue.shade100,
                        ),
                      ],
                    ),
                    ListTile(
                      leading: const Icon(Icons.receipt),
                      title: const Text('Invoice'),
                      selected: _selectedDestination == 2,
                      onTap: () => selectDestination(2),
                      hoverColor: Colors.blue.shade100,
                    ),
                  ],
                ),
              )

              // ListTile(
              //   leading: Icon(Icons.label),
              //   title: Text('Item 3'),
              //   selected: _selectedDestination == 2,
              //   onTap: () => selectDestination(2),
              // ),
            ],
          ),
        ),
        const VerticalDivider(
          width: 1,
          thickness: 1,
        ),
        Expanded(
          child: Scaffold(
            body: Builder(builder: (context) {
              if (_selectedDestination == 0) {
                return const ProductManageScreen();
              }
              if (_selectedDestination == 1) {
                return const AddProductScreen();
              }
              if (_selectedDestination == 2) {
                return const InvoiceScreen();
              }
              return const Text('');
            }),
          ),
        ),
      ],
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}

class AdminUserInfoSection extends StatelessWidget {
  final String username;
  final String emailAddress;
  const AdminUserInfoSection({
    Key? key,
    required this.username,
    required this.emailAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(50)),
            height: 80,
            width: 80,
            child: const Icon(Icons.people),
          ),
          const SizedBox(height: 25),
          Text(
            username,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            emailAddress,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
