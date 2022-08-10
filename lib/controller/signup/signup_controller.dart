import 'package:flutter/material.dart';
import 'package:untitled/Screen/login/login_screen.dart';
import 'package:untitled/api/login/signup_api.dart';

class SignupController {
  final _api = SignUpAPI();

  Future<void> signup(BuildContext context, String username, String password) async {
    await _api.signup(username, password).then((value) {
      debugPrint("Successful");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }
}
