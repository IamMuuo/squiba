class Comment {
  final int? id;
  final int user;
  final String content;
  final int post;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment({
    required this.id,
    required this.user,
    required this.content,
    required this.post,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a Comment object from a Map
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      user: json['user'],
      content: json['content'],
      post: json['post'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert a Comment object into a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'content': content,
      'post': post,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
