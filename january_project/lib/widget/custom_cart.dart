import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';

class CustomCart extends StatelessWidget {
  PerfumeModel cart;
  CustomCart({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Row(
          children: [
            Image.asset(cart.image),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cart.name,
                    maxLines: 1,
                    overflow: TextOverflow
                        .ellipsis, 
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${cart.price}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
