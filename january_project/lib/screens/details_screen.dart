import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';
import 'package:january_project/styles/color_class.dart';

class DetailsScreen extends StatelessWidget {
  final PerfumeModel mad;
  final List<PerfumeModel> cart;
  const DetailsScreen({super.key, required this.mad, required this.cart});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorClass.details,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: ColorClass.lightGrey),
        ),
        backgroundColor: ColorClass.mad,
        title: Text(
          mad.name,
          style: TextStyle(
            color: ColorClass.lightGrey,
            fontFamily: 'Averia',
            fontWeight: .bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.favorite, color: ColorClass.lightGrey),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ), // زيادة بسيطة في الحواف لترتيب المحتوى
        child: Column(
          children: [
            // حاوية الصورة
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
                child: Image.asset(mad.image, fit: BoxFit.contain),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(thickness: 1.2),
            const SizedBox(height: 15),

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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                InkWell(
                  onTap: () {
                    cart.add(mad);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${mad.name} added to cart!"),
                        duration: const Duration(seconds: 1),
                        backgroundColor: ColorClass.mad,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    color: ColorClass.mad,
                    child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Center(
                        child: Text(
                          "ADD TO CART",
                          style: const TextStyle(
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
