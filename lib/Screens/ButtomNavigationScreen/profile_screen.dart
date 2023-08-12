import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.blueAccent,
      child: Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
