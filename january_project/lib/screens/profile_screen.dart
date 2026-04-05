import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:january_project/screens/cart_screen.dart';
import 'package:january_project/screens/favorite_screen.dart';
import 'package:january_project/screens/register_login_screen.dart';
import 'package:january_project/styles/color_class.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _uploading = false;

  Future<void> _pickAndUploadImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (picked == null) return;
    setState(() => _uploading = true);
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final ref = FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');
      await ref.putFile(File(picked.path));
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(uid).update({'image': url});
    } catch (e) {
      debugPrint('Upload error: $e');
    } finally {
      setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const Scaffold(body: Center(child: Text('Not logged in')));

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final name = data['name'] ?? 'User';
          final email = data['email'] ?? '';
          final imageUrl = data['image'] ?? '';

          return Column(
            children: [
              /// HEADER
              Container(
                color: ColorClass.mad,
                padding: const EdgeInsets.only(top: 60, bottom: 0),
                child: Column(
                  children: [
                    /// Avatar
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 44,
                          backgroundColor: Colors.white24,
                          backgroundImage: imageUrl.isNotEmpty
                              ? NetworkImage(imageUrl)
                              : const AssetImage('assets/images/luffy.jpeg') as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _uploading ? null : _pickAndUploadImage,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.white,
                              child: _uploading
                                  ?  SizedBox(
                                      width: 12,
                                      height: 12,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: ColorClass.mad),
                                    )
                                  :  Icon(Icons.camera_alt, size: 14,  color: ColorClass.mad),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(email, style: const TextStyle(fontSize: 13, color: Colors.white70)),
                    const SizedBox(height: 16),
                    /// Stats
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.white24, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          _statItem('12', 'Orders'),
                          _statItem('5', 'Wishlist'),
                          _statItem('3', 'Reviews'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// LIST
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  children: [
                    _sectionLabel('Account'),
                    _card([
                      _row(Icons.person_outline, 'Edit Profile', 'Name', () {
                        
                      }),
                      _row(Icons.lock_outline, 'Change Password', 'Update your password', () {
                        
                      }),
                    ]),
                    _sectionLabel('Shopping'),
                    _card([
                      _row(Icons.shopping_bag_outlined, 'My Orders', '12 orders', () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => CartScreen(onGoShopping: () => Navigator.pop(context)),
                        ));
                      }),
                      _row(Icons.favorite_border, 'Wishlist', '5 items saved', () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => FavoriteScreen(onGoShopping: () => Navigator.pop(context)),
                        ));
                      }),
                      _row(Icons.location_on_outlined, 'Shipping Address', 'Manage addresses', () {}),
                      _row(Icons.payment_outlined, 'Payment Methods', 'Cards & wallets', () {}),
                    ]),
                    _sectionLabel('Settings'),
                    _card([
                      _row(Icons.notifications_none, 'Notifications', null, () {}),
                      _row(Icons.language, 'Language', null, () {}),
                      _row(Icons.help_outline, 'Help Center', null, () {}),
                      _row(Icons.info_outline, 'About App', null, () {}),
                    ]),
                    const SizedBox(height: 8),
                    /// Logout
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: ColorClass.mad.withOpacity(0.2)),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 34, height: 34,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: const Icon(Icons.logout, color: Colors.redAccent, size: 18),
                        ),
                        title: const Text('Logout', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.redAccent),
                        onTap: () async {
                          await GoogleSignIn().signOut();
                          await FirebaseAuth.instance.signOut();
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (_) => const RegisterLoginScreen()),
                              (route) => false,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _statItem(String number, String label) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: const BoxDecoration(
            border: Border(right: BorderSide(color: Colors.white24, width: 0.5)),
          ),
          child: Column(
            children: [
              Text(number, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
              const SizedBox(height: 2),
              Text(label, style: const TextStyle(fontSize: 11, color: Colors.white70)),
            ],
          ),
        ),
      );

  Widget _sectionLabel(String title) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 6, left: 4),
        child: Text(title.toUpperCase(),
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                color: ColorClass.mad, letterSpacing: 1)),
      );

  Widget _card(List<Widget> rows) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ColorClass.mad.withOpacity(0.15)),
        ),
        child: Column(children: rows),
      );

  Widget _row(IconData icon, String title, String? subtitle, VoidCallback onTap) => Column(
        children: [
          ListTile(
            leading: Container(
              width: 34, height: 34,
              decoration: BoxDecoration(
                color: ColorClass.mad.withOpacity(0.1),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(icon, color: ColorClass.mad, size: 18),
            ),
            title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            subtitle: subtitle != null
                ? Text(subtitle, style: const TextStyle(fontSize: 12))
                : null,
            trailing: Icon(Icons.arrow_forward_ios, size: 14, color: ColorClass.mad),
            onTap: onTap,
          ),
        ],
      );
}