import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:january_project/screens/register_login_screen.dart';
import 'package:january_project/widget/_build_list_view.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  final List<String> categories = [
    'Men',
    'Women',
    'Packages',
    'Kids',
    'Hair',
    'Body',
  ];
  String selectedCategory = "Men";

  bool isLoading = false;
  
   final storageRef = FirebaseStorage.instance.ref();
  String? imgName;

  String? imgUrl;

  final Color primary = const Color(0xFF1C1C1C);
  final Color gold = const Color(0xFFC6A75E);
  final Color bg = const Color(0xFFF8F6F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          "Perfume Admin",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _signOut,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildFormCard(),
            const SizedBox(height: 20),
            _buildProductsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              "Add New Perfume",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            const SizedBox(height: 15),
            _inputField("Perfume Name", nameController),
            _inputField("Price", priceController),
            _inputField("Description", descController, maxLines: 2),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: .spaceBetween,

              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: .circular(20)),
                  ),
                  onPressed: () async {
                    final ImagePicker imagePicker = ImagePicker();
                    final img = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );

                    final imgRef = storageRef.child(img!.name);
                    imgName = img.name;
                    setState(() {});
                    await imgRef.putFile(File(img.path));

                    imgUrl = await imgRef.getDownloadURL();
                    setState(() {});
                  },
                  child: Text('Choose img'),
                ),
                Container(
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: .circular(15),
                  ),
                  child: Center(child: Text(imgName?.substring(0, 10) ?? '')),
              
                ),
              ]
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: selectedCategory,
              items: categories
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) =>
                  setState(() => selectedCategory = val.toString()),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: isLoading ? null : _addPerfume,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Add Perfume",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: bg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('perfumes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        final products = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return data;
        }).toList();

        return BuildListView(products: products);
      },
    );
  }

  // دالة إضافة عطر جديد إلى Firestore
  Future<void> _addPerfume() async {
    if (nameController.text.isEmpty || priceController.text.isEmpty) return;

    setState(() => isLoading = true);

    await FirebaseFirestore.instance.collection('perfumes').add({
      'name': nameController.text,
      'price': double.tryParse(priceController.text) ?? 0,
      'description': descController.text,
      'img': imgUrl,
      'category': selectedCategory,
    });

    nameController.clear();
    priceController.clear();
    descController.clear();
    imgUrl = null;
    imgName = null;

    setState(() => isLoading = false);
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const RegisterLoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
