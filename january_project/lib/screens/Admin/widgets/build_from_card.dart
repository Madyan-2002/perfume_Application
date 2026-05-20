import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:january_project/styles/color_class.dart';

class BuildFormCard extends StatefulWidget {
  const BuildFormCard({super.key});

  @override
  State<BuildFormCard> createState() => _BuildFormCardState();
}

class _BuildFormCardState extends State<BuildFormCard> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  final storageRef = FirebaseStorage.instance.ref();

  bool isLoading = false;
  String? imgName;
  String? imgUrl;
  String selectedCategory = "Men";

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

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _addPerfume() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        imgUrl == null) {
      return;
    }

    setState(() {
      isLoading = true;
    });

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

  @override
  Widget build(BuildContext context) {
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
}
