import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';
import 'package:january_project/screens/details_screen.dart';
import 'package:january_project/screens/notification_screen.dart';
import 'package:january_project/styles/color_class.dart';
import 'package:january_project/widget/custom_container.dart';
import 'package:january_project/widget/custom_text_field.dart';
import 'package:january_project/widget/home_carousel.dart';
import 'package:january_project/widget/items_card.dart';

class HomeScreen extends StatefulWidget {
  final List<PerfumeModel> cart;
  const HomeScreen({super.key, required this.cart});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'All';
  String searchText = '';

  List<String> categories = [
    'All',
    'Men',
    'Women',
    'Packages',
    'Kids',
    'Hair',
    'Body',
  ];

  List<PerfumeModel> filterPerfumes(List<PerfumeModel> perfumes) {
    return perfumes.where((perfume) {
      final matchesCategory =
          selectedFilter == 'All' || perfume.category == selectedFilter;
      final searchByUser = perfume.name.toLowerCase().contains(
        searchText.toLowerCase(),
      );
      return matchesCategory && searchByUser;
    }).toList();
  }

  // Toggle favorite per user
  Future<void> toggleFavorite(PerfumeModel perfume) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

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
        'image': perfume.image,
        'category': perfume.category,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorClass.backG, Colors.white],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header + Search
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Find Your Treasure",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "One Piece Store",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Averia',
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.notifications_none_rounded,
                                color: ColorClass.icons,
                                size: 28,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationsScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      CustomTextField(
                        keyType: TextInputType.text,
                        labl: 'Search',
                        hint: "Find your signature scent...",
                        preIcon: Icon(
                          Icons.search_rounded,
                          color: ColorClass.icons.withOpacity(0.6),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const HomeCarousel(),
                      const SizedBox(height: 25),
                      const Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              // Categories
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedFilter == categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CustomContainer(
                          text: categories[index],
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              selectedFilter = categories[index];
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Products from Firestore
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('perfumes')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final perfumes = snapshot.data!.docs
                      .map((doc) => PerfumeModel.fromFirestore(doc))
                      .toList();

                  final filtered = filterPerfumes(perfumes);

                  if (filtered.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            "No items match your search",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final perfume = filtered[index];
                        return StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('favorite')
                              .doc(perfume.id)
                              .snapshots(),
                          builder: (context, favSnapshot) {
                            final isFav =
                                favSnapshot.hasData && favSnapshot.data!.exists;

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsScreen(mad: perfume),
                                  ),
                                );
                              },
                              child: ItemsCard(
                                perfume: perfume,
                                toggleFavorite: toggleFavorite,
                                isFav: isFav,
                              ),
                            );
                          },
                        );
                      }, childCount: filtered.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.7,
                          ),
                    ),
                  );
                },
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }
}
