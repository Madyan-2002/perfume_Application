import 'package:flutter/material.dart';
import 'package:january_project/styles/color_class.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5E6),
      appBar: AppBar(
        backgroundColor: ColorClass.mad,
        elevation: 0,
        title: Text(
          'NAVIGATION CENTER',
          style: TextStyle(
            color: ColorClass.price,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            fontFamily: 'Averia',
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1. SEARCH HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: ColorClass.mad,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "How can we help, Nakama?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search for treasure (help)...",
                      prefixIcon: const Icon(Icons.search),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 2. QUICK CONTACT BOXES
                  const Text(
                    "Direct Den Den Mushi (Contact)",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      _contactCard(
                        Icons.chat_bubble_outline,
                        "Live Chat",
                        "2 min wait",
                      ),
                      _contactCard(
                        Icons.email_outlined,
                        "Email Us",
                        "24h response",
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// 3. FAQ SECTION
                  const Text(
                    "Top Questions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildFaqItem(
                    "How to track my ship (order)?",
                    "Go to 'My Orders' in your profile to see the real-time location of your treasure.",
                  ),
                  _buildFaqItem(
                    "Are the perfumes authentic?",
                    "Yes! Every bottle is 100% original, sourced directly from the finest islands in the Grand Line.",
                  ),
                  _buildFaqItem(
                    "How to return a product?",
                    "If the scent doesn't suit your spirit, you can return it within 14 days of arrival.",
                  ),
                  _buildFaqItem(
                    "Do you ship to the New World?",
                    "We ship globally! No island is too far for our crew.",
                  ),

                  const SizedBox(height: 40),

                  /// 4. SOS BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.support_agent,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "TALK TO THE CAPTAIN",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorClass.mad,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactCard(IconData icon, String title, String sub) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: ColorClass.mad, size: 30),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(answer, style: const TextStyle(color: Colors.black54)),
        ),
      ],
    );
  }
}
