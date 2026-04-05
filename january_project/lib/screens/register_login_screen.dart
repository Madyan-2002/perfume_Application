import 'package:flutter/material.dart';
import 'package:january_project/screens/admin_screen.dart';
import 'package:january_project/screens/nav_bar.dart';
import 'package:january_project/styles/color_class.dart';
import 'package:january_project/widget/custom_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterLoginScreen extends StatefulWidget {
  const RegisterLoginScreen({super.key});

  @override
  State<RegisterLoginScreen> createState() => _RegisterLoginScreenState();
}

class _RegisterLoginScreenState extends State<RegisterLoginScreen> {
  TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool pass = true;
  bool isLogin = true;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorClass.backG,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.25,
                    child: Lottie.network(
                      'https://assets9.lottiefiles.com/packages/lf20_mjlh3hcy.json',
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    isLogin ? "Welcome Back" : "Create Account",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    isLogin
                        ? "Log in to your account to continue"
                        : "Register to create a new account",
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),

                  const SizedBox(height: 25),
                  // user Name
                  CustomTextField(
                    controller: nameController,
                    keyType: TextInputType.name,
                    labl: 'Name',
                    hint: 'Enter your name',
                    preIcon: const Icon(Icons.person_outline),
                  ),

                  const SizedBox(height: 15),

                  /// 🔹 Email
                  CustomTextField(
                    controller: emailController,
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

                  const SizedBox(height: 15),

                  /// 🔹 Password
                  CustomTextField(
                    controller: passwordController,
                    valid: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters';
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

                  if (!isLogin) ...[
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: confirmPasswordController,
                      keyType: TextInputType.text,
                      obscureT: pass,
                      labl: 'Confirm Password',
                      hint: '••••••••',
                      preIcon: const Icon(Icons.lock_outline),
                      valid: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],

                  /// 🔹 Forgot Password (فقط في Login)
                  if (isLogin)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Forgot Password?"),
                      ),
                    ),

                  const SizedBox(height: 15),

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
                      onPressed: _handleAuth,
                      child: Text(
                        isLogin ? "Login" : "Register",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 🔹 Continue as Guest
                  if (isLogin)
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
                        onPressed: () async {
                          try {
                            // إنشاء مستخدم مجهول في Firebase
                            await FirebaseAuth.instance.signInAnonymously();

                            if (!mounted) return;

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const NavBar()),
                              (route) => false,
                            );
                          } catch (e) {
                            debugPrint("Guest Login Error: $e");
                          }
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
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () async {
                      await signInWithGoogle();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJg75LWB1zIJt1VTZO7O68yKciaDSkk3KMdw&s',
                          height: 25,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Sign in with Google',
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLogin
                            ? "Don't have an account?"
                            : "Already have an account?",
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(isLogin ? "Register" : "Login"),
                      ),
                    ],
                  ),
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

  Future<void> addUser(UserCredential userCred) async {
    try {
      CollectionReference users = firestore.collection('users');
      await users.doc(userCred.user!.uid).set({
        'name' :nameController.text.trim(),
        'email': emailController.text.trim(),
        'role': 'user',
      });
      print("User document created successfully");
    } catch (e) {
      print("Error adding user to Firestore: $e");
      rethrow;
    }
  }

  Future<String> signUp({
    required String emailAddress,
    required String password,
  }) async {
    try {
      // نحفظ النتيجة في متغير userCred
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

      await addUser(userCred);

      return 'done';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> login({
    required String emailAddress,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return 'done login';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
      return e.message ?? e.code;
    }
  }

  Future<void> _handleAuth() async {
    if (_formKey.currentState!.validate()) {
      String result;

      if (isLogin) {
        result = await login(
          emailAddress: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } else {
        result = await signUp(
          emailAddress: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      }

      if (result == 'done login' || result == 'done') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isLogin ? "Welcome Back!" : "Account Created Successfully!",
            ),
          ),
        );

        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .get();

        if (doc['role'] == 'user') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NavBar()),
          );
        } else if (doc['role'] == 'admin') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AdminScreen()),
          );
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result)));
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCred = await FirebaseAuth.instance
          .signInWithCredential(credential);

      // التحقق مما إذا كان المستخدم جديداً لإضافته إلى Firestore
      final userDoc = await firestore
          .collection('users')
          .doc(userCred.user!.uid)
          .get();

      if (!userDoc.exists) {
        // تعديل بسيط: نأخذ الإيميل من userCred لأن controller قد يكون فارغاً في حال دخول جوجل
        await firestore.collection('users').doc(userCred.user!.uid).set({
          'name': userCred.user!.displayName ?? '',
          'email': userCred.user!.email,
          'role': 'user',
        });
      }

      // بعد النجاح، وجه المستخدم بناءً على الـ Role
      _handleNavigation(userCred.user!.uid);
    } catch (e) {
      print("Google Sign-In Error: $e");
    }
  }

  // دالة مساعدة للتوجيه (Navigation) لتقليل تكرار الكود
  void _handleNavigation(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      String role = doc['role'];
      Widget nextScreen = (role == 'admin')
          ? const AdminScreen()
          : const NavBar();
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => nextScreen));
    }
  }
}
