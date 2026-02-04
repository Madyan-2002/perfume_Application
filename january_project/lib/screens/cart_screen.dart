import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';
import 'package:january_project/widget/custom_cart.dart';
import 'package:january_project/styles/color_class.dart';

class CartScreen extends StatefulWidget {
  final List<PerfumeModel> cart;
  final VoidCallback onGoShopping; 

  const CartScreen({super.key, required this.cart, required this.onGoShopping});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.details,
      body: widget.cart.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final item = widget.cart[index];

                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          margin: const EdgeInsets.symmetric(vertical: 8), // ليتناسب مع الكارت
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(Icons.delete_outline, color: Colors.white, size: 30),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            widget.cart.removeAt(index);
                          });
                          // تنبيه بسيط عند الحذف
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${item.name} removed from cart"), duration: const Duration(seconds: 1)),
                          );
                        },
                        child: CustomCart(cart: item),
                      );
                    },
                  ),
                ),
                // حاوية السعر الإجمالي
                _buildTotalSection(),
              ],
            ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: ColorClass.mad,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))
        ],
      ),
      child: SafeArea( 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
              '${calculateTotal(widget.cart).toStringAsFixed(2)} \$',
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

  double calculateTotal(List<PerfumeModel> cart) {
    return cart.fold(0, (sum, item) => sum + item.price);
  }

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
              "Your scent collection is empty",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Every great story starts with a fragrance. Begin yours by exploring our signature collection.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey[600], height: 1.5),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: widget.onGoShopping,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorClass.mad,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                ),
                child: const Text("Start Exploring", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}