import 'dart:convert';

class ListCategories {
    final String message;
    final List<Datum> data;

    ListCategories({
        required this.message,
        required this.data,
    });

    ListCategories copyWith({
        String? message,
        List<Datum>? data,
    }) => 
        ListCategories(
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory ListCategories.fromRawJson(String str) => ListCategories.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ListCategories.fromJson(Map<String, dynamic> json) => ListCategories(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    final String id;
    final String name;
    final String description;
    final String? imageUrl;
    final DateTime createdAt;
    final DateTime updatedAt;
    final Count count;

    Datum({
        required this.id,
        required this.name,
        required this.description,
        required this.imageUrl,
        required this.createdAt,
        required this.updatedAt,
        required this.count,
    });

    Datum copyWith({
        String? id,
        String? name,
        String? description,
        String? imageUrl,
        DateTime? createdAt,
        DateTime? updatedAt,
        Count? count,
    }) => 
        Datum(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            imageUrl: imageUrl ?? this.imageUrl,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            count: count ?? this.count,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        count: Count.fromJson(json["_count"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "_count": count.toJson(),
    };
}

class Count {
    final int products;

    Count({
        required this.products,
    });

    Count copyWith({
        int? products,
    }) => 
        Count(
            products: products ?? this.products,
        );

    factory Count.fromRawJson(String str) => Count.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Count.fromJson(Map<String, dynamic> json) => Count(
        products: json["products"],
    );

    Map<String, dynamic> toJson() => {
        "products": products,
    };
}
