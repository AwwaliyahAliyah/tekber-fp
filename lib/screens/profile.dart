import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../providers/user_provider.dart';
import '../screens/edit_profile.dart';
import '../screens/signin_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                return ClipOval(
                  child: userProvider.profilePicture.startsWith('assets/')
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
                        ),
                );
              },
            ),
            SizedBox(height: 16),

            // Menampilkan nama pengguna
            Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                return Text(
                  userProvider.name.isNotEmpty ? userProvider.name : 'Username',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              },
            ),
            SizedBox(height: 8),

            // Menampilkan email
            Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                return Text(
                  userProvider.email.isNotEmpty
                      ? userProvider.email
                      : 'email@example.com',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                );
              },
            ),
            SizedBox(height: 24),

            // Menampilkan tanggal bergabung
            Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                return buildProfileDetailRow(
                  Icons.calendar_today,
                  'Tanggal Bergabung:',
                  userProvider.joinDate.isNotEmpty
                      ? userProvider.joinDate
                      : '01 November 2024',
                );
              },
            ),
            SizedBox(height: 16),

            // Menampilkan jumlah catatan
            Consumer<NoteProvider>(
              builder: (context, noteProvider, _) {
                return buildProfileDetailRow(
                  Icons.note,
                  'Jumlah Catatan:',
                  '${noteProvider.notes.length}',
                );
              },
            ),
            SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
              icon: Icon(Icons.edit),
              label: Text("Edit Profil"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.grey[100],
                backgroundColor: Colors.teal[400], // For text and icon color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Tombol Logout
            ElevatedButton.icon(
              onPressed: () {
                // Logika untuk log out
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Log Out"),
                    content: Text("Apakah Anda yakin ingin logout?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Tutup dialog
                        },
                        child: Text("Batal"),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<UserProvider>(context, listen: false)
                              .logout();
                          Navigator.pop(context); // Tutup dialog
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
                          );
                        },
                        child: Text("Log Out"),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.logout),
              label: Text("Log Out"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.grey[100],
                backgroundColor: Colors.red.shade400,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileDetailRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.teal[400]),
        SizedBox(width: 8),
        Text(
          '$label ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }
}
