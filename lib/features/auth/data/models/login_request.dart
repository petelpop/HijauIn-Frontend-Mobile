import 'dart:convert';

class LoginRequest {
  final String emailOrUsername;
  final String password;

  LoginRequest({
    required this.emailOrUsername,
    required this.password,
  });

  LoginRequest copyWith({
    String? emailOrUsername,
    String? password,
  }) =>
      LoginRequest(
        emailOrUsername: emailOrUsername ?? this.emailOrUsername,
        password: password ?? this.password,
      );

  factory LoginRequest.fromRawJson(String str) =>
      LoginRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        emailOrUsername: json["emailOrUsername"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "emailOrUsername": emailOrUsername,
        "password": password,
      };
}
