import 'dart:convert';

import 'package:csi5112group1project/utils/base64.dart';
import 'package:flutter/material.dart';
import '../../../models/cart.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.memory(base64ImageToUint8List(item.product.image)),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.product.title,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${item.product.price}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.blue),
                children: [
                  TextSpan(
                      text: " x${item.numOfItem}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
