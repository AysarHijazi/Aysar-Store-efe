import 'package:aysaarprojectefe/Screens/OnBoardingScreen/OnBoardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      // بعد انتهاء الوقت، انتقل إلى الصفحة التالية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF40E0D0),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aysar",
              style: TextStyle(
                fontSize: 50,

                color: Colors.white,
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText(
                  ' Store',
                  textStyle: TextStyle (

                    fontSize: 50,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
