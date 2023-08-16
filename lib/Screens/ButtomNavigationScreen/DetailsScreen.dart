import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_item.dart';

class CatDetailsScreen extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;

  CatDetailsScreen({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Price: $price',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // إضافة القط إلى السلة
                final cartItem = CartItem(name: name, price: price);
                // قم بتحديث حالة المحلية لتضمين القط في السلة
                // يمكنك استخدام Provider أو InheritedWidget لإدارة الحالة
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
