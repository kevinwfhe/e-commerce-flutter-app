import 'package:flutter/material.dart';
import '../../../../models/shipping_address.dart';
import '../../../common/component/shipping_address_section.dart';

class AddressSelector extends StatelessWidget {
  const AddressSelector({
    Key? key,
    required this.addresses,
    required this.selectedAddressId,
    required this.onAddressSelected,
    required this.onEditAddress,
    required this.onDeleteAddress,
  }) : super(key: key);
  final List<ShippingAddress> addresses;
  final String? selectedAddressId;
  final Function onAddressSelected;
  final Function onEditAddress;
  final Function onDeleteAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: addresses
          .map((addr) => ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: ShippingAddressSection(
                  shippingAddress: addr,
                  onPressEditIcon: () => onEditAddress(addr.id),
                  onPressDeleteIcon: () => onDeleteAddress(addr.id),
                ),
                leading: Radio(
                  value: addr.id,
                  groupValue: selectedAddressId,
                  onChanged: (id) {
                    onAddressSelected(id);
                  },
                ),
              ))
          .toList(),
    );
  }
}
