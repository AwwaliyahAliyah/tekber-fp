import 'package:flutter/material.dart';
import '../screens/models/note_model.dart';
import '../screens/note_detail.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onFavoriteToggle;

  NoteCard({
    required this.note,
    required this.onFavoriteToggle
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(note.title, style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(note.date, style: TextStyle(color: Colors.grey[600])),
          leading: CircleAvatar(
            backgroundColor: Colors.teal[200],
            child: Icon(Icons.book, color: Colors.white),
          ),
          trailing: IconButton(
            icon: Icon(
              note.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: note.isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: onFavoriteToggle,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteDetailScreen(
                  note: note,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
