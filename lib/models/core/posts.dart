class Post {
  int? id;
  int user;
  String? content;
  DateTime datePosted;
  String description;
  int? likes;
  List<int>? likedBy;

  Post({
    this.id,
    required this.user,
    this.content,
    required this.datePosted,
    required this.description,
    this.likes = 0,
    this.likedBy,
  });

  // Method to convert JSON to Dart object
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      user: json['user'],
      content: json['content'],
      datePosted: DateTime.parse(json['date_posted']),
      description: json['description'],
      likes: json['likes'],
      likedBy: List<int>.from(json['liked_by'].map((x) => x)),
    );
  }

  // Method to convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'content': content,
      'date_posted': datePosted.toIso8601String(),
      'description': description,
      'likes': likes,
      'liked_by': likedBy,
    };
  }
}
