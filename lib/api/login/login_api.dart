import 'dart:convert';

import 'package:untitled/api/abs_api.dart';
import 'package:untitled/model/tocken.dart';

import '../../helper/Setting.dart';
import '../../helper/Throwable.dart';

class LoginApi extends AbsAPI {
  Future<Token> login(String username, String password) async {
    final res =
        await client.postLogin("/oauth/token", body: "username=$username&password=$password&grant_type=password");
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      print("123=${data["access_token"]}");
      final token = Token.fromJson(json.decode(res.body));
      print(">>>>${token.accessToken}");
      final setting = Setting.newInstance();
      if (setting != null) {
        setting.setToken(token.accessToken ?? "");
      }
      // await getUser();
      return Future.value(token);
    } else {
      var code = json.decode(res.body)['code'];
      throw Throwable(statusCode: res.statusCode, error: code);
    }
  }
}
