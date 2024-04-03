import 'dart:convert';

ErrorHandler errorHandlerFromJson(String str) => ErrorHandler.fromJson(json.decode(str));

String errorHandlerToJson(ErrorHandler data) => json.encode(data.toJson());

class ErrorHandler {
  String? message;
  String? error;
  int? statusCode;

  ErrorHandler({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  factory ErrorHandler.fromJson(Map<String, dynamic> json) => ErrorHandler(
        message: json["message"] == null
            ? null
            : json["message"] is List
                ? json["message"].first
                : json["message"],
        error: json["error"] ?? "",
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "statusCode": statusCode,
      };
}
