import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/note_model.dart';
import '../providers/note_provider.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  // Fungsi validasi
  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong.';
    }
    return null;
  }

  // Fungsi untuk menyimpan catatan baru
  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final newNote = Note(
        title: _titleController.text.trim(),
        date: DateFormat('d MMM yyyy').format(DateTime.now()),
        content: _contentController.text.trim(),
      );

      Provider.of<NoteProvider>(context, listen: false).addNote(newNote);

      // Berikan umpan balik kepada pengguna
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan berhasil disimpan!')),
      );
      Navigator.pop(context); // Kembali ke layar sebelumnya
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: Text('Tambah Catatan',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.grey[100])),
        backgroundColor: Colors.teal[400],
        iconTheme: IconThemeData(color: Colors.grey[300]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input untuk judul
                TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Judul',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal[400]!),
                      ),
                    ),
                    maxLength: 50,
                    validator: (value) => _validateNotEmpty(value, 'Judul')),
                SizedBox(height: 16),

                // Input untuk konten
                TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      labelText: 'Isi Catatan',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal[400]!),
                      ),
                    ),
                    maxLines: 15,
                    minLines: 5,
                    textAlignVertical: TextAlignVertical.top,
                    validator: (value) =>
                        _validateNotEmpty(value, 'Isi Catatan')),
                SizedBox(height: 16),

                // Tombol Simpan
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _saveNote,
                      child: Text(
                        'Simpan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[100],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[400],
                        padding:EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        elevation: 6
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
