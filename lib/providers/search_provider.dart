import 'package:flutter/material.dart';
import '../models/note_model.dart';

class SearchProvider with ChangeNotifier {
  String _searchQuery = '';

  // Getter untuk query pencarian
  String get searchQuery => _searchQuery;

  // Setter untuk mengubah query pencarian
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners(); // Memberitahu listener bahwa pencarian telah berubah
  }

  // Fungsi untuk mendapatkan catatan yang sesuai dengan query pencarian
  List<Note> searchNotes(List<Note> notes) {
    if (_searchQuery.isEmpty) {
      return notes; // Jika tidak ada query pencarian, kembalikan semua catatan
    }
    return notes
        .where((note) =>
            note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            note.content.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList(); // Filter catatan berdasarkan query pencarian
  }
}
