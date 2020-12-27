class Category {
    Category({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.deleted,
        this.title,
        this.description,
        this.thumbnail,
    });

    String id;
    DateTime createdAt;
    DateTime updatedAt;
    bool deleted;
    String title;
    String description;
    String thumbnail;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deleted: json["deleted"],
        title: json["title"],
        description: json["description"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted": deleted,
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
    };
}
