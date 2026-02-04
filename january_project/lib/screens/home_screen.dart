import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';
import 'package:january_project/screens/details_screen.dart';
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

  // منطق الفلترة المدمج: يجمع بين التصنيف المختار ونص البحث
  List<PerfumeModel> get fliteredPerfumes {
    return perfumesList.where((perfume) {
      final matchesCategory =
          selectedFilter == 'All' || perfume.category == selectedFilter;

      final searchByUser = perfume.name.toLowerCase().contains(
        searchText.toLowerCase(),
      );

      return matchesCategory && searchByUser;
    }).toList();
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
              /// ===== Header & Search Section (Updated) =====
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row: Title + Notification
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Find Your Treasure",
                                style: TextStyle(
                                  color: Colors.grey[600], // لون أهدأ
                                  fontSize: 13, // حجم أصغر قليلاً
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "One Piece Store",
                                style: TextStyle(
                                  fontSize: 26, // تكبير العنوان الرئيسي
                                  fontWeight:
                                      FontWeight.w900, // خط عريض جداً للهوية
                                  fontFamily: 'Averia',
                                ),
                              ),
                            ],
                          ),
                          // Notification Icon inside a soft circle
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle, // شكل دائري أرقى
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
                              onPressed: () {},
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
                          color: ColorClass.icons.withOpacity(
                            0.6,
                          ),
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

              /// ===== Categories Horizontal List =====
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

              /// ===== Animated Grid Products =====
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: fliteredPerfumes.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "No items match your search",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    mad: fliteredPerfumes[index],
                                    cart: widget.cart,
                                  ),
                                ),
                              );
                            },
                            child: ItemsCard(perfume: fliteredPerfumes[index]),
                          );
                        }, childCount: fliteredPerfumes.length),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.7,
                            ),
                      ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }
}
