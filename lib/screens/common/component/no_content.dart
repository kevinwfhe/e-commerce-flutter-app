import 'package:flutter/material.dart';

class NoContent extends StatelessWidget {
  String? message;
  IconData? icon;
  NoContent({
    Key? key,
    this.message,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(64),
      child: Center(
        child: Column(
          children: [
            if (icon != null)
              Icon(
                icon,
                color: Colors.grey,
                size: 128,
              ),
            const SizedBox(height: 40),
            if (message != null)
              Text(
                message!,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
