import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_item.dart';

class ProfileScreen extends StatelessWidget {
  final List<CartItem> cartItems = []; // قائمة تحتوي على العناصر المضافة إلى السلة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return ListTile(
                  title: Text(cartItem.name),
                  subtitle: Text('Price: ${cartItem.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          // زيادة الكمية بالضغط على الزر الزائد
                          // قم بتحديث الكمية في العنصر المناسب في القائمة
                        },
                        icon: Icon(Icons.add),
                      ),
                      Text(cartItem.quantity.toString()),
                      IconButton(
                        onPressed: () {
                          // تقليل الكمية بالضغط على الزر الناقص
                          // قم بتحديث الكمية في العنصر المناسب في القائمة
                        },
                        icon: Icon(Icons.remove),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // تنفيذ الدفع
              },
              child: Text('Proceed to Payment'),
            ),
          ),
        ],
      ),
    );
  }
}
