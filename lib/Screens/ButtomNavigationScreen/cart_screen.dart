import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.blueAccent,
      child: Center(
        child: Text(
          'Cart Screen',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
