import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController _feedbackController = TextEditingController();

  void changeIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  Future<void> _sendFeedbackToAdmin() async {
    String message = _feedbackController.text.trim();
    if (message.isEmpty) return;

    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('feedbacks').add({
        'content': message,
        'sender_email': currentUser?.email ?? 'Unknown User',
        'sender_uid': currentUser?.uid ?? 'No ID',
        'sent_at': FieldValue.serverTimestamp(),
        'status': 'unread',
      }).timeout(const Duration(seconds: 8));

      _feedbackController.clear();
      
      if (mounted) {
        Navigator.pop(context); 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Message sent to admin successfully!"), 
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to send: Check your connection"), 
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _showFeedbackSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20, right: 20, top: 25,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Contact Admin", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Type your message here...",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorClass.mad,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: _sendFeedbackToAdmin,
              child: const Text("Send Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(cart: cart),
      FavoriteScreen(onGoShopping: () => changeIndex(0)),
      CartScreen(onGoShopping: () => changeIndex(0)),
      const ProfileScreen(),
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
        onTap: changeIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  AppBar normalAppBar() {
    return AppBar(
      leading: index == 3 ? null : IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
        onPressed: () => changeIndex(0),
      ),
      backgroundColor: ColorClass.mad,
      elevation: 0,
      centerTitle: true,
      title: const Text("One Piece", style: TextStyle(fontFamily: 'Averia', fontSize: 22, color: Colors.white)),
      actions: [
        IconButton(
          onPressed: () { if (index == 3) _showFeedbackSheet(); },
          icon: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white24,
            child: Icon(_actionIcon(), color: Colors.white, size: 18),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  IconData _actionIcon() {
    if (index == 1) return Icons.sort;
    if (index == 2) return Icons.delete_outline;
    if (index == 3) return Icons.support_agent;
    return Icons.notifications_none;
  }
}