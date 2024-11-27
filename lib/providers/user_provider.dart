import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _joinDate = '';

  String get name => _name;
  String get email => _email;
  String get joinDate => _joinDate;

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
}
