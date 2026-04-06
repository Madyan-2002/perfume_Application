import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';
import 'package:january_project/widget/custom_cart.dart';
import 'package:january_project/styles/color_class.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback onGoShopping;

  const CartScreen({super.key, required this.onGoShopping});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text("Please login first")));
    }

    return Scaffold(
      backgroundColor: ColorClass.backG,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final cartItems = snapshot.data!.docs
              .map((doc) => PerfumeModel.fromFirestore(doc))
              .toList();

          if (cartItems.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              /// 🔥 HEADER
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Cart (${cartItems.length})",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// 🗑️ CLEAR ALL
                    InkWell(
                      onTap: () async {
                        final confirm = await showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: const Text("Clear Cart"),
                            content: const Text(
                              "Are you sure you want to delete all items?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          final collection = FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .collection('cart');

                          final snapshot = await collection.get();

                          for (var doc in snapshot.docs) {
                            await doc.reference.delete();
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 🔥 DIVIDER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),

              const SizedBox(height: 10),

              /// 🔥 LIST
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];

                    return Dismissible(
                      key: ValueKey(item.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      onDismissed: (_) async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .collection('cart')
                            .doc(item.id)
                            .delete();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${item.name} removed from cart"),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        child: CustomCart(cart: item),
                      ),
                    );
                  },
                ),
              ),

              /// 🔥 TOTAL PRICE
              _buildTotalSection(cartItems),
            ],
          );
        },
      ),
    );
  }

  /// 🔥 TOTAL
  Widget _buildTotalSection(List<PerfumeModel> cartItems) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: ColorClass.mad,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Price',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Text(
                  'Inclusive of VAT',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
            Text(
              '${calculateTotal(cartItems).toStringAsFixed(2)} \$',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 CALCULATE
  double calculateTotal(List<PerfumeModel> cart) {
    return cart.fold(0, (sum, item) => sum + (item.price * (item.quantity)));
  }

  /// 🔥 EMPTY STATE
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_mall_outlined, size: 100, color: Colors.grey[300]),
            const SizedBox(height: 24),
            const Text(
              "Your cart is empty",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "Start adding your favorite perfumes",
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: widget.onGoShopping,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorClass.mad,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text("Start Shopping"),
            ),
          ],
        ),
      ),
    );
  }
}
