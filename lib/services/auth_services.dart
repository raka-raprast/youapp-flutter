import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:youapp_flutter/services/constants.dart';

class AuthService {
  static Dio dio = Dio();
  static Future<dynamic> login(
    String emailOrUsername,
    String password,
  ) async {
    Response? response;
    try {
      response = await dio.post(
        "$endPoint/api/login",
        data: {
          "email": emailOrUsername,
          "username": emailOrUsername,
          "password": password,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
    } on DioException catch (e) {
      if (e.error.toString().contains("SocketException")) {
        return {"message": "The server is currently down", "error": "SocketException"};
      }
      var parsedResponse = jsonDecode(e.response.toString());
      return parsedResponse;
    }
    var parsedResponse = jsonDecode(response.toString());
    return parsedResponse;
  }

  static Future<dynamic> register(
    String username,
    String email,
    String password,
  ) async {
    Response? response;
    try {
      response = await dio.post(
        "$endPoint/api/register",
        data: {
          "email": email,
          "username": username,
          "password": password,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
    } on DioException catch (e) {
      if (e.error.toString().contains("SocketException")) {
        return {"message": "The server is currently down", "error": "SocketException"};
      }
      var parsedResponse = jsonDecode(e.response.toString());
      return parsedResponse;
    }
    var parsedResponse = jsonDecode(response.toString());
    return parsedResponse;
  }
}
