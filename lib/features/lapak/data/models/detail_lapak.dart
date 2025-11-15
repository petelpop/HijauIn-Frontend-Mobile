import 'dart:convert';

class DetailLapak {
    final String id;
    final String name;
    final String description;
    final int price;
    final int stock;
    final String imageUrl;
    final String categoryId;
    final DateTime createdAt;
    final DateTime updatedAt;
    final Category category;
    final String priceFormatted;

    DetailLapak({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.stock,
        required this.imageUrl,
        required this.categoryId,
        required this.createdAt,
        required this.updatedAt,
        required this.category,
        required this.priceFormatted,
    });

    DetailLapak copyWith({
        String? id,
        String? name,
        String? description,
        int? price,
        int? stock,
        String? imageUrl,
        String? categoryId,
        DateTime? createdAt,
        DateTime? updatedAt,
        Category? category,
        String? priceFormatted,
    }) => 
        DetailLapak(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            price: price ?? this.price,
            stock: stock ?? this.stock,
            imageUrl: imageUrl ?? this.imageUrl,
            categoryId: categoryId ?? this.categoryId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            category: category ?? this.category,
            priceFormatted: priceFormatted ?? this.priceFormatted,
        );

    factory DetailLapak.fromRawJson(String str) => DetailLapak.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DetailLapak.fromJson(Map<String, dynamic> json) => DetailLapak(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        imageUrl: json["image_url"],
        categoryId: json["categoryId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        category: Category.fromJson(json["category"]),
        priceFormatted: json["priceFormatted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "image_url": imageUrl,
        "categoryId": categoryId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "category": category.toJson(),
        "priceFormatted": priceFormatted,
    };
}

class Category {
    final String id;
    final String name;
    final String description;
    final dynamic imageUrl;
    final DateTime createdAt;
    final DateTime updatedAt;

    Category({
        required this.id,
        required this.name,
        required this.description,
        required this.imageUrl,
        required this.createdAt,
        required this.updatedAt,
    });

    Category copyWith({
        String? id,
        String? name,
        String? description,
        dynamic imageUrl,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Category(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            imageUrl: imageUrl ?? this.imageUrl,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
