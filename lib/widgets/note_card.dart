import 'package:flutter/material.dart';
import '../screens/note_detail.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String date;
  final String content;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  NoteCard({
    required this.title, 
    required this.date, 
    required this.content, 
    required this.isFavorite, 
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
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(date, style: TextStyle(color: Colors.grey[600])),
          leading: CircleAvatar(
            backgroundColor: Colors.teal[200],
            child: Icon(Icons.book, color: Colors.white),
          ),
          trailing: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: onFavoriteToggle,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteDetailScreen(
                  title: title,
                  date: date,
                  content: content,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
