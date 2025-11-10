import 'dart:convert';

class AqiHomeData {
    final String status;
    final AqiHomeDataModel data;

    AqiHomeData({
        required this.status,
        required this.data,
    });

    AqiHomeData copyWith({
        String? status,
        AqiHomeDataModel? data,
    }) => 
        AqiHomeData(
            status: status ?? this.status,
            data: data ?? this.data,
        );

    factory AqiHomeData.fromRawJson(String str) => AqiHomeData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AqiHomeData.fromJson(Map<String, dynamic> json) => AqiHomeData(
        status: json["status"],
        data: AqiHomeDataModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class AqiHomeDataModel {
    final int aqi;
    final int idx;
    final List<Attribution> attributions;
    final City city;
    final String dominentpol;

    AqiHomeDataModel({
        required this.aqi,
        required this.idx,
        required this.attributions,
        required this.city,
        required this.dominentpol,
    });

    AqiHomeDataModel copyWith({
        int? aqi,
        int? idx,
        List<Attribution>? attributions,
        City? city,
        String? dominentpol,
    }) => 
        AqiHomeDataModel(
            aqi: aqi ?? this.aqi,
            idx: idx ?? this.idx,
            attributions: attributions ?? this.attributions,
            city: city ?? this.city,
            dominentpol: dominentpol ?? this.dominentpol,
        );

    factory AqiHomeDataModel.fromRawJson(String str) => AqiHomeDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AqiHomeDataModel.fromJson(Map<String, dynamic> json) => AqiHomeDataModel(
        aqi: json["aqi"],
        idx: json["idx"],
        attributions: List<Attribution>.from(json["attributions"].map((x) => Attribution.fromJson(x))),
        city: City.fromJson(json["city"]),
        dominentpol: json["dominentpol"],
    );

    Map<String, dynamic> toJson() => {
        "aqi": aqi,
        "idx": idx,
        "attributions": List<dynamic>.from(attributions.map((x) => x.toJson())),
        "city": city.toJson(),
        "dominentpol": dominentpol,
    };
}

class Attribution {
    final String url;
    final String name;

    Attribution({
        required this.url,
        required this.name,
    });

    Attribution copyWith({
        String? url,
        String? name,
    }) => 
        Attribution(
            url: url ?? this.url,
            name: name ?? this.name,
        );

    factory Attribution.fromRawJson(String str) => Attribution.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Attribution.fromJson(Map<String, dynamic> json) => Attribution(
        url: json["url"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
    };
}

class City {
    final List<double> geo;
    final String name;
    final String url;
    final String location;

    City({
        required this.geo,
        required this.name,
        required this.url,
        required this.location,
    });

    City copyWith({
        List<double>? geo,
        String? name,
        String? url,
        String? location,
    }) => 
        City(
            geo: geo ?? this.geo,
            name: name ?? this.name,
            url: url ?? this.url,
            location: location ?? this.location,
        );

    factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory City.fromJson(Map<String, dynamic> json) => City(
        geo: List<double>.from(json["geo"].map((x) => x?.toDouble())),
        name: json["name"],
        url: json["url"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "geo": List<dynamic>.from(geo.map((x) => x)),
        "name": name,
        "url": url,
        "location": location,
    };
}