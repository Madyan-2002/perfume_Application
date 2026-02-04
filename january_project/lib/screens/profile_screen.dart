import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';
import 'package:january_project/screens/cart_screen.dart';
import 'package:january_project/screens/favorite_screen.dart';
import 'package:january_project/screens/login_screen.dart';
import 'package:january_project/styles/color_class.dart';

class ProfileScreen extends StatelessWidget {
  final List<PerfumeModel> cart;
  const ProfileScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.details,
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorClass.backG, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/luffy.jpeg'),
                ),
                const SizedBox(height: 15),
                Text(
                  "Madyan Malkawi",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Averia',
                  ),
                ),
                Text(
                  "madyan.m005@gmail.com",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          // 2. قائمة الخيارات
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildProfileOption(
                  Icons.shopping_bag_outlined,
                  "My Orders",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(cart: cart, onGoShopping: () {
                          Navigator.pop(context);
                        },),
                      ),
                    );
                  },
                ),
                _buildProfileOption(Icons.favorite_border, "Wishlist", (){
                  
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteScreen(onGoShopping: () {
                          Navigator.pop(context);
                        },),
                      ),
                    );

                }),
                _buildProfileOption(
                  Icons.location_on_outlined,
                  "Shipping Address",(){

                  }
                ),
                _buildProfileOption(Icons.payment_outlined, "Payment Methods", (){

                }),
                const Divider(),
                _buildProfileOption(Icons.logout, "Logout",(){
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  
                }, isExit: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(
    IconData icon,
    String title,
    void Function()? onTap, {
    bool isExit = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isExit ? Colors.redAccent : ColorClass.icons),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
