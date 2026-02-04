import 'package:flutter/material.dart';
import 'package:january_project/screens/nav_bar.dart';
import 'package:january_project/styles/color_class.dart';
import 'package:january_project/widget/custom_text_field.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool pass = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorClass.backG,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.30,
                    child: Lottie.network(
                      'https://assets9.lottiefiles.com/packages/lf20_mjlh3hcy.json',
                      frameBuilder: (context, child, composition) {
                        return child;
                      },
                    ),
                  ),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Log in to your account to continue",
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 30),

                  // حقل البريد الإلكتروني
                  CustomTextField(
                    valid: (value) {
                      if (value == null || !checkEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    keyType: TextInputType.emailAddress,
                    labl: 'Email Address',
                    hint: 'name@example.com',
                    preIcon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 10),

                  CustomTextField(
                    valid: (value) {
                      if (value == null || !checkpassword(value)) {
                        return 'Password is too weak';
                      }
                      return null;
                    },
                    keyType: TextInputType.text,
                    labl: 'Password',
                    hint: '••••••••',
                    obscureT: pass,
                    preIcon: const Icon(Icons.lock_outline),
                    sfxIcon: IconButton(
                      icon: Icon(
                        pass ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => setState(() => pass = !pass),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot Password?"),
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorClass.buttons,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const NavBar()),
                            (route) => false,
                          );
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: ColorClass.buttons),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const NavBar()),
                          (route) => false,
                        );
                      },
                      child: Text(
                        'Continue as Guest',
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorClass.buttons,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool checkpassword(String password) {
    String pattern2 =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
    return RegExp(pattern2).hasMatch(password);
  }
}
