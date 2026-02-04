import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';
import 'package:january_project/screens/cart_screen.dart';
import 'package:january_project/screens/favorite_screen.dart';
import 'package:january_project/screens/home_screen.dart';
import 'package:january_project/screens/profile_screen.dart';
import 'package:january_project/styles/color_class.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<PerfumeModel> cart = [];
  int index = 0;

  void changeIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> screens = [
      HomeScreen(cart: cart),
       FavoriteScreen(
        onGoShopping:() => changeIndex(0),
      ),
      ProfileScreen(cart: cart),
      CartScreen(
        cart: cart, 
        onGoShopping: () => changeIndex(0), // برجعني للهوم
      ),
    ];

    return Scaffold(
      appBar: index == 0 ? null : normalAppBar(),
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorClass.mad,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        currentIndex: index,
        onTap: (value) => setState(() => index = value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
    );
  }

  AppBar normalAppBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
         changeIndex(0);
        },
        child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
      backgroundColor: ColorClass.mad,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "One Piece",
        style: TextStyle(
          fontFamily: 'Averia',
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white24,
            child: const Icon(Icons.notifications_none, color: Colors.white, size: 20),
          ),
        )
      ],
    );
  }
}