import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _joinDate = '';
  String _profilePicture = '';

  String get name => _name;
  String get email => _email;
  String get joinDate => _joinDate;
  String get profilePicture => _profilePicture.isNotEmpty
      ? _profilePicture
      : 'assets/images/default_profile.jpg';

  // Web Image
  Uint8List? _profilePictureBytes;
  Uint8List? get profilePictureBytes => _profilePictureBytes;

  // Mobile Image
  File? _profilePictureFile;
  File? get profilePictureFile => _profilePictureFile;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setJoinDate(String date) {
    _joinDate = date;
    notifyListeners();
  }

  void setProfilePicture(String profilePicture) {
    _profilePicture = profilePicture;
    notifyListeners();
  }

  // Methods to update the profile picture
  void updateProfilePictureBytes(Uint8List bytes) {
    _profilePictureBytes = bytes;
    notifyListeners();
  }

  void updateProfilePictureFile(File file) {
    _profilePictureFile = file;
    notifyListeners();
  }

  void updateUserProfile(String name, String email, String joinDate) {
    _name = name;
    _email = email;
    _joinDate = joinDate;
    _profilePicture = profilePicture;
    notifyListeners();
  }

  // Tambahkan metode logout
  void logout() {
    _name = '';
    _email = '';
    _joinDate = '';
    _profilePicture = '';
    notifyListeners();
  }
}
