import 'package:flutter/foundation.dart';

class AuthValidators {
  // Create error messages to send.

  final String _passwordErrMsg = "Password must have at least 6 characters.";

// A simple email validator that  checks the presence and position of @
  String? emailValidator(String? val) {
    debugPrint("emailValidator $val");
    if (val != null && val.length >= 6) {
      final bool emailValid = RegExp(
              r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$')
          .hasMatch(val);
      if (emailValid) {
        return null;
      }
    }
    return "Emial is Not Valid";
  }

  // Password validator
  String? passwordVlidator(String? val) {
    final String password = val as String;

    if (password.isEmpty || password.length <= 5) return _passwordErrMsg;

    return null;
  }

// user name field validation
  String? userNameValidator(String? val) {
    if (val != null && val.length > 3) {
      return null;
    } else {
      return "User Name must be more than 3 charecters";
    }
  }
}