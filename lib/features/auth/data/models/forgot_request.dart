import 'dart:convert';

class ForgotRequest {
    final String email;

    ForgotRequest({
        required this.email,
    });

    ForgotRequest copyWith({
        String? email,
    }) => 
        ForgotRequest(
            email: email ?? this.email,
        );

    factory ForgotRequest.fromRawJson(String str) => ForgotRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ForgotRequest.fromJson(Map<String, dynamic> json) => ForgotRequest(
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
    };
}
