import 'package:flutter/material.dart';
import 'package:progresfp1/screens/edit_note.dart';
import '../models/note_model.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note note;

  NoteDetailScreen({
    required this.note
  });

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late String title;
  late String date;
  late String content;

  @override
  void initState() {
    super.initState();
    title = widget.note.title;
    date = widget.note.date;
    content = widget.note.content;
  }

  void _updateNote(BuildContext context) {
    final updatedNote = Note(
      title: title,
      date: date,
      content: content,
      isFavorite: widget.note.isFavorite, // Mempertahankan status favorit
    );

    Provider.of<NoteProvider>(context, listen: false)
        .updateNote(widget.note, updatedNote);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Catatan berhasil diperbarui!')),
    );

    Navigator.pop(context); // Kembali ke layar sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Catatan',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[100]),
        ),
        backgroundColor: Colors.teal[400],
        iconTheme: IconThemeData(color: Colors.grey[100]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Judul catatan
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[850],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),

            // Tanggal catatan
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.calendar_today, color: Colors.teal[400]),
                SizedBox(width: 8),
                Text(
                  date,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Konten catatan
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.teal[200]!, width: 1),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    content,
                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Tombol aksi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    // Navigasi ke EditNoteScreen
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNoteScreen(
                          initialTitle: title,
                          initialDate: date,
                          initialContent: content,
                        ),
                      ),
                    );

                    // Perbarui data jika ada hasil dari form edit
                    if (result != null) {
                      setState(() {
                        title = result['title'];
                        date = result['date'];
                        content = result['content'];
                      });
                    }
                  },
                  icon: Icon(Icons.edit, color: Colors.grey[100]),
                  label: Text(
                    'Edit',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[100]),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[400],
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateNote(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[100]),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[400],
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
