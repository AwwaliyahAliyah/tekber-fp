import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  String? _name;
  String? _email;
  File? _profilePicture;

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery, // Atau ImageSource.camera untuk mengambil foto
    );
    if (pickedImage != null) {
      setState(() {
        _profilePicture = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Mendapatkan lebar layar untuk menyesuaikan ukuran Card
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.grey[100])),
        backgroundColor: Colors.teal[400],
        iconTheme: IconThemeData(color: Colors.grey[100]),
      ),
      backgroundColor: Colors.blueGrey.shade100,

      // Card for form
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Foto Profil
                  Stack(
                    children: [
                      ClipOval(
                        child: _profilePicture != null
                            ? Image.file(
                                _profilePicture!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : (userProvider.profilePicture.startsWith('assets/')
                                ? Image.asset(
                                    userProvider.profilePicture,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(userProvider.profilePicture),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _pickImage,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal[400],
                            ),
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Card for input fields
                  Container(
                    width: screenWidth * 0.9,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            // Input Nama
                            TextFormField(
                              initialValue: userProvider.name,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person),
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onSaved: (value) {
                                _name = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),

                            // Input Email
                            TextFormField(
                              initialValue: userProvider.email,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onSaved: (value) {
                                _email = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Email tidak valid';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),

                  // Tombol Simpan
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        // Perbarui profil pengguna
                        userProvider.updateUserProfile(
                          _name ?? userProvider.name,
                          _email ?? userProvider.email,
                          userProvider.joinDate, // Tidak diubah
                        );

                        if (_profilePicture != null) {
                          userProvider.setProfilePicture(
                              _profilePicture!.path);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Profil berhasil diperbarui')),
                        );

                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[400],
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      elevation: 6,
                    ),
                    child: Text(
                      'Simpan',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[100]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
