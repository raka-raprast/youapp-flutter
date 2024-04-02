import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String username;
  String email;
  int iat;
  int exp;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.iat,
    required this.exp,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        iat: json["iat"],
        exp: json["exp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "iat": iat,
        "exp": exp,
      };
}
