import 'dart:convert';

import 'package:untitled/api/abs_api.dart';

import '../../helper/Throwable.dart';

class SignUpAPI extends AbsAPI {
  Future<bool> signup(String username, String password) async {
    final res = await client.post("/api/user/register", body: {'username': username, 'password': password});
    if (res.statusCode == 200) {
      return true;
    } else {
      var code = json.decode(res.body)['code'];
      throw Throwable(statusCode: res.statusCode, error: code);
    }
  }
}
