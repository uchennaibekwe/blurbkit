
import 'content.dart';

class Book {
    Book({
        this.id,
        this.contents,
        this.createdAt,
        this.updatedAt,
        this.deleted,
        this.title,
        this.description,
        this.audioTime,
        this.noOfPages,
        this.thumbnail,
        this.status,
        this.category,
        this.author,
    });

    String id;
    List<Content> contents;
    DateTime createdAt;
    DateTime updatedAt;
    bool deleted;
    String title;
    String description;
    int audioTime;
    int noOfPages;
    String thumbnail;
    String status;
    dynamic category;
    dynamic author;

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        contents: List<Content>.from(json["contents"].map((x) => Content.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deleted: json["deleted"],
        title: json["title"],
        description: json["description"],
        audioTime: json["audio_time"],
        noOfPages: json["no_of_pages"],
        thumbnail: json["thumbnail"],
        status: json["status"],
        category: json["category"],
        author: json["author"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted": deleted,
        "title": title,
        "description": description,
        "audio_time": audioTime,
        "no_of_pages": noOfPages,
        "thumbnail": thumbnail,
        "status": status,
        "category": category,
        "author": author,
    };
}
