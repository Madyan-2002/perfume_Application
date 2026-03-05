import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:january_project/Model/favorite_provider.dart';
import 'package:january_project/screens/admin_screen.dart';
import 'package:january_project/screens/nav_bar.dart';
import 'package:january_project/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: userState(),
    );
  }

  Widget userState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapShot) {

          if(snapShot.connectionState == ConnectionState.waiting){
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if(!snapShot.hasData) {
            return SplashScreen();
          }
          return FutureBuilder<DocumentSnapshot>(
            future:FirebaseFirestore.instance.collection('users').doc(snapShot.data!.uid).get(),
             builder: (context, AsyncSnapshot<DocumentSnapshot> roleSnapShot){

            if(roleSnapShot.connectionState == ConnectionState.waiting){
              return Scaffold(
                body: Center(child: CircularProgressIndicator(),)
              );
            }

             if(!roleSnapShot.hasData) {
              return Scaffold(
                body:Center(child: Text('Error loading user data'),)
              );
             }

              if(roleSnapShot.hasData && roleSnapShot.data!.exists){
                final data = roleSnapShot.data!.data() as Map<String , dynamic>;

                final role = data['role'];

                if (role == 'user'){
                  return NavBar();
                }
                else if (role == 'admin'){
                  return AdminScreen();
                }
              }

               return SplashScreen();
             }
             );
        }
        );
  }
}
