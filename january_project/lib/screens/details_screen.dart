import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';
import 'package:january_project/styles/color_class.dart';

class DetailsScreen extends StatelessWidget {
  final PerfumeModel mad;

  const DetailsScreen({super.key, required this.mad});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorClass.details,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: ColorClass.lightGrey),
        ),
        backgroundColor: ColorClass.mad,
        title: Text(
          mad.name,
          style: TextStyle(
            color: ColorClass.lightGrey,
            fontFamily: 'Averia',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.favorite, color: Colors.white),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// 🔹 IMAGE
            Container(
              height: height * 0.45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorClass.lightGrey,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  mad.image,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(thickness: 1.2),
            const SizedBox(height: 15),

            /// 🔹 DESCRIPTION
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  mad.description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 🔹 PRICE + ADD TO CART
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// PRICE
                Card(
                  elevation: 5,
                  color: ColorClass.details,
                  child: SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.28,
                    child: Center(
                      child: Text(
                        '${mad.price} \$',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorClass.mad,
                        ),
                      ),
                    ),
                  ),
                ),

                /// 🔥 ADD TO CART BUTTON
                InkWell(
                  onTap: () async {
                    final user = FirebaseAuth.instance.currentUser;

                    if (user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please login first")),
                      );
                      return;
                    }

                    final cartRef = FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .collection('cart')
                        .doc(mad.id);

                    final doc = await cartRef.get();

                    if (doc.exists) {
                      /// ✅ المنتج موجود → زوّد الكمية
                      await cartRef.update({
                        'quantity': FieldValue.increment(1),
                      });
                    } else {
                      /// ✅ منتج جديد
                      await cartRef.set({
                        'id': mad.id,
                        'name': mad.name,
                        'price': mad.price,
                        'img': mad.image,
                        'category': mad.category,
                        'description': mad.description,
                        'quantity': 1,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${mad.name} added to cart 🛒"),
                        backgroundColor: ColorClass.mad,
                      ),
                    );
                  },

                  child: Card(
                    elevation: 5,
                    color: ColorClass.mad,
                    child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: const Center(
                        child: Text(
                          "ADD TO CART",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
