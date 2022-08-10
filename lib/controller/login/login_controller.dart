import 'package:flutter/material.dart';
import 'package:untitled/Screen/home/home_screen.dart';
import 'package:untitled/api/login/login_api.dart';

class LoginController {
  final _api = LoginApi();

  Future<void> login(BuildContext context, String username, String password) async {
    await _api.login(username, password).then((value) {
      debugPrint("Successful");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }
}
