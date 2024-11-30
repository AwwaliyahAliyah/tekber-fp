import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../data/category_data.dart';
import '../models/note_model.dart';

class CategoryProvider with ChangeNotifier {

  List<Category> _categories = [...initialCategories]; // Menggunakan data dari category_data.dart
  Category? _selectedCategory;

  List<Category> get categories => _categories;
  Category? get selectedCategory => _selectedCategory;

  // Method untuk memilih kategori
  void setSelectedCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Method untuk menghapus kategori yang dipilih
  void clearSelectedCategory() {
    _selectedCategory = null;
    notifyListeners();
  }

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }

  // Method untuk mendapatkan catatan berdasarkan kategori yang dipilih
  List<Note> getNotesByCategory(List<Note> allNotes) {
    if (_selectedCategory == null) {
      return allNotes; // Mengembalikan semua catatan jika tidak ada kategori yang dipilih
    }
    return allNotes.where((note) => note.categoryId == _selectedCategory!.id).toList();
  }
}
