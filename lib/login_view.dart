/*
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //SplashProvider provider = SplashProvider();
  final String password = "mypass";
  final String clientId = "wingmarket";
  final String grantType = "password";
  final String clientSecret = "mypass";

  TextEditingController accTxtController = TextEditingController(text: '');

  var envName = '';
  // void mapEnvironmentName() {
  //   switch (Environment.shared.env) {
  //     case EnvironmentType.dev:
  //       envName = '- Dev';
  //       break;
  //     case EnvironmentType.staging:
  //       envName = '- Stage';
  //       break;
  //     case EnvironmentType.uat:
  //       envName = '';
  //       break;
  //     case EnvironmentType.pvt:
  //       envName = '';
  //       break;
  //     default:
  //       envName = '-';
  //   }
  // }

  @override
  void initState() {
    super.initState();
    //mapEnvironmentName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetPath.wingLogo,
                  height: 60,
                ),
                SizeBox(height: 48),
                TextFormField(
                  key: const Key('loginTxt'),
                  controller: accTxtController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    hintText: 'Input Account number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: 10.radius,
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: 10.radius,
                      borderSide: const BorderSide(color: Colors.greyr),
                    ),
                  ),
                ),
                16.height,
                VFlatButton(
                  key: const Key("loginBtn"),
                  title: "Login",
                  height: 48.0,
                  onPressed: () {
                    //showLoading();
                    getToken(accTxtController.text);
                  },
                ),
                64.height,
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 32.0,
              child: Text(
                'For Testing Purpose Only. $envName',
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }

  void getToken(String wac) {
    provider
        .authorizeUser(
      clientId: clientId,
      clientSecret: clientSecret,
      grantType: grantType,
      password: password,
      username: wac,
    )
        .then((response) async {
      if (response != null) {
        final data = json.decode(response);

        if (data['access_token'] != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs
              .setString(
            PrefKeys.accessToken,
            data['access_token'],
          )
              .then((value) {
            //fetchAccountList();
          });
        } else {
          Navigator.pop(context);
         // Get.offAllNamed(Routes.eligible);
        }
      } else {
        Navigator.pop(context);
        //Get.snackbar("Unauthorized User", "Something went wrong!");
      }
    }).catchError((e) {
      Navigator.pop(context);
      if (e is SocketException) {
       //Get.snackbar("Error", "No internet connection.");
      } else {
        //Get.snackbar("Error", "$e");
      }
    });
  }

  // void showLoading() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       //return const LoadingWidget(key: Key("loginLoading"));
  //     },
  //   );
  // }


}
*/
