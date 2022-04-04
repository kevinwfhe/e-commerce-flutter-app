import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(64),
      child: Center(
        child: Column(
          children: const [
            SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                strokeWidth: 8.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
