import 'dart:convert';

class User {
  User(
      {this.id,
      this.userName,
      this.fullName,
      this.sdId,
      this.sdName,
      this.roleName,
      this.role,
      this.password,
      this.phone,
      this.token,
      this.accessToken});

  String? id;
  String? userName;
  String? fullName;
  String? sdId;
  String? sdName;
  String? role;
  String? roleName;
  String? password;
  String? phone;
  String? token;
  String? accessToken;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["username"],
        fullName: json["fullname"],
        sdId: json["sdId"],
        sdName: json["sdName"],
        role: json["role"],
        roleName: json["roleName"],
        password: json["password"],
        phone: json["phone"],
        token: json["token"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": userName,
        "fullname": fullName,
        "sdId": sdId,
        "sdName": sdName,
        "role": role,
        "roleName": roleName,
        "password": password,
        "phone": phone,
        "token": token,
        "accessToken": accessToken
      };
}
