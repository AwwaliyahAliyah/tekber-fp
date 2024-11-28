import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../providers/search_provider.dart';
import 'package:progresfp1/widgets/category_section.dart';
import 'package:progresfp1/widgets/note_card.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final favoriteNotes = searchProvider.searchNotes(
      Provider.of<NoteProvider>(context).favoriteNotes,
    ); // Mendapatkan hasil pencarian dari favorit notes

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            top: 16.0,
            right: 16.0,
          ),
          child: TextField(
            onChanged: (query) {
              searchProvider.setSearchQuery(query); // Update pencarian
            },
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
        ),
        SizedBox(height: 24),
        // Kategori dengan padding langsung
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: CategorySection(),
        ),
        SizedBox(height: 16),
        // List Favorite Notes
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: favoriteNotes.isEmpty
                  ? Center(
                      child: Text(
                        'No notes found',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
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
        ),
      ],
    );
  }
}
