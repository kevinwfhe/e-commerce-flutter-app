import 'package:flutter/material.dart';
import '../../../../models/shipping_address.dart';

class EditAddressModal extends StatefulWidget {
  final ShippingAddress addressToEdit;
  final Function onSaveEdit;
  const EditAddressModal({
    Key? key,
    required this.addressToEdit,
    required this.onSaveEdit,
  }) : super(key: key);

  @override
  _EditAddressModalState createState() => _EditAddressModalState();
}

class _EditAddressModalState extends State<EditAddressModal> {
  final fullnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressFirstLineController = TextEditingController();
  final addressSecondLineController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();
  final postalCodeController = TextEditingController();

  InputDecoration generateInputDecoration(
    String labelText, {
    Icon? icon,
    String? helperText,
  }) {
    return InputDecoration(
      icon: icon,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Color(0xFF6200EE),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF6200EE)),
      ),
      helperText: helperText,
    );
  }

  @override
  void initState() {
    super.initState();
    final address = widget.addressToEdit;
    fullnameController.text = address.addressFirstLine;
    phoneNumberController.text = address.phoneNumber;
    addressFirstLineController.text = address.addressFirstLine;
    addressSecondLineController.text = address.addressSecondLine;
    cityController.text = address.city;
    provinceController.text = address.province;
    postalCodeController.text = address.postalCode;
  }

  void onClickSave() {
    // TODO: input validation.
    var savedAddress = ShippingAddress(
      id: widget.addressToEdit.id,
      fullname: fullnameController.text,
      phoneNumber: phoneNumberController.text,
      addressFirstLine: addressFirstLineController.text,
      addressSecondLine: addressSecondLineController.text,
      city: cityController.text,
      province: provinceController.text,
      postalCode: postalCodeController.text,
    );
    widget.onSaveEdit(savedAddress);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          width: 800,
          height: 500,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: fullnameController,
                decoration: generateInputDecoration(
                  'Fullname',
                ),
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: generateInputDecoration(
                  'Phone',
                ),
              ),
              TextFormField(
                controller: addressFirstLineController,
                decoration: generateInputDecoration('Address',
                    helperText: 'Street address or P.O. Box'),
              ),
              TextFormField(
                controller: addressSecondLineController,
                decoration: generateInputDecoration(
                  '',
                  helperText: 'Apt, Suite, Unit, Building',
                ),
              ),
              TextFormField(
                controller: cityController,
                decoration: generateInputDecoration(
                  'City',
                ),
              ),
              TextFormField(
                controller: provinceController,
                decoration: generateInputDecoration('Province'),
              ),
              TextFormField(
                controller: postalCodeController,
                decoration: generateInputDecoration('Postal code'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: onClickSave,
                    child: const Text('Save'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style:
                        ElevatedButton.styleFrom(primary: Colors.grey.shade400),
                    child: const Text('Cancel'),
                  )
                ],
              )
            ],
          )),
    );
  }
}
