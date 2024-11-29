import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category_model.dart';
import '../providers/category_provider.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();

  IconData? selectedIcon; // Untuk menyimpan ikon yang dipilih
  Color selectedColor = Colors.blue; // Warna default untuk kategori

  // Daftar ikon yang dapat dipilih
  final List<IconData> availableIcons = [
    Icons.person,
    Icons.work,
    Icons.school,
    Icons.directions_car,
    Icons.favorite,
    Icons.sports_soccer,
    Icons.music_note,
    Icons.fastfood,
  ];

  // Fungsi validasi
  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong.';
    }
    return null;
  }

  // Fungsi untuk menyimpan kategori baru
  void _saveCategory() {
    if (_formKey.currentState!.validate() && selectedIcon != null) {
      final newCategory = Category(
        label: _categoryController.text.trim(),
        icon: selectedIcon!,
        color: selectedColor,
      );

      // Menyimpan kategori baru menggunakan provider
      Provider.of<CategoryProvider>(context, listen: false)
          .addCategory(newCategory);

      // Memberikan umpan balik kepada pengguna
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kategori berhasil disimpan!')),
      );
      Navigator.pop(context); // Kembali ke layar sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon pilih ikon dan masukkan nama kategori.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: Text('Tambah Kategori',
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
                // Input untuk nama kategori
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: 'Nama Kategori',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal[400]!),
                    ),
                  ),
                  validator: (value) =>
                      _validateNotEmpty(value, 'Nama Kategori'),
                ),
                SizedBox(height: 16),

                // Pilih ikon
                Text('Pilih Ikon:'),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: availableIcons.map((icon) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIcon = icon;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: selectedIcon == icon
                            ? Colors.grey[400]
                            : Colors.grey[200],
                        child: Icon(icon, color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // Pilih warna
                Text('Pilih Warna:'),
                SizedBox(height: 10),
                Row(
                  children: [
                    _colorPicker(Colors.cyan[100]!),
                    _colorPicker(Colors.blue[100]!),
                    _colorPicker(Colors.red[100]!),
                    _colorPicker(Colors.green[100]!),
                    _colorPicker(Colors.lime[100]!),
                    _colorPicker(Colors.orange[100]!),
                    _colorPicker(Colors.purple[100]!),
                    _colorPicker(Colors.brown[100]!),
                  ],
                ),
                SizedBox(height: 18),

                // Tombol Simpan
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _saveCategory,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        elevation: 6,
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

  // Widget untuk memilih warna
  Widget _colorPicker(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: selectedColor == color
              ? Border.all(color: Colors.black, width: 1.5)
              : null,
        ),
      ),
    );
  }
}
