import 'dart:convert';

class Register {
    final String namaPanggilan;
    final String username;
    final String email;
    final String password;
    final String confirmPassword;

    Register({
        required this.namaPanggilan,
        required this.username,
        required this.email,
        required this.password,
        required this.confirmPassword,
    });

    Register copyWith({
        String? namaPanggilan,
        String? username,
        String? email,
        String? password,
        String? confirmPassword,
    }) => 
        Register(
            namaPanggilan: namaPanggilan ?? this.namaPanggilan,
            username: username ?? this.username,
            email: email ?? this.email,
            password: password ?? this.password,
            confirmPassword: confirmPassword ?? this.confirmPassword,
        );

    factory Register.fromRawJson(String str) => Register.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Register.fromJson(Map<String, dynamic> json) => Register(
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
