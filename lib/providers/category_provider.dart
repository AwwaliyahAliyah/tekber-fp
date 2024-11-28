import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../data/category_data.dart';

class CategoryProvider with ChangeNotifier {

  List<Category> _categories = [...initialCategories]; // Menggunakan data dari category_data.dart

  List<Category> get categories => _categories;

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }
}
