import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  final String initialTitle;
  final String initialDate;
  final String initialContent;

  EditNoteScreen({
    required this.initialTitle,
    required this.initialDate,
    required this.initialContent,
  });

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _dateController = TextEditingController(text: widget.initialDate);
    _contentController = TextEditingController(text: widget.initialContent);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Catatan',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[100])
          ),
        backgroundColor: Colors.teal[400],
        iconTheme: IconThemeData(color: Colors.grey[100])
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Judul Catatan
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  labelStyle: TextStyle(color: Colors.teal[800]),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 18, color: Colors.grey[800]),
              ),
            ),
            SizedBox(height: 16),

            // Tanggal Catatan
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Tanggal',
                  labelStyle: TextStyle(color: Colors.teal[800]),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
            ),
            SizedBox(height: 16),

            // Konten Catatan
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.teal[200]!, width: 1),
                ),
                child: TextField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    labelText: 'Konten',
                    labelStyle: TextStyle(color: Colors.teal[800]),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                  maxLines: null,
                  expands: true,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Tombol Simpan
            ElevatedButton.icon(
              onPressed: () {
                // Kembalikan data yang diedit
                Navigator.pop(context, {
                  'title': _titleController.text,
                  'date': _dateController.text,
                  'content': _contentController.text,
                });
              },
              icon: Icon(Icons.save, color: Colors.grey[100]),
              label: Text(
                'Simpan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[100],
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[400],
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                elevation: 6
              ),
            ),
          ],
        ),
      ),
    );
  }
}
