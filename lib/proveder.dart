import 'package:flutter/material.dart';

class UsernameProvider extends ChangeNotifier {
  String _username = 'Lifeline'; // Set the default username here

  String get username => _username;

  set username(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }
}
