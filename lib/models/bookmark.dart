class Bookmark {
    Bookmark({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.deleted,
        this.user,
        this.book,
    });

    String id;
    DateTime createdAt;
    DateTime updatedAt;
    bool deleted;
    String user;
    String book;

    factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deleted: json["deleted"],
        user: json["user"],
        book: json["book"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted": deleted,
        "user": user,
        "book": book,
    };
}