import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:january_project/screens/Admin/widgets/build_products_tab.dart';
import 'package:january_project/screens/Admin/widgets/feed_backs_tab.dart';
import 'package:january_project/screens/register_login_screen.dart';
import 'package:january_project/styles/color_class.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const RegisterLoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.bgAdmin,
      appBar: AppBar(
        backgroundColor: ColorClass.primaryAdmin,
        centerTitle: true,
        title: const Text(
          "Perfume Admin",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: ColorClass.goldAdmin,
          labelColor: ColorClass.goldAdmin,
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.add_business), text: "Products"),
            Tab(icon: Icon(Icons.message_outlined), text: "Feedbacks"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [BuildProductsTab(), FeedBacksTab()],
      ),
    );
  }
}
