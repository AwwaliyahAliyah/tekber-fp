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
