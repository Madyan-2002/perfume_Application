import 'package:flutter/material.dart';
import 'package:january_project/Model/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:january_project/styles/color_class.dart';
import 'package:january_project/widget/items_card.dart';

class FavoriteScreen extends StatelessWidget {
  final VoidCallback onGoShopping;
  const FavoriteScreen({super.key, required this.onGoShopping});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavoriteProvider>();
    final favorites = provider.favItems;

    return Scaffold(
      backgroundColor: ColorClass.details,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // 1. الجزء العلوي: العنوان مع عداد أنيق
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Wishlist",
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF333333),
                          ),
                    ),
                    Text(
                      "${favorites.length} items found",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                // أيقونة سلة المهملات لحذف الكل (اختياري)
                if (favorites.isNotEmpty)
                  IconButton(
                    icon: const Icon(
                      Icons.delete_sweep_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Clear All?"),
                          content: const Text(
                            "Are you sure you want to remove all items from your wishlist?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<FavoriteProvider>().clearAll();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Yes, Clear",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),

            const SizedBox(height: 10),
            Divider(color: Colors.grey[300], thickness: 1, height: 30),

            Expanded(
              child: favorites.isEmpty
                  ? _buildEmptyState()
                  : GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: favorites.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.75,
                          ),
                      itemBuilder: (context, index) {
                        return ItemsCard(perfume: favorites[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 15),
          const Text(
            "Your wishlist is empty!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Explore our perfumes and add your favorites.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: onGoShopping,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorClass.mad,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              child: const Text(
                "Start Exploring",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
