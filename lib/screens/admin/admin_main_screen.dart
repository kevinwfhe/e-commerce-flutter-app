import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/constants.dart';
import 'package:csi5112group1project/context/user_context.dart';
import 'package:csi5112group1project/screens/admin/category_manage_screen/category_manage_screen.dart';
import 'package:flutter/material.dart';
import 'package:csi5112group1project/screens/admin/add_product_screen/add_product_screen.dart';
import 'package:provider/provider.dart';
import '../../apis/request.dart';
import '../../routes/router.gr.dart';
import './admin_order_screen/admin_order_screen.dart';
import 'package:csi5112group1project/screens/admin/product_manage_screen/product_manage_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedDestination = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var drawerOpen = true;

  void signout() async {
    Request.get('/logout').then((response) async {
      if (response.statusCode == 200) {
        var user = Provider.of<UserContext>(context, listen: false);
        await user.clear();
        ScaffoldMessenger.of(context).showSnackBar(printLogoutSnackBar);
        context.router.popUntilRoot();
      }
    }).catchError((error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(logoutFailedSnackBar);
    });
  }

  @override
  void initState() {
    super.initState();
    var user = Provider.of<UserContext>(context, listen: false);
    if (!user.exist) {
      context.router.replace(const AdminLoginRoute());
    }
  }

  void openDrawer() {
    setState(() {
      drawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      drawerOpen = false;
    });
  }

  Widget? generateAppbarTitle() {
    if (_selectedDestination == 0) {
      return const Text(
        'Product',
        style: TextStyle(color: Colors.black),
      );
    }
    if (_selectedDestination == 1) {
      return Row(
        children: const [
          Text(
            'Product',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            ' / ',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            'Add Product',
            style: TextStyle(color: Colors.black),
          )
        ],
      );
    }
    if (_selectedDestination == 2) {
      return const Text(
        'Category',
        style: TextStyle(color: Colors.black),
      );
    }
    if (_selectedDestination == 3) {
      return const Text(
        'Order',
        style: TextStyle(color: Colors.black),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: kAdminBackgroundColor,
        body: UserConsumer(
          builder: (context, user, child) {
            return Row(
              children: [
                !drawerOpen
                    ? NavigationRail(
                        backgroundColor: kAdminPrimaryColor,
                        selectedIndex: _selectedDestination,
                        onDestinationSelected: (int index) {
                          setState(() {
                            _selectedDestination = index;
                          });
                        },
                        labelType: NavigationRailLabelType.selected,
                        leading: const Icon(Icons.people),
                        destinations: <NavigationRailDestination>[
                          NavigationRailDestination(
                            icon: const Tooltip(
                              message: 'Products',
                              child: Icon(
                                Icons.inventory_2,
                                color: kAdminTextPrimaryColor,
                              ),
                            ),
                            selectedIcon: Container(
                              decoration: const BoxDecoration(
                                color: kAdminSecondaryColor,
                              ),
                              height: 50,
                              width: 80,
                              child: const Icon(
                                Icons.inventory_2_outlined,
                                color: Colors.white,
                              ),
                            ),
                            label: const Text(''),
                          ),
                          NavigationRailDestination(
                            icon: const Tooltip(
                              message: "Add Product",
                              child: Icon(
                                Icons.add,
                                color: kAdminTextPrimaryColor,
                              ),
                            ),
                            selectedIcon: Container(
                              decoration: const BoxDecoration(
                                color: kAdminSecondaryColor,
                              ),
                              height: 50,
                              width: 80,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            label: const Text(''),
                          ),
                          NavigationRailDestination(
                            icon: const Tooltip(
                              message: "Category",
                              child: Icon(
                                Icons.category,
                                color: kAdminTextPrimaryColor,
                              ),
                            ),
                            selectedIcon: Container(
                              decoration: const BoxDecoration(
                                color: kAdminSecondaryColor,
                              ),
                              height: 50,
                              width: 80,
                              child: const Icon(
                                Icons.category_outlined,
                                color: Colors.white,
                              ),
                            ),
                            label: const Text(''),
                          ),
                          NavigationRailDestination(
                            icon: const Tooltip(
                              message: "Orders",
                              child: Icon(
                                Icons.receipt,
                                color: kAdminTextPrimaryColor,
                              ),
                            ),
                            selectedIcon: Container(
                              decoration: const BoxDecoration(
                                color: kAdminSecondaryColor,
                              ),
                              height: 50,
                              width: 80,
                              child: const Icon(
                                Icons.receipt_outlined,
                                color: Colors.white,
                              ),
                            ),
                            label: const Text(''),
                          ),
                        ],
                      )
                    : Drawer(
                        backgroundColor: kAdminPrimaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AdminUserInfoSection(
                                username: user.exist ? user.username! : '-',
                                emailAddress:
                                    user.exist ? user.emailAddress! : '-',
                              ),
                              const Divider(
                                height: 1,
                                thickness: 1.5,
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: Icon(
                                              _selectedDestination == 0
                                                  ? Icons.inventory_2_outlined
                                                  : Icons.inventory_2,
                                              color: _selectedDestination == 0
                                                  ? kAdminTextPrimaryColor
                                                  : kAdminTextSecondaryColor,
                                            ),
                                            title: Text(
                                              'Products',
                                              style: TextStyle(
                                                color: _selectedDestination == 0
                                                    ? kAdminTextPrimaryColor
                                                    : kAdminTextSecondaryColor,
                                              ),
                                            ),
                                            iconColor: kAdminTextSecondaryColor,
                                            selected: _selectedDestination == 0,
                                            onTap: () => selectDestination(0),
                                            selectedTileColor:
                                                kAdminSecondaryColor,
                                          ),
                                          ListTile(
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 52),
                                              child: Text(
                                                'Add Product',
                                                style: TextStyle(
                                                  color: _selectedDestination ==
                                                          1
                                                      ? kAdminTextPrimaryColor
                                                      : kAdminTextSecondaryColor,
                                                ),
                                              ),
                                            ),
                                            iconColor: kAdminTextSecondaryColor,
                                            selected: _selectedDestination == 1,
                                            onTap: () => selectDestination(1),
                                            selectedTileColor:
                                                kAdminSecondaryColor,
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              _selectedDestination == 2
                                                  ? Icons.category_outlined
                                                  : Icons.category,
                                              color: _selectedDestination == 2
                                                  ? kAdminTextPrimaryColor
                                                  : kAdminTextSecondaryColor,
                                            ),
                                            title: Text(
                                              'Category',
                                              style: TextStyle(
                                                color: _selectedDestination == 2
                                                    ? kAdminTextPrimaryColor
                                                    : kAdminTextSecondaryColor,
                                              ),
                                            ),
                                            selected: _selectedDestination == 2,
                                            onTap: () => selectDestination(2),
                                            selectedTileColor:
                                                kAdminSecondaryColor,
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              _selectedDestination == 3
                                                  ? Icons.receipt_outlined
                                                  : Icons.receipt,
                                              color: _selectedDestination == 3
                                                  ? kAdminTextPrimaryColor
                                                  : kAdminTextSecondaryColor,
                                            ),
                                            title: Text(
                                              'Order',
                                              style: TextStyle(
                                                color: _selectedDestination == 3
                                                    ? kAdminTextPrimaryColor
                                                    : kAdminTextSecondaryColor,
                                              ),
                                            ),
                                            iconColor: kAdminTextSecondaryColor,
                                            selected: _selectedDestination == 3,
                                            onTap: () => selectDestination(3),
                                            selectedTileColor:
                                                kAdminSecondaryColor,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                ),
                Expanded(
                  child: Scaffold(
                    appBar: AppBar(
                      title: generateAppbarTitle(),
                      backgroundColor: Colors.white,
                      leading: drawerOpen
                          ? IconButton(
                              color: const Color.fromRGBO(0, 0, 0, 0.85),
                              onPressed: closeDrawer,
                              icon: const Icon(
                                Icons.menu_open_outlined,
                                textDirection: TextDirection.ltr,
                              ),
                            )
                          : Transform.rotate(
                              angle: 180 * pi / 180,
                              child: IconButton(
                                color: const Color.fromRGBO(0, 0, 0, 0.85),
                                onPressed: openDrawer,
                                icon: const Icon(
                                  Icons.menu_open_outlined,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                      actions: [
                        TextButton(
                          onPressed: signout,
                          child: const Text('Sign Out'),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                    backgroundColor: kAdminBackgroundColor,
                    body: Builder(builder: (context) {
                      if (_selectedDestination == 0) {
                        return const ProductManageScreen();
                      }
                      if (_selectedDestination == 1) {
                        return const AddProductScreen();
                      }
                      if (_selectedDestination == 2) {
                        // return const AdminCategoryScreen();
                        return const CategoryManageScreen();
                      }
                      if (_selectedDestination == 3) {
                        return const AdminOrderScreen();
                      }
                      return const Text('');
                    }),
                  ),
                ),
              ],
            );
          },
        ));
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
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            height: 80,
            width: 80,
            child: const Icon(
              Icons.people,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            username,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            emailAddress,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

const printLogoutSnackBar = SnackBar(
    content: Text(
  'You have sign out!',
  textAlign: TextAlign.center,
));

const logoutFailedSnackBar = SnackBar(
    content: Text(
  'Sign out failed, please try again later.',
  textAlign: TextAlign.center,
));

const loginFirstSnackBar = SnackBar(
    content: Text(
  'Please sign in first!',
  textAlign: TextAlign.center,
));
