import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    final FirebaseAuth _auth = FirebaseAuth.instance;

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
              onPressed: () async {
                final user = _auth.currentUser;

                if (user != null) {
                  final cartItem = CartItem(name: name, price: price);
                  await FirebaseFirestore.instance
                      .collection("users-cart-items")
                      .doc(user.email)
                      .collection("items")
                      .add(cartItem.toMap());

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Item added to cart')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You need to log in first')),
                  );
                }
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
