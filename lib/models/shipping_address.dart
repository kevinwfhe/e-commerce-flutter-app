class ShippingAddress {
  final String id,
      fullname,
      phoneNumber,
      addressFirstLine,
      addressSecondLine,
      city,
      province,
      postalCode;
  String? userId;
  ShippingAddress({
    required this.id,
    required this.fullname,
    required this.phoneNumber,
    required this.addressFirstLine,
    required this.addressSecondLine,
    required this.city,
    required this.province,
    required this.postalCode,
    this.userId,
  });

  ShippingAddress.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        fullname = json['fullname'],
        phoneNumber = json['phoneNumber'],
        addressFirstLine = json['addressFirstLine'],
        addressSecondLine = json['addressSecondLine'],
        city = json['city'],
        province = json['province'],
        postalCode = json['postalCode'],
        userId = json['userId'];

  Map<String, dynamic> toJson() {
    return {
      'id': '',
      'fullname': fullname,
      'phoneNumber': phoneNumber,
      'addressFirstLine': addressFirstLine,
      'city': city,
      'province': province,
      'postalCode': postalCode,
      'addressSecondLine': addressSecondLine,
      'userId': '',
    };
  }
}
