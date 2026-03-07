import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';
import 'package:january_project/widget/items_card.dart';
import 'package:january_project/styles/color_class.dart';

class FavoriteScreen extends StatelessWidget {
  final VoidCallback onGoShopping;
  const FavoriteScreen({super.key, required this.onGoShopping});

    String getAssetPath(String imageName) {
    if (imageName.startsWith('assets/')) {
      return imageName;
    }
    return "assets/images/$imageName"; // fallback
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text("Please login to see favorites")),
      );
    }

    return Scaffold(
      backgroundColor: ColorClass.details,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('favorite')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final favPerfumes = snapshot.data!.docs
              .map((doc) => PerfumeModel.fromFirestore(doc))
              .toList();

          if (favPerfumes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text("No favorites yet!",
                      style: TextStyle(color: Colors.grey, fontSize: 18)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: onGoShopping,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorClass.mad,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Start Exploring"),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: favPerfumes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return ItemsCard(
                perfume: favPerfumes[index],
                toggleFavorite: (perfume) async {
                  final favDoc = FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .collection('favorite')
                      .doc(perfume.id);
                  final snapshot = await favDoc.get();
                  if (snapshot.exists) {
                    await favDoc.delete();
                  } else {
                    await favDoc.set({
                      'id': perfume.id,
                      'name': perfume.name,
                      'price': perfume.price,
                      'img': perfume.image,
                      'category': perfume.category,
                      'timestamp': FieldValue.serverTimestamp(),
                    });
                  }
                },
                isFav: true,
              );
            },
          );
        },
      ),
    );
  }
}