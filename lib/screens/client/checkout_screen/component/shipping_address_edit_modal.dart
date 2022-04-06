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

  final _formKey = GlobalKey<FormState>();
  final _fullnameCtrlKey = GlobalKey<FormFieldState>();
  final _phoneNumberCtrlKey = GlobalKey<FormFieldState>();
  final _addressFirstLineCtrlKey = GlobalKey<FormFieldState>();
  final _cityCtrlKey = GlobalKey<FormFieldState>();
  final _provinceCtrlKey = GlobalKey<FormFieldState>();
  final _postalCodeCtrlKey = GlobalKey<FormFieldState>();

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

    fullnameController.addListener(() {
      if (fullnameController.text != '') {
        _fullnameCtrlKey.currentState!.validate();
      }
    });
    phoneNumberController.addListener(() {
      if (phoneNumberController.text != '') {
        _phoneNumberCtrlKey.currentState!.validate();
      }
    });
    addressFirstLineController.addListener(() {
      if (addressFirstLineController.text != '') {
        _addressFirstLineCtrlKey.currentState!.validate();
      }
    });
    cityController.addListener(() {
      if (cityController.text != '') {
        _cityCtrlKey.currentState!.validate();
      }
    });
    provinceController.addListener(() {
      if (provinceController.text != '') {
        _provinceCtrlKey.currentState!.validate();
      }
    });
    postalCodeController.addListener(() {
      if (postalCodeController.text != '') {
        _postalCodeCtrlKey.currentState!.validate();
      }
    });
  }

  void onClickSave() {
    if (_formKey.currentState!.validate()) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 500,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  key: _fullnameCtrlKey,
                  controller: fullnameController,
                  decoration: generateInputDecoration(
                    'Fullname',
                  ),
                  validator: (value) {
                    if (fullnameController.text.isEmpty) {
                      return 'Please enter fullname.';
                    }
                  },
                ),
                TextFormField(
                  key: _phoneNumberCtrlKey,
                  controller: phoneNumberController,
                  decoration: generateInputDecoration(
                    'Phone',
                  ),
                  validator: (value) {
                    if (fullnameController.text.isEmpty) {
                      return 'Please enter phone numer.';
                    }
                    // TODO: valid phone number regex match
                  },
                ),
                TextFormField(
                  key: _addressFirstLineCtrlKey,
                  controller: addressFirstLineController,
                  decoration: generateInputDecoration('Address',
                      helperText: 'Street address or P.O. Box'),
                  validator: (value) {
                    if (addressFirstLineController.text.isEmpty) {
                      return 'Please enter address.';
                    }
                  },
                ),
                TextFormField(
                  controller: addressSecondLineController,
                  decoration: generateInputDecoration(
                    '',
                    helperText: 'Apt, Suite, Unit, Building',
                  ),
                ),
                TextFormField(
                  key: _cityCtrlKey,
                  controller: cityController,
                  decoration: generateInputDecoration(
                    'City',
                  ),
                  validator: (value) {
                    if (cityController.text.isEmpty) {
                      return 'Please enter city.';
                    }
                  },
                ),
                TextFormField(
                  key: _provinceCtrlKey,
                  controller: provinceController,
                  decoration: generateInputDecoration('Province'),
                  validator: (value) {
                    if (provinceController.text.isEmpty) {
                      return 'Please enter province.';
                    }
                  },
                ),
                TextFormField(
                  key: _postalCodeCtrlKey,
                  controller: postalCodeController,
                  decoration: generateInputDecoration('Postal code'),
                  validator: (value) {
                    if (postalCodeController.text.isEmpty) {
                      return 'Please enter postal code.';
                    }
                  },
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
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey.shade400),
                      child: const Text('Cancel'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
