import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:january_project/screens/register_login_screen.dart';
import 'package:january_project/styles/color_class.dart';
import 'package:january_project/widget/_build_list_view.dart';
import 'package:intl/intl.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.bgAdmin,
      appBar: AppBar(
        backgroundColor: ColorClass.primaryAdmin,
        title: const Text(
          "Perfume Admin",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _signOut,
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildProductsTab(), _buildFeedbacksTab()],
      ),
    );
  }

  Widget _buildFeedbacksTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('feedbacks')
          .orderBy('sent_at', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No messages yet."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var data =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            var docId = snapshot.data!.docs[index].id;
            DateTime? date = (data['sent_at'] as Timestamp?)?.toDate();

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Text(
                  data['sender_email'] ?? 'Anonymous',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorClass.goldAdmin,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      data['content'] ?? '',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      date != null
                          ? DateFormat('yyyy-MM-dd hh:mm a').format(date)
                          : '',
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => FirebaseFirestore.instance
                      .collection('feedbacks')
                      .doc(docId)
                      .delete(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProductsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFormCard(),
          const SizedBox(height: 20),
          _buildProductsSection(),
        ],
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
              color: Colors.black.withValues(alpha: 0.05),
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
                color: ColorClass.primaryAdmin,
              ),
            ),
            const SizedBox(height: 15),
            _inputField("Perfume Name", nameController),
            _inputField("Price", priceController),
            _inputField("Description", descController, maxLines: 2),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Choose Image'),
                ),
                Container(
                  width: 150,
                  height: 35,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      imgName != null
                          ? (imgName!.length > 15
                                ? imgName!.substring(0, 15)
                                : imgName!)
                          : '',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorClass.goldAdmin,
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final img = await imagePicker.pickImage(source: ImageSource.gallery);
    if (img == null) return;
    setState(() {
      isLoading = true;
      imgName = img.name;
    });
    final imgRef = storageRef.child("perfumes/${img.name}");
    await imgRef.putFile(File(img.path));
    imgUrl = await imgRef.getDownloadURL();
    setState(() => isLoading = false);
  }

  Widget _inputField(
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: ColorClass.bgAdmin,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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

  Future<void> _addPerfume() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        imgUrl == null)
      return;
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
    setState(() {
      imgUrl = null;
      imgName = null;
      isLoading = false;
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const RegisterLoginScreen()),
      (route) => false,
    );
  }
}
