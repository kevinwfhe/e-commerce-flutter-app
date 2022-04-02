import 'dart:convert';
import 'dart:typed_data';

Uint8List base64ImageToUint8List(String base64Image) {
  return base64Decode(base64Image);
}

String uint8ListToBase64Image(Uint8List uint8list) {
  String base64String = base64Encode(uint8list);
  return base64String;
}
