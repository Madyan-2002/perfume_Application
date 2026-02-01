import 'dart:async';
import 'package:flutter/material.dart';
import 'package:january_project/screens/login_screen.dart';
import 'package:january_project/styles/color_class.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: .topCenter,
                end: .bottomCenter,
                colors: [
                  Color.fromARGB(205, 0, 45, 57),
                  Color(0xCD01313e),
                  Color.fromARGB(205, 0, 45, 57),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Text(
                  "One Piece",
                  style: TextStyle(
                    color: ColorClass.primary,
                    fontSize: 40,
                    fontWeight: .bold,
                    fontFamily: "Averia",
                  ),
                ),

                CircularProgressIndicator(color: Colors.white, strokeWidth: 5),
              ],
            ),
          ),
          Positioned(
            bottom: -30,
            left: -10,
            child: Image.asset(
              "assets/images/one.jpeg",
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
