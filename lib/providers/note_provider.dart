import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../data/note_data.dart';

class NoteProvider with ChangeNotifier {
  
  List<Note> _notes = [...dummyNotes]; // Menggunakan data dari note_data.dart

  List<Note> get notes => _notes;

  List<Note> get favoriteNotes =>
      _notes.where((note) => note.isFavorite).toList();

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void toggleFavorite(Note note) {
    note.isFavorite = !note.isFavorite;
    notifyListeners();
  }

  void updateNote(Note oldNote, Note updatedNote) {
    final noteIndex = _notes.indexOf(oldNote);
    if (noteIndex != -1) {
      _notes[noteIndex] = updatedNote;
      notifyListeners();
    }
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }
}
