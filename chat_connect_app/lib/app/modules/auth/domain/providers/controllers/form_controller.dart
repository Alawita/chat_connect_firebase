import 'package:flutter/material.dart';

class MyAuthFormController extends ChangeNotifier {
  String _userName = "";
  String _email = "";
  String _password = "";
  bool _togglePassword = false;

  String get userName => _userName;
  String get email => _email;
  String get password => _password;
  bool get togglePassword => _togglePassword;

  void setEmailField(String value) {
    _email = value;
    notifyListeners();
  }

  void setUserNameField(String value) {
    _userName = value;
    notifyListeners();
  }

  void setPasswordField(String value) {
    _password = value;
    notifyListeners();
  }

  void togglePasswordIcon() {
    _togglePassword = !_togglePassword;
    notifyListeners();
  }
}