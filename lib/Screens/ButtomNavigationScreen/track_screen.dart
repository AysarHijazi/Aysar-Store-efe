import 'package:flutter/material.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.blueAccent,
      child: Center(
        child: Text(
          'Track Screen',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
