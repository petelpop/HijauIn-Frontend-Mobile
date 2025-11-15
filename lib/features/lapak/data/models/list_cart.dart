import 'dart:convert';

class ListCart {
    final String message;
    final Data data;

    ListCart({
        required this.message,
        required this.data,
    });

    ListCart copyWith({
        String? message,
        Data? data,
    }) => 
        ListCart(
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory ListCart.fromRawJson(String str) => ListCart.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ListCart.fromJson(Map<String, dynamic> json) => ListCart(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    final String id;
    final String userId;
    final List<Item> items;
    final Summary summary;
    final DateTime createdAt;
    final DateTime updatedAt;

    Data({
        required this.id,
        required this.userId,
        required this.items,
        required this.summary,
        required this.createdAt,
        required this.updatedAt,
    });

    Data copyWith({
        String? id,
        String? userId,
        List<Item>? items,
        Summary? summary,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Data(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            items: items ?? this.items,
            summary: summary ?? this.summary,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["userId"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        summary: Summary.fromJson(json["summary"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "summary": summary.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Item {
    final String id;
    final Product product;
    final int quantity;
    final int subtotal;

    Item({
        required this.id,
        required this.product,
        required this.quantity,
        required this.subtotal,
    });

    Item copyWith({
        String? id,
        Product? product,
        int? quantity,
        int? subtotal,
    }) => 
        Item(
            id: id ?? this.id,
            product: product ?? this.product,
            quantity: quantity ?? this.quantity,
            subtotal: subtotal ?? this.subtotal,
        );

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        subtotal: json["subtotal"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "quantity": quantity,
        "subtotal": subtotal,
    };
}

class Product {
    final String id;
    final String name;
    final String description;
    final int price;
    final int stock;
    final String imageUrl;
    final Category category;

    Product({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.stock,
        required this.imageUrl,
        required this.category,
    });

    Product copyWith({
        String? id,
        String? name,
        String? description,
        int? price,
        int? stock,
        String? imageUrl,
        Category? category,
    }) => 
        Product(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            price: price ?? this.price,
            stock: stock ?? this.stock,
            imageUrl: imageUrl ?? this.imageUrl,
            category: category ?? this.category,
        );

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        imageUrl: json["image_url"],
        category: Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "image_url": imageUrl,
        "category": category.toJson(),
    };
}

class Category {
    final String id;
    final String name;
    final String description;
    final String imageUrl;
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
        String? imageUrl,
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

class Summary {
    final int totalItems;
    final int totalAmount;
    final String totalAmountFormatted;

    Summary({
        required this.totalItems,
        required this.totalAmount,
        required this.totalAmountFormatted,
    });

    Summary copyWith({
        int? totalItems,
        int? totalAmount,
        String? totalAmountFormatted,
    }) => 
        Summary(
            totalItems: totalItems ?? this.totalItems,
            totalAmount: totalAmount ?? this.totalAmount,
            totalAmountFormatted: totalAmountFormatted ?? this.totalAmountFormatted,
        );

    factory Summary.fromRawJson(String str) => Summary.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        totalItems: json["totalItems"],
        totalAmount: json["totalAmount"],
        totalAmountFormatted: json["totalAmountFormatted"],
    );

    Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "totalAmount": totalAmount,
        "totalAmountFormatted": totalAmountFormatted,
    };
}
