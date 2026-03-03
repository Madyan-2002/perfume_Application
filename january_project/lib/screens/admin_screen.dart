import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final imgController = TextEditingController();

  
  final List<String> categories = [
  'All',
  'Men',
  'Women',
  'Packages',
  'Kids',
  'Hair',
  'Body',
];
String selectedCategory = "All";

  bool isLoading = false;

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
            _inputField("Image URL", imgController),

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
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('perfumes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: data['img'] != null
                    ? Image.network(data['img'], width: 50)
                    : const Icon(Icons.image),
                title: Text(data['name']),
                subtitle: Text("\$${data['price']}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      FirebaseFirestore.instance
                          .collection('perfumes')
                          .doc(data.id)
                          .delete(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _addPerfume() async {
    setState(() => isLoading = true);

    await FirebaseFirestore.instance.collection('perfumes').add({
      'name': nameController.text,
      'price': double.tryParse(priceController.text) ?? 0,
      'description': descController.text,
      'img': imgController.text,
      'category': selectedCategory,
    });

    nameController.clear();
    priceController.clear();
    descController.clear();
    imgController.clear();

    setState(() => isLoading = false);
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}