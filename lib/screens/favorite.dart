import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import 'package:progresfp1/widgets/category_section.dart';
import 'package:progresfp1/widgets/note_card.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteNotes = Provider.of<NoteProvider>(context).favoriteNotes;

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search notes',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 24),
          CategorySection(),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: favoriteNotes.length,
              itemBuilder: (context, index) {
                final note = favoriteNotes[index];
                return NoteCard(
                  note: note,
                  onFavoriteToggle: () =>
                      Provider.of<NoteProvider>(context, listen: false)
                          .toggleFavorite(note),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
