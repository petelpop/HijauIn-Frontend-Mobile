import 'dart:convert';

class LoginData {
    final String message;
    final String accessToken;
    final UserData user;

    LoginData({
        required this.message,
        required this.accessToken,
        required this.user,
    });

    LoginData copyWith({
        String? message,
        String? accessToken,
        UserData? user,
    }) => 
        LoginData(
            message: message ?? this.message,
            accessToken: accessToken ?? this.accessToken,
            user: user ?? this.user,
        );

    factory LoginData.fromRawJson(String str) => LoginData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        message: json["message"],
        accessToken: json["access_token"],
        user: UserData.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "access_token": accessToken,
        "user": user.toJson(),
    };
}

class UserData {
    final String id;
    final String email;
    final String username;
    final String namaPanggilan;
    final String role;

    UserData({
        required this.id,
        required this.email,
        required this.username,
        required this.namaPanggilan,
        required this.role,
    });

    UserData copyWith({
        String? id,
        String? email,
        String? username,
        String? namaPanggilan,
        String? role,
    }) => UserData(
            id: id ?? this.id,
            email: email ?? this.email,
            username: username ?? this.username,
            namaPanggilan: namaPanggilan ?? this.namaPanggilan,
            role: role ?? this.role,
        );

    factory UserData.fromRawJson(String str) => UserData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        namaPanggilan: json["nama_panggilan"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "nama_panggilan": namaPanggilan,
        "role": role,
    };
}
