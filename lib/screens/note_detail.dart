import 'package:flutter/material.dart';

class NoteDetailScreen extends StatelessWidget {
  final String title;
  final String date;
  final String content;

  NoteDetailScreen({
    required this.title,
    required this.date,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Catatan',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[100]),
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
                  onPressed: () {
                    // Tambahkan logika hapus catatan di sini
                  },
                  icon: Icon(Icons.delete, color: Colors.grey[100]),
                  label: Text(
                    'Hapus',
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.grey[100]
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[400],
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Tambahkan logika edit catatan di sini
                  },
                  icon: Icon(Icons.edit, color: Colors.grey[100]),
                  label: Text(
                    'Edit', 
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.grey[100]
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[600],
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
