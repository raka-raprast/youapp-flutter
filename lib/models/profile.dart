import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  String? imageUrl;
  String? email;
  String? username;
  String? name;
  String? birthday;
  String? gender;
  String? horoscope;
  String? zodiac;
  int? height;
  int? weight;
  List<String> interests;
  late bool isNotEmpty;

  Profile({
    this.imageUrl,
    this.email,
    this.username,
    this.name,
    this.birthday,
    this.gender,
    this.horoscope,
    this.zodiac,
    this.height,
    this.weight,
    required this.interests,
  }) {
    isNotEmpty = _checkNotEmpty();
  }

  bool _checkNotEmpty() {
    return (imageUrl != null && imageUrl!.isNotEmpty) ||
        (birthday != null && birthday!.isNotEmpty) ||
        (horoscope != null && horoscope!.isNotEmpty) ||
        (zodiac != null && zodiac!.isNotEmpty) ||
        (height != null && height != 0) ||
        (weight != null && weight != 0);
  }

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        imageUrl: json["imageUrl"] ?? "",
        email: json["email"] ?? "",
        username: json["username"] ?? "",
        name: json["name"] ?? "",
        birthday: json["birthday"] ?? "",
        gender: json["gender"] ?? "",
        horoscope: json["horoscope"] ?? "",
        zodiac: json["zodiac"] ?? "",
        height: json["height"] ?? 0,
        weight: json["weight"] ?? 0,
        interests: List<String>.from(json["interests"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "email": email,
        "username": username,
        "name": name,
        "birthday": birthday,
        "gender": gender,
        "horoscope": horoscope,
        "zodiac": zodiac,
        "height": height,
        "weight": weight,
        "interests": List<dynamic>.from(interests.map((x) => x)),
      };
}
