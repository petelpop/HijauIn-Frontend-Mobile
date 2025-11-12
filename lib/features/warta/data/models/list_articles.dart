import 'dart:convert';

class ListArticles {
    final List<ListArticlesDataModel> data;
    final Meta meta;

    ListArticles({
        required this.data,
        required this.meta,
    });

    ListArticles copyWith({
        List<ListArticlesDataModel>? data,
        Meta? meta,
    }) => 
        ListArticles(
            data: data ?? this.data,
            meta: meta ?? this.meta,
        );

    factory ListArticles.fromRawJson(String str) => ListArticles.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ListArticles.fromJson(Map<String, dynamic> json) => ListArticles(
        data: List<ListArticlesDataModel>.from(json["data"].map((x) => ListArticlesDataModel.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}

class ListArticlesDataModel {
    final String id;
    final String title;
    final String slug;
    final String thumbnailUrl;
    final String content;
    final String authorId;
    final DateTime createdAt;
    final DateTime updatedAt;
    final Author author;

    ListArticlesDataModel({
        required this.id,
        required this.title,
        required this.slug,
        required this.thumbnailUrl,
        required this.content,
        required this.authorId,
        required this.createdAt,
        required this.updatedAt,
        required this.author,
    });

    ListArticlesDataModel copyWith({
        String? id,
        String? title,
        String? slug,
        String? thumbnailUrl,
        String? content,
        String? authorId,
        DateTime? createdAt,
        DateTime? updatedAt,
        Author? author,
    }) => 
        ListArticlesDataModel(
            id: id ?? this.id,
            title: title ?? this.title,
            slug: slug ?? this.slug,
            thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
            content: content ?? this.content,
            authorId: authorId ?? this.authorId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            author: author ?? this.author,
        );

    factory ListArticlesDataModel.fromRawJson(String str) => ListArticlesDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ListArticlesDataModel.fromJson(Map<String, dynamic> json) => ListArticlesDataModel(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        thumbnailUrl: json["thumbnailUrl"],
        content: json["content"],
        authorId: json["authorId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        author: Author.fromJson(json["author"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "thumbnailUrl": thumbnailUrl,
        "content": content,
        "authorId": authorId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "author": author.toJson(),
    };
}

class Author {
    final String id;
    final String namaPanggilan;
    final dynamic avatarUrl;

    Author({
        required this.id,
        required this.namaPanggilan,
        required this.avatarUrl,
    });

    Author copyWith({
        String? id,
        String? namaPanggilan,
        dynamic avatarUrl,
    }) => 
        Author(
            id: id ?? this.id,
            namaPanggilan: namaPanggilan ?? this.namaPanggilan,
            avatarUrl: avatarUrl ?? this.avatarUrl,
        );

    factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        namaPanggilan: json["nama_panggilan"],
        avatarUrl: json["avatar_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_panggilan": namaPanggilan,
        "avatar_url": avatarUrl,
    };
}

class Meta {
    final int total;
    final int page;
    final int limit;
    final int totalPages;

    Meta({
        required this.total,
        required this.page,
        required this.limit,
        required this.totalPages,
    });

    Meta copyWith({
        int? total,
        int? page,
        int? limit,
        int? totalPages,
    }) => 
        Meta(
            total: total ?? this.total,
            page: page ?? this.page,
            limit: limit ?? this.limit,
            totalPages: totalPages ?? this.totalPages,
        );

    factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
    };
}
