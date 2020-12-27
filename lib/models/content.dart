class Content {
    Content({
        this.content,
        this.audio,
        this.id,
    });

    String content;
    String audio;
    String id;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        content: json["content"],
        audio: json["audio"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "audio": audio,
        "id": id,
    };
}