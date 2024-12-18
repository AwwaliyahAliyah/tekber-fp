import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

Uint8List? _webImage; // Variable to store image bytes for web

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  Uint8List? _webImage; // For Web
  File? _mobileImage;   // For Mobile
  String? _name;
  String? _email;

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      if (kIsWeb) {
        // For Web: Read as bytes
        final bytes = await pickedImage.readAsBytes();
        setState(() {
          _webImage = bytes;
        });
        userProvider.updateProfilePictureBytes(bytes);
      } else {
        // For Mobile: Use File
        setState(() {
          _mobileImage = File(pickedImage.path);
        });
        userProvider.updateProfilePictureFile(File(pickedImage.path));
      }
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
                        child: kIsWeb
                            ? (_webImage != null
                                ? Image.memory(_webImage!, width: 120, height: 120, fit: BoxFit.cover)
                                : userProvider.profilePictureBytes != null
                                    ? Image.memory(userProvider.profilePictureBytes!, width: 120, height: 120, fit: BoxFit.cover)
                                    : Image.asset('assets/images/default_profile.jpg', width: 120, height: 120))
                            : (_mobileImage != null
                                ? Image.file(_mobileImage!, width: 120, height: 120, fit: BoxFit.cover)
                                : userProvider.profilePictureFile != null
                                    ? Image.file(userProvider.profilePictureFile!, width: 120, height: 120, fit: BoxFit.cover)
                                    : Image.asset('assets/images/default_profile.jpg', width: 120, height: 120)),
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
