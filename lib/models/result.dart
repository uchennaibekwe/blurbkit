// // To parse this JSON data, do
// //
// //     final result = resultFromJson(jsonString);

// import 'dart:convert';

import 'package:blurbkit/models/book.dart';
import 'package:blurbkit/models/bookmark.dart';
import 'package:blurbkit/models/category.dart';

// Result resultFromJson(String str) => Result.fromJson(json.decode(str));

// String resultToJson(Result data) => json.encode(data.toJson());

// class Result {
//     Result({
//         this.links,
//         this.total,
//         this.totalPages,
//         this.currentPage,
//         this.pageSize,
//         this.books,
//         this.categories,
//     });

//     Links links;
//     int total;
//     int totalPages;
//     int currentPage;
//     int pageSize;
//     List<Book> books;
//     List<Category> categories;

//     factory Result.fromJson(Map<String, dynamic> json) => Result(
//         links: Links.fromJson(json["links"]),
//         total: json["total"],
//         totalPages: json["total_pages"],
//         currentPage: json["current_page"],
//         pageSize: json["page_size"],
//         books: List<Book>.from(json["results"].map((x) => Book.fromJson(x))),
//     );

//     factory Result.fromJsonCategories(Map<String, dynamic> json) => Result(
//         links: Links.fromJson(json["links"]),
//         total: json["total"],
//         totalPages: json["total_pages"],
//         currentPage: json["current_page"],
//         pageSize: json["page_size"],
//         categories: List<Category>.from(json["results"].map((x) => Category.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "links": links.toJson(),
//         "total": total,
//         "total_pages": totalPages,
//         "current_page": currentPage,
//         "page_size": pageSize,
//         "results": List<dynamic>.from(books.map((x) => x.toJson())),
//     };
// }

// class Links {
//     Links({
//         this.next,
//         this.previous,
//     });

//     dynamic next;
//     dynamic previous;

//     factory Links.fromJson(Map<String, dynamic> json) => Links(
//         next: json["next"],
//         previous: json["previous"],
//     );

//     Map<String, dynamic> toJson() => {
//         "next": next,
//         "previous": previous,
//     };
// }

import 'dart:convert';

// Result resultFromJson(String str) => Result.fromJson(json.decode(str));

// String resultToJson(Result data) => json.encode(data.toJson());

class Result {
    Result({
        this.links,
        this.total,
        this.totalPages,
        this.currentPage,
        this.pageSize,
        this.books,
        this.categories,
        this.bookmarks
    });

    Links links;
    int total;
    int totalPages;
    int currentPage;
    int pageSize;
    List<Book> books;
    List<Category> categories;
    List<Bookmark> bookmarks;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        links: Links.fromJson(json["links"]),
        total: json["total"],
        totalPages: json["total_pages"],
        currentPage: json["current_page"],
        pageSize: json["page_size"],
        books: List<Book>.from(json["results"].map((x) => Book.fromJson(x))),
    );
    
    factory Result.fromJsonCategories(Map<String, dynamic> json) => Result(
        links: Links.fromJson(json["links"]),
        total: json["total"],
        totalPages: json["total_pages"],
        currentPage: json["current_page"],
        pageSize: json["page_size"],
        categories: List<Category>.from(json["results"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJsonBooks() => {
        "links": links.toJson(),
        "total": total,
        "total_pages": totalPages,
        "current_page": currentPage,
        "page_size": pageSize,
        "results": List<dynamic>.from(books.map((x) => x.toJson())),
    };

    factory Result.fromJsonBookmark(Map<String, dynamic> json) => Result(
        links: Links.fromJson(json["links"]),
        total: json["total"],
        totalPages: json["total_pages"],
        currentPage: json["current_page"],
        pageSize: json["page_size"],
        bookmarks: List<Bookmark>.from(json["results"].map((x) => Bookmark.fromJson(x))),
    );

    Map<String, dynamic> toJsonBookmark() => {
        "links": links.toJson(),
        "total": total,
        "total_pages": totalPages,
        "current_page": currentPage,
        "page_size": pageSize,
        "bookmarks": List<dynamic>.from(bookmarks.map((x) => x.toJson())),
    };
}

class Links {
    Links({
        this.next,
        this.previous,
    });

    dynamic next;
    dynamic previous;

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json["next"],
        previous: json["previous"],
    );

    Map<String, dynamic> toJson() => {
        "next": next,
        "previous": previous,
    };
}

// class Book {
//     Book({
//         this.id,
//         this.contents,
//         this.createdAt,
//         this.updatedAt,
//         this.deleted,
//         this.title,
//         this.description,
//         this.audioTime,
//         this.noOfPages,
//         this.thumbnail,
//         this.status,
//         this.category,
//         this.author,
//     });

//     String id;
//     List<Content> contents;
//     DateTime createdAt;
//     DateTime updatedAt;
//     bool deleted;
//     String title;
//     String description;
//     int audioTime;
//     int noOfPages;
//     String thumbnail;
//     String status;
//     dynamic category;
//     dynamic author;

//     factory Book.fromJson(Map<String, dynamic> json) => Book(
//         id: json["id"],
//         contents: List<Content>.from(json["contents"].map((x) => Content.fromJson(x))),
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         deleted: json["deleted"],
//         title: json["title"],
//         description: json["description"],
//         audioTime: json["audio_time"],
//         noOfPages: json["no_of_pages"],
//         thumbnail: json["thumbnail"],
//         status: json["status"],
//         category: json["category"],
//         author: json["author"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "deleted": deleted,
//         "title": title,
//         "description": description,
//         "audio_time": audioTime,
//         "no_of_pages": noOfPages,
//         "thumbnail": thumbnail,
//         "status": status,
//         "category": category,
//         "author": author,
//     };
// }

// class Content {
//     Content({
//         this.content,
//         this.audio,
//         this.id,
//     });

//     String content;
//     String audio;
//     String id;

//     factory Content.fromJson(Map<String, dynamic> json) => Content(
//         content: json["content"],
//         audio: json["audio"],
//         id: json["id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "content": content,
//         "audio": audio,
//         "id": id,
//     };
// }