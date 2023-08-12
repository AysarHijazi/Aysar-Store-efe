import 'package:aysaarprojectefe/Screens/ButtomNavigationScreen/ButtomNavigationScreen.dart';
import 'package:aysaarprojectefe/Screens/authentication/Login.dart';
import 'package:aysaarprojectefe/Screens/authentication/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:aysaarprojectefe/Screens/SplachScreen/SplachScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
// WelcomeScreen(),

      // Login(),
      SplachScreen(),
      // BottomNavigationScreen(),
    );
  }
}