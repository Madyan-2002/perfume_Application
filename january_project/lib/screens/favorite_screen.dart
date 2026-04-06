import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';
import 'package:january_project/widget/items_card.dart';
import 'package:january_project/styles/color_class.dart';

class FavoriteScreen extends StatelessWidget {
  final VoidCallback onGoShopping;
  const FavoriteScreen({super.key, required this.onGoShopping});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Please login to see favorites")),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorite')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final favPerfumes = snapshot.data!.docs
            .map((doc) => PerfumeModel.fromFirestore(doc))
            .toList();

        return Scaffold(
          backgroundColor: ColorClass.backG,

          // ✅ AppBar
          appBar: AppBar(
            backgroundColor: ColorClass.backG,
            elevation: 0,
            title: const Text(
              "Favorites",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: favPerfumes.isEmpty
                ? []
                : [
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _confirmClearAll(context, user.uid),
                    ),
                  ],
          ),

          // ✅ Body
          body: favPerfumes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          size: 70,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "No Favorites Yet",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Start adding perfumes you love ❤️",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: onGoShopping,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorClass.mad,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          "Explore Now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 5),

                    // ✅ Divider
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ✅ Grid
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(15),
                        itemCount: favPerfumes.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  // ✅ تأكيد حذف الكل
  Future<void> _confirmClearAll(BuildContext context, String userId) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Clear Favorites"),
        content: const Text("Are you sure you want to remove all favorites?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context);

              final collection = FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .collection('favorite');

              final snapshot = await collection.get();

              for (var doc in snapshot.docs) {
                await doc.reference.delete();
              }
            },
            child: const Text("Delete All"),
          ),
        ],
      ),
    );
  }
}
