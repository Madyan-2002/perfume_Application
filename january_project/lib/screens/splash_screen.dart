import 'dart:async';
import 'package:flutter/material.dart';
import 'package:january_project/screens/intro_screen.dart';
import 'package:january_project/screens/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  IntroScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, 
        children: [
          Image.asset(
            "assets/images/logo2.jpeg", 
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Text(
              //   "ONE PIECE",
              //   style: TextStyle(
              //     color: Colors
              //         .white, 
              //     fontSize: 32,
              //     letterSpacing: 8, 
              //     fontWeight: FontWeight.w300,
              //     fontFamily: "Averia",
              //   ),
              // ),
              const SizedBox(height: 70),
              const CircularProgressIndicator(
                color: Colors.white70,
                strokeWidth: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
