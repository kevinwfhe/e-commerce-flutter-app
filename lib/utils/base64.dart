import 'dart:convert';
import 'dart:typed_data';

Uint8List base64ImageToUint8List(String base64Image) {
  String header = "data:image/png;base64,";
  String base64String = base64Image.substring(header.length);
  return base64Decode(base64String);
}

String uint8ListToBase64Image(Uint8List uint8list) {
  String base64String = base64Encode(uint8list);
  String header = "data:image/png;base64,";
  return header + base64String;
}
