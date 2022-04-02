import 'package:flutter/material.dart';

class DeleteProductModel extends StatelessWidget {
  final Function onDelete;
  final Function onCancel;
  const DeleteProductModel({
    Key? key,
    required this.onDelete,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
