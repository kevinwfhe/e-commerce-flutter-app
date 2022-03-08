import 'package:flutter/material.dart';
import '../../../models/shipping_address.dart';
import '../../../constants.dart';

class ShippingAddressSection extends StatelessWidget {
  const ShippingAddressSection({
    required this.shippingAddress,
    this.onTapCallback,
    this.leadingIcon,
    this.tailingIcon,
    Key? key,
  }) : super(key: key);
  final ShippingAddress shippingAddress;
  final Function? onTapCallback;
  final Widget? leadingIcon; // Leading icon on the left side.
  final Widget? tailingIcon; // Tailing icon on the right side.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // Enable invoking onTap when tap on empty space
      onTap: () => onTapCallback?.call(),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            leadingIcon ??
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        margin: const EdgeInsets.only(right: 8),
                        child: Text(
                          shippingAddress.fullName,
                          style: const TextStyle(
                            color: kTextColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        shippingAddress.phoneNumber,
                        style: const TextStyle(
                          color: kTextLightColor,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5), // use as a more readable padding
                  Text(
                    shippingAddress.address,
                    style: const TextStyle(
                      color: kTextLightColor,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${shippingAddress.city}, ${shippingAddress.province}, '
                    '${shippingAddress.postalCode}',
                    style: const TextStyle(
                      color: kTextLightColor,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            tailingIcon ??
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: kTextLightColor,
                ),
          ],
        ),
      ),
    );
  }
}
