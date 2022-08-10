import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/model/user.dart';

ValueNotifier<Setting> settingNotify = ValueNotifier(Setting());

class Setting {
  String? appName = 'Demo';
  static Setting? _setting;
  String? uuId;
  Function? onUpdate;

  String? token;
  User? user;

  Setting({this.token, this.user});

  static void setSetting(Setting setting) {
    _setting = setting;
  }

  static void init(Function complete) async {
    if (_setting == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? json = prefs.getString("setting");
      print("my json >>>$json");
      if (json != null) {
        _setting = Setting.fromJson(json);
      } else {
        _setting = Setting();
      }
      _setting?.onUpdate = () async {
        print(">>>>>>>>>>>>>>>>>>>");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? toJson = _setting?.toJson();
        prefs.setString("setting", toJson ?? "");
      };
      settingNotify.value = _setting!;
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      settingNotify.notifyListeners();
      // _setting.uuId = await Global.instance.uuId();
    }
    complete();
  }

  static Setting? newInstance() {
    if (_setting == null) {
      print("Setting null");
      return Setting();
    }
    return _setting;
  }

  factory Setting.fromJson(String str) => Setting.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Setting.fromMap(Map<String, dynamic> json) => Setting(
        token: json["access_token"],
        user: json["user"] == null ? null : User.fromRawJson(json["user"]),
        // localization: json["localization"] ?? 'en',
      );

  Map<String, dynamic> toMap() => {
        "access_token": token,
        "user": user == null ? null : user?.toRawJson(),
        // "localization": localization ?? 'en'
      };

  void setToken(String id) {
    token = id;
    onUpdate!();
  }

  void setUser(User user) {
    this.user = user;
    onUpdate!();
  }

  bool isLogin() {
    return token != null && token?.isNotEmpty == true;
  }

  void save() {
    onUpdate!();
  }

  // static void notifySetting() {
  //   settingNotify.value = _setting!;
  //   // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  //   settingNotify.notifyListeners();
  // }

  // void setLanguage(String str) {
  //   this.localization = str;
  //   // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  //   notifySetting();
  //   onUpdate();
  // }

  // Locale get getLanguage {
  //   return Locale(localization ?? 'en', '');
  // }

  // String get getLanguageStr {
  //   return localization ?? 'en';
  // }
}
