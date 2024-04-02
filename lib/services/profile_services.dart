// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:youapp_flutter/models/profile.dart';
import 'package:youapp_flutter/services/constants.dart';

class ProfileService {
  static Dio dio = Dio();
  static Future<dynamic> getProfile(
    String token,
  ) async {
    Response? response;
    try {
      response = await dio.get(
        "$endPoint/api/getProfile",
        options: Options(
          headers: {"Content-Type": "application/json", "x-access-token": token},
        ),
      );
    } on DioException catch (e) {
      var parsedResponse = jsonDecode(e.response.toString());
      return parsedResponse;
    }
    log(response.toString());
    var parsedResponse = jsonDecode(response.toString());
    return parsedResponse;
  }

  static Future<dynamic> createProfile(
    String token,
  ) async {
    Response? response;
    try {
      response = await dio.post(
        "$endPoint/api/createProfile",
        data: {
          "imageUrl": null,
          "name": "",
          "birthday": "",
          "horoscope": "",
          "gender": "",
          "zodiac": "",
          "height": 0,
          "weight": 0,
          "interest": [],
        },
        options: Options(
          headers: {"Content-Type": "application/json", "x-access-token": token},
        ),
      );
    } on DioException catch (e) {
      log(e.toString());
      var parsedResponse = jsonDecode(e.response.toString());
      return parsedResponse;
    }
    var parsedResponse = jsonDecode(response.toString());
    return parsedResponse;
  }

  static Future<dynamic> updateProfile(
    String token, {
    required Profile profile,
  }) async {
    Response? response;
    try {
      log(profile.interests.toString());
      response = await dio.put(
        "$endPoint/api/updateProfile",
        data: {
          if (profile.name != null && profile.name!.isNotEmpty) "name": profile.name,
          if (profile.birthday != null && profile.birthday!.isNotEmpty) "birthday": profile.birthday,
          if (profile.horoscope != null && profile.horoscope!.isNotEmpty) "horoscope": profile.horoscope,
          if (profile.gender != null && profile.gender!.isNotEmpty) "gender": profile.gender,
          if (profile.zodiac != null && profile.zodiac!.isNotEmpty) "zodiac": profile.zodiac,
          if (profile.height != null && profile.height != 0) "height": profile.height,
          if (profile.weight != null && profile.weight != 0) "weight": profile.weight,
          if (profile.interests.isNotEmpty) "interests": profile.interests,
        },
        options: Options(
          headers: {"Content-Type": "application/json", "x-access-token": token},
        ),
      );
    } on DioException catch (e) {
      log(e.toString());
      var parsedResponse = jsonDecode(e.response.toString());
      return parsedResponse;
    }
    var parsedResponse = jsonDecode(response.toString());
    return parsedResponse;
  }

  static Future<dynamic> changeImage({
    required File file,
    required String token,
  }) async {
    String fileName = file.path.split('/').last;
    var fileExt = fileName.split('.').last;
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType("image", fileExt),
      ),
    });
    Response? response;
    try {
      response = await dio.post(
        "$endPoint/api/profileImage",
        data: formData,
        options: Options(
          headers: {"Content-Type": "application/json", "x-access-token": token},
        ),
      );
    } on DioException catch (e) {
      var parsedResponse = jsonDecode(e.response.toString());
      return parsedResponse;
    }
    var parsedResponse = jsonDecode(response.toString());
    return parsedResponse;
  }
}
