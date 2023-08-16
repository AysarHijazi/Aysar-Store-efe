import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: FutureBuilder<QuerySnapshot?>(
        future: _buildCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("Cart is empty"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var itemData =
              snapshot.data!.docs[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(itemData["name"]),
                subtitle: Text("\$ ${itemData["price"]}"),
                leading: Image.network(itemData["images"][0]),
              );
            },
          );
        },
      ),
    );
  }

  Future<QuerySnapshot?> _buildCartItems() async {
    final user = _auth.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection("users-cart-items")
          .doc(user.email)
          .collection("items")
          .get();
    } else {
      return null;
    }
  }
}
