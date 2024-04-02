import 'dart:convert';

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

class Auth {
  String email;
  String username;
  String? password;

  Auth({
    required this.email,
    required this.username,
    this.password,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        email: json["email"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "password": password,
      };
}
