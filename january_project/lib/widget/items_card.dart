import 'package:flutter/material.dart';
import 'package:january_project/Model/favorite_provider.dart';
import 'package:january_project/Model/perfume_model.dart';
import 'package:january_project/styles/color_class.dart';
import 'package:provider/provider.dart';

class ItemsCard extends StatelessWidget {
  final PerfumeModel perfume;
  const ItemsCard({super.key, required this.perfume});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), 
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9), // خلفية تبرز المنتج
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Hero(
                    tag: perfume.image, // لإضافة حركة انسيابية عند الضغط
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(perfume.image, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),

              // 2. النصوص (الاسم والسعر)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      perfume.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, 
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorClass.darkGrey,
                        fontFamily: 'Averia',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${perfume.price} \$",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: ColorClass.price, 
                        fontFamily: 'Averia',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
          Positioned(
            top: 15,
            right: 15,
            child: InkWell(
              onTap: () {
                context.read<FavoriteProvider>().toggleFavorite(perfume);
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 4),
                  ],
                ),
                child: Icon(
                  context.watch<FavoriteProvider>().isFavorite(perfume)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.redAccent,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}