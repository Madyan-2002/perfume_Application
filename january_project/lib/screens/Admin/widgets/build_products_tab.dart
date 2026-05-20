import 'package:flutter/material.dart';
import 'package:january_project/screens/Admin/widgets/build_from_card.dart';
import 'package:january_project/screens/Admin/widgets/build_product_section.dart';

class BuildProductsTab extends StatelessWidget {
  const BuildProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
     return SingleChildScrollView(
      child: Column(
        children: [
          BuildFormCard(),
          const SizedBox(height: 20),
          BuildProductSection(),
        ],
      ),
    );
  }
}