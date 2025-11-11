import 'dart:convert';

class WasteLocation {
    final String message;
    final int count;
    final int radius;
    final Filters filters;
    final List<WasteLocationDataModel> data;

    WasteLocation({
        required this.message,
        required this.count,
        required this.radius,
        required this.filters,
        required this.data,
    });

    WasteLocation copyWith({
        String? message,
        int? count,
        int? radius,
        Filters? filters,
        List<WasteLocationDataModel>? data,
    }) => 
        WasteLocation(
            message: message ?? this.message,
            count: count ?? this.count,
            radius: radius ?? this.radius,
            filters: filters ?? this.filters,
            data: data ?? this.data,
        );

    factory WasteLocation.fromRawJson(String str) => WasteLocation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WasteLocation.fromJson(Map<String, dynamic> json) => WasteLocation(
        message: json["message"],
        count: json["count"],
        radius: json["radius"],
        filters: Filters.fromJson(json["filters"]),
        data: List<WasteLocationDataModel>.from(json["data"].map((x) => WasteLocationDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "radius": radius,
        "filters": filters.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class WasteLocationDataModel {
    final String id;
    final String name;
    final String description;
    final String address;
    final List<String> categories;
    final double distance;
    final Coordinates coordinates;
    final String imageUrl;

    WasteLocationDataModel({
        required this.id,
        required this.name,
        required this.description,
        required this.address,
        required this.categories,
        required this.distance,
        required this.coordinates,
        required this.imageUrl,
    });

    WasteLocationDataModel copyWith({
        String? id,
        String? name,
        String? description,
        String? address,
        List<String>? categories,
        double? distance,
        Coordinates? coordinates,
        String? imageUrl,
    }) => 
        WasteLocationDataModel(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            address: address ?? this.address,
            categories: categories ?? this.categories,
            distance: distance ?? this.distance,
            coordinates: coordinates ?? this.coordinates,
            imageUrl: imageUrl ?? this.imageUrl,
        );

    factory WasteLocationDataModel.fromRawJson(String str) => WasteLocationDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WasteLocationDataModel.fromJson(Map<String, dynamic> json) => WasteLocationDataModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        address: json["address"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        distance: json["distance"]?.toDouble(),
        coordinates: Coordinates.fromJson(json["coordinates"]),
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "address": address,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "distance": distance,
        "coordinates": coordinates.toJson(),
        "image_url": imageUrl,
    };
}

class Coordinates {
    final double latitude;
    final double longitude;

    Coordinates({
        required this.latitude,
        required this.longitude,
    });

    Coordinates copyWith({
        double? latitude,
        double? longitude,
    }) => 
        Coordinates(
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
        );

    factory Coordinates.fromRawJson(String str) => Coordinates.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}

class Filters {
    final double latitude;
    final double longitude;
    final int radius;
    final List<String> categories;

    Filters({
        required this.latitude,
        required this.longitude,
        required this.radius,
        required this.categories,
    });

    Filters copyWith({
        double? latitude,
        double? longitude,
        int? radius,
        List<String>? categories,
    }) => 
        Filters(
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
            radius: radius ?? this.radius,
            categories: categories ?? this.categories,
        );

    factory Filters.fromRawJson(String str) => Filters.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        radius: json["radius"],
        categories: List<String>.from(json["categories"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
        "categories": List<dynamic>.from(categories.map((x) => x)),
    };
}
