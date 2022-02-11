import 'package:flutter/material.dart';
import 'package:csi5112group1project/constants.dart';
import '../models/shipping_address.dart';
import './component/shipping_address.dart';

var addressList = [
  ShippingAddress(
    fullName: 'Constancia Doerffer',
    phoneNumber: '9151881041',
    address: 'Unit 1207, 200 Rideau Street',
    city: 'El Paso',
    province: 'Texas',
    postalCode: 'K1N 9D9',
  ),
  ShippingAddress(
    fullName: 'Lester Lockney',
    phoneNumber: '9518645439',
    address: '1 Magdeline Lane',
    city: 'Moreno Valley',
    province: 'California',
    postalCode: 'M2N 7V3',
  ),
  ShippingAddress(
    fullName: 'Garnet Doumer',
    phoneNumber: '4025285834',
    address: '15 Dryden Point',
    city: 'Lincoln',
    province: 'Nebraska',
    postalCode: 'L3V 1K3',
  ),
];

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Shipping Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: addressList
              .map(
                (addr) => ShippingAddressSection(
                  shippingAddress: addr,
                  leadingIcon: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.all(3),
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Text(
                      addr.fullName[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  tailingIcon: const Icon(
                    Icons.edit,
                    color: kTextLightColor,
                    size: 16,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
