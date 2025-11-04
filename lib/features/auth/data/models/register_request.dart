import 'dart:convert';

class RegisterRequest {
    final String namaPanggilan;
    final String username;
    final String email;
    final String password;
    final String confirmPassword;

    RegisterRequest({
        required this.namaPanggilan,
        required this.username,
        required this.email,
        required this.password,
        required this.confirmPassword,
    });

    RegisterRequest copyWith({
        String? namaPanggilan,
        String? username,
        String? email,
        String? password,
        String? confirmPassword,
    }) => RegisterRequest(
            namaPanggilan: namaPanggilan ?? this.namaPanggilan,
            username: username ?? this.username,
            email: email ?? this.email,
            password: password ?? this.password,
            confirmPassword: confirmPassword ?? this.confirmPassword,
        );

    factory RegisterRequest.fromRawJson(String str) => RegisterRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RegisterRequest.fromJson(Map<String, dynamic> json) => RegisterRequest(
        namaPanggilan: json["nama_panggilan"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
    );

    Map<String, dynamic> toJson() => {
        "nama_panggilan": namaPanggilan,
        "username": username,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
    };
}
