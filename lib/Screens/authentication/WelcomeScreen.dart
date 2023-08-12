import 'package:aysaarprojectefe/Screens/authentication/Login.dart';
import 'package:aysaarprojectefe/Screens/authentication/Signup.dart';
import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xff40e0d0),
                  Color(0xff40e0d0),
                ]
            )
        ),
        child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 200.0),
                child: Image(image: AssetImage('assets/images/logo4.png'),width: 300,
                  height: 200 ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text('Welcome Back',style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(child: Text('SIGN IN',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),),
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Signup()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(child: Text('SIGN UP',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),),
                ),
              ),
              const Spacer(),
              // const Text('Login with Social Media',style: TextStyle(
              //     fontSize: 17,
              //     color: Colors.white
              // ),),//
              // const SizedBox(height: 12,),
              // const Image(image: AssetImage('assets/social.png'))
            ]
        ),
      ),

    );
  }
}
