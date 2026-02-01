import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';
import 'package:january_project/screens/details_screen.dart';
import 'package:january_project/styles/color_class.dart';
import 'package:january_project/widget/custom_container.dart';
import 'package:january_project/widget/custom_text_field.dart';
import 'package:january_project/widget/home_carousel.dart';
import 'package:january_project/widget/items_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
              /// ===== Header & Search Section =====
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Find Your Treasure",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "One Piece Store",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Averia',
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.notifications_none_rounded,
                                color: ColorClass.icons,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        keyType: TextInputType.text,
                        labl: 'Search',
                        hint: "Find your signature scent...",
                        preIcon: Icon(
                          Icons.search_rounded,
                          color: ColorClass.icons,
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                      ),

                      const SizedBox(height: 20),
                      const HomeCarousel(),
                      const SizedBox(height: 20),

                      const Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
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
