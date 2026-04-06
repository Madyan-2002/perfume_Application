import 'package:flutter/material.dart';
import 'package:january_project/styles/color_class.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, String>> notifications = const [
    {
      'title': '50% Off on Oud Perfume!',
      'subtitle': 'Limited time offer, grab it before it\'s gone.',
      'icon': 'local_offer',
    },
    {
      'title': 'New Arrivals in Store',
      'subtitle': 'Check out the latest fragrances.',
      'icon': 'new_releases',
    },
    {
      'title': 'Free Shipping This Week',
      'subtitle': 'Get free shipping for orders above \$50.',
      'icon': 'local_shipping',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.backG,
      appBar: AppBar(
        backgroundColor: ColorClass.mad,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: ColorClass.lightGrey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorClass.primary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: IconButton(
              icon: Icon(Icons.delete_outline, color: ColorClass.primary),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'No new notifications',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                IconData iconData;
                switch (item['icon']) {
                  case 'local_offer':
                    iconData = Icons.local_offer;
                    break;
                  case 'new_releases':
                    iconData = Icons.new_releases;
                    break;
                  case 'local_shipping':
                    iconData = Icons.local_shipping;
                    break;
                  default:
                    iconData = Icons.notifications;
                }
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: ColorClass.buttons.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(iconData, color: ColorClass.buttons),
                    ),
                    title: Text(
                      item['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      item['subtitle']!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
