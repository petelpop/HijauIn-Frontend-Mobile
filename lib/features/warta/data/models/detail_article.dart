import 'dart:convert';

class DetailArticle {
    final String id;
    final String title;
    final String slug;
    final String thumbnailUrl;
    final String content;
    final String authorId;
    final DateTime createdAt;
    final DateTime updatedAt;
    final Author author;

    DetailArticle({
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

    DetailArticle copyWith({
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
        DetailArticle(
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

    factory DetailArticle.fromRawJson(String str) => DetailArticle.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DetailArticle.fromJson(Map<String, dynamic> json) => DetailArticle(
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
