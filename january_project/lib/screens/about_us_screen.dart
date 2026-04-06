import 'package:flutter/material.dart';
import 'package:january_project/styles/color_class.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5E6),
      appBar: AppBar(
        backgroundColor: ColorClass.mad,
        elevation: 0,
        title: Text(
          'OUR CREW',
          style: TextStyle(
            color: ColorClass.price,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontFamily: 'Averia',
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.anchor,
            color: Colors.white,
          ), // أيقونة مرساة بدل السهم
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1. THE JOLLY ROGER HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: ColorClass.mad,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // شعار السفينة أو الجمجمة (يمكنك استبدالها بصورة لوفي من الـ assets)
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.explore,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "ONE PIECE PERFUMES",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const Text(
                    "Find Your Treasure Scent",
                    style: TextStyle(
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 2. THE MISSION (THE LOG POSE)
                  _buildSectionTitle("The Captain's Vision"),
                  const SizedBox(height: 10),
                  const Text(
                    "Just like Gol D. Roger left his treasure for the world to find, we have gathered the rarest essences from the Grand Line. Our mission is to make every person feel like the King of the Seas with a single spray.",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// 3. STATS / TREASURES
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoItem("100+", "Islands Explored"),
                      _buildInfoItem("50k", "Happy Pirates"),
                      _buildInfoItem("0", "Bounties Paid"),
                    ],
                  ),

                  const SizedBox(height: 35),

                  /// 4. THE CREW VALUES (GRID)
                  _buildSectionTitle("Our Code of Honor"),
                  const SizedBox(height: 15),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.5,
                    children: [
                      _valueBox(Icons.favorite, "Loyalty"),
                      _valueBox(Icons.auto_fix_high, "Magic Scents"),
                      _valueBox(Icons.shield, "Nakama Spirit"),
                      _valueBox(Icons.directions_boat, "Global Shipping"),
                    ],
                  ),

                  const SizedBox(height: 40),

                  /// 5. FOOTER / JOIN THE CREW
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.sailing, color: ColorClass.mad, size: 40),
                        const SizedBox(height: 10),
                        const Text(
                          "JOIN THE GRAND LINE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        const Text(
                          "support@onepiece-scents.com",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(width: 5, height: 25, color: ColorClass.mad),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: ColorClass.mad,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _valueBox(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
        border: Border.all(color: ColorClass.mad.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: ColorClass.mad),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
