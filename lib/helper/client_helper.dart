import 'dart:convert';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled/Screen/login/login_screen.dart';

import '../main.dart';
import 'Setting.dart';

class ClientHelper {
  static const String serverURL = "http://ec2-3-111-246-190.ap-south-1.compute.amazonaws.com:8080/demo"; //Testing
  static const String message = "You're using testing App."; //Testing

  Client _client = Client();

  ClientHelper();

  Future<Response> post(String urlPath,
      {body,
      Map<String, dynamic>? encoding,
      Map<String, String>? additionalHeader,
      bool ignoreAuthorization = false}) async {
    try {
      ///generate URL
      Uri realUrl = _getRealUrl(urlPath);

      ///generate header
      final header = {
        "content-type": "application/json; charset=utf-8",
        // "X-ClientId": Setting.newInstance().uuId,
        "x-client": "WbNk6U3"
      };
      if (!ignoreAuthorization) {
        final token = Setting.newInstance()?.token;
        header["Authorization"] = "Bearer $token";
      }
      if (additionalHeader != null) {
        header.addAll(additionalHeader);
      }

      ///generate body
      final encodeBody = convert.jsonEncode(body);

      ///generate log
      debugPrint("POST --> $realUrl");
      debugPrint("BODY --> $encodeBody");
      debugPrint("HEAD --> $header");

      ///call api
      final res = await _client.post(realUrl, headers: header, body: encodeBody, encoding: Encoding.getByName('utf-8'));
      debugPrint("POST <-- $realUrl");
      debugPrint("RESP <-- ${res.statusCode} ${res.body}");

      if (res.statusCode == 401 && Setting.newInstance()!.isLogin()) {
        // isResponseCode401();
      }
      return Future.value(res);
    } on Exception catch (ex) {
      debugPrint("ERROR <-- ${ex.toString()}");
      rethrow;
    }
  }

  Future<Response> postLogin(String urlPath,
      {body,
      Map<String, dynamic>? encoding,
      Map<String, String>? additionalHeader,
      bool ignoreAuthorization = false}) async {
    try {
      ///generate URL
      Uri realUrl = _getRealUrl(urlPath);

      ///generate header
      final header = {
        "Content-Type": "application/x-www-form-urlencoded",
        // "X-ClientId": Setting.newInstance().uuId,
        "x-client": "WbNk6U3"
      };
      if (!ignoreAuthorization) {
        header["Authorization"] = "Basic b2F1dGhjbGllbnQxOm9hdXRoc2VjcmV0MQ==";
      }
      if (additionalHeader != null) {
        header.addAll(additionalHeader);
      }

      ///generate log
      debugPrint("POST --> $realUrl");
      debugPrint("BODY --> $body");
      debugPrint("HEAD --> $header");

      ///call api
      final res = await _client.post(
        realUrl,
        headers: header,
        body: body,
      );
      debugPrint("POST <-- $realUrl");
      debugPrint("POST <-- ${res.request}");
      debugPrint("RESP <-- ${res.statusCode} ${res.body}");

      if (res.statusCode == 401 && Setting.newInstance()!.isLogin()) {
        // isResponseCode401();
      }
      return Future.value(res);
    } on Exception catch (ex) {
      debugPrint("ERROR <-- ${ex.toString()}");
      rethrow;
    }
  }

  Future<Response> put(String urlPath,
      {body,
      Map<String, dynamic>? encoding,
      Map<String, String>? additionalHeader,
      bool ignoreAuthorization = false}) async {
    try {
      ///generate URL
      String realUrl;
      if (urlPath.startsWith("http")) {
        realUrl = urlPath;
      } else {
        realUrl = serverURL + urlPath;
      }

      ///generate header
      final header = {
        "content-type": "application/json; charset=utf-8",
        // "X-ClientId": Setting.newInstance().uuId,
        "x-client": "WbNk6U3"
      };
      if (!ignoreAuthorization) {
        final token = Setting.newInstance()?.token;

        header["Authorization"] = "Bearer $token";
      }
      if (additionalHeader != null) {
        header.addAll(additionalHeader);
      }

      ///generate body
      final encodeBody = jsonEncode(body);

      ///generate log
      debugPrint("PUT --> $realUrl");
      debugPrint("BODY --> $encodeBody");
      debugPrint("HEAD --> $header");

      ///call api
      final res = await _client.put(Uri.parse(realUrl), headers: header, body: encodeBody);
      debugPrint("PUT <-- $realUrl");
      debugPrint("RESP <-- ${res.statusCode} ${res.body}");

      if (res.statusCode == 401 && Setting.newInstance()!.isLogin()) {
        // isResponseCode401();
      }
      return Future.value(res);
    } on Exception catch (ex) {
      debugPrint("ERROR <-- ${ex.toString()}");
      rethrow;
    }
  }

