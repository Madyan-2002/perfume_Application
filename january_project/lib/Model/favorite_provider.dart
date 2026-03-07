import 'package:flutter/material.dart';
import 'package:january_project/Model/perfume_model.dart';

class FavoriteProvider extends ChangeNotifier {
  // القائمة التي ستحتوي على العناصر المختارة فقط
  final List<PerfumeModel> _favItems = [];

  List<PerfumeModel> get favItems => _favItems;
  void clearAll() {
  _favItems.clear();
  notifyListeners(); // تنبيه الشاشات لتحديث الواجهة فوراً
}

  void toggleFavorite(PerfumeModel perfume) {
    if (_favItems.contains(perfume)) {
      _favItems.remove(perfume);
    } else {
      _favItems.add(perfume);
    }
    notifyListeners(); // هذا السطر يحدث الـ NavBar وأي صفحة أخرى مفتوحة
  }

  bool isFavorite(PerfumeModel perfume) => _favItems.contains(perfume);
}