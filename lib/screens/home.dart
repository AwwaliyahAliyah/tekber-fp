import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progresfp1/widgets/category_section.dart';
import 'package:progresfp1/screens/favorite.dart';
import 'package:progresfp1/screens/profile.dart';
import '../providers/note_provider.dart';
import '../widgets/note_card.dart';
import 'add_note.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Fungsi untuk navigasi tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final notes = noteProvider.notes;

    // Konten untuk setiap tab
    List<Widget> _pages = [
      // Halaman "Home"
      Padding(
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
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return NoteCard(
                    note: note,
                    onFavoriteToggle: () => noteProvider.toggleFavorite(note),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Halaman "Favorit"
      FavoriteScreen(),

      // Halaman "Profil"
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('MyNotes+', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[100])),
        backgroundColor: Colors.teal[400],
        iconTheme: IconThemeData(color: Colors.grey[300]),
        actions: [
          if (_selectedIndex == 0 || _selectedIndex == 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Pengaturan'),
                    content: Text('Fitur pengaturan akan segera hadir!'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Tutup')),
                    ],
                  ),
                );
              },
            ),
          ),

          if (_selectedIndex == 2)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: Icon(Icons.more_vert),
              tooltip: 'Logout',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Logout'),
                    content: Text('Fitur logout akan segera hadir!'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Tutup')),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      body: _pages[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
      ? FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNoteScreen()));
          },
          child: Icon(Icons.add, color: Colors.grey[100]),
          tooltip: 'Tambah Catatan',
          backgroundColor: Colors.teal[400],
        )
      : null,

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal[400],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
