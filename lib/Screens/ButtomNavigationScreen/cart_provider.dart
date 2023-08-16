import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem cartItem) {
    _cartItems.add(cartItem);
    notifyListeners();
  }

// إضافة وظائف أخرى لإزالة العناصر وتحديث الكميات إذا لزم الأمر
}