  Future<Response> patch(String urlPath,
      {body,
      Map<String, dynamic>? encoding,
      Map<String, String>? additionalHeader,
      bool ignoreAuthorization = false}) async {
    try {
      ///generate URL
      Uri realUrl = _getRealUrl(urlPath);

      ///generate header
      final header = {"content-type": "application/json; charset=utf-8"};
      if (!ignoreAuthorization) {
        final token = Setting.newInstance()?.token;

        header["Authorization"] = "Bearer $token";
      }
      if (additionalHeader != null) {
        header.addAll(additionalHeader);
      }

      ///generate body
      final encodeBody = jsonEncode(body);

      ///generate log
      debugPrint("PUT --> $realUrl");
      debugPrint("BODY --> $encodeBody");
      debugPrint("HEAD --> $header");

      ///call api
      final res = await _client.patch(realUrl, headers: header, body: encodeBody);
      debugPrint("PUT <-- $realUrl");
      debugPrint("RESP <-- ${res.statusCode} ${res.body}");
      if (res.statusCode == 401 && Setting.newInstance()!.isLogin()) {
        // isResponseCode401();
      }
      return Future.value(res);
    } on Exception catch (ex) {
      debugPrint("ERROR <-- ${ex.toString()}");
      rethrow;
    }
  }

  Future<Response> get(urlPath, {Map<String, String>? additionalHeader, bool ignoreAuthorization = false}) async {
    try {
      ///generate URL
      Uri realUrl = _getRealUrl(urlPath);

      ///generate header
      final header = {
        "content-type": "application/json; charset=utf-8",
        // "X-ClientId": Setting.newInstance()?.uuId,
        "x-client": "WbNk6U3"
      };
      if (!ignoreAuthorization) {
        final token = Setting.newInstance()?.token;
        header["Authorization"] = "Bearer $token";
      }
      if (additionalHeader != null) {
        header.addAll(additionalHeader);
      }

      ///generate log
      debugPrint("GET --> $realUrl");
      debugPrint("HEAD --> $header");

      ///call api
      final res = await _client.get(realUrl, headers: header);
      debugPrint("GET <-- $realUrl");
      debugPrint("RESP <-- ${res.statusCode} ${res.body}");
      if (res.statusCode == 401 && Setting.newInstance()!.isLogin()) {
        // isResponseCode401();
      }
      return Future.value(res);
    } on Exception catch (ex) {
      debugPrint("ERROR <-- ${ex.toString()}");
      rethrow;
    }
  }

  Future<Response> delete(urlPath, {Map<String, String>? additionalHeader, bool ignoreAuthorization = false}) async {
    try {
      ///generate URL
      Uri realUrl = _getRealUrl(urlPath);

      ///generate header
      final header = {
        "content-type": "application/json; charset=utf-8",
        // "X-ClientId": Setting.newInstance().uuId,
        "x-client": "WbNk6U3"
      };
      if (!ignoreAuthorization) {
        final token = Setting.newInstance()?.token;
        header["Authorization"] = "Bearer $token";
      }
      if (additionalHeader != null) {
        header.addAll(additionalHeader);
      }

      ///generate log
      debugPrint("DELETE --> $realUrl");
      debugPrint("HEAD --> $header");

      ///call api
      final res = await _client.delete(realUrl, headers: header);
      debugPrint("DELETE <-- $realUrl");
      debugPrint("RESP <-- ${res.statusCode} ${res.body}");
      if (res.statusCode == 401 && Setting.newInstance()!.isLogin()) {
        // isResponseCode401();
      }
      return Future.value(res);
    } on Exception catch (ex) {
      debugPrint("ERROR <-- ${ex.toString()}");
      rethrow;
    }
  }

  void isResponseCode401() {
    var context = MyNavigatorKey.currentContext;
    Navigator.push(
      context!,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Uri _getRealUrl(urlPath) {
    Uri realUrl;
    if (urlPath.startsWith("http")) {
      realUrl = Uri.parse(urlPath);
    } else {
      var url = serverURL + urlPath;
      realUrl = Uri.parse(url);
      print(realUrl);
    }
    return realUrl;
  }
}
