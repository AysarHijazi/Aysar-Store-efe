import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Options"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choose a payment method:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle payment logic for the chosen method
              },
              child: Text("Credit Card"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle payment logic for the chosen method
              },
              child: Text("PayPal"),
            ),
            // Add more payment options as needed
          ],
        ),
      ),
    );
  }
}
