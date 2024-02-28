import 'package:squiba/barrel/barrel.dart';

class Story {
  final int user;
  final String text;
  final String? content; // Nullable since content can be null
  final String dateUploaded;
  final String dateOfExpiry;
  final String? color; // Hex color code

  Story({
    required this.user,
    required this.text,
    this.content, // Nullable content
    required this.dateUploaded,
    required this.dateOfExpiry,
    required this.color,
  });

  // Factory constructor to create a Story object from a Map
  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      user: json['user'],
      text: json['text'],
      content: json['content'],
      dateUploaded: json['date_uploaded'],
      dateOfExpiry: json['date_of_expiry'],
      color: json['color'],
    );
  }

  // Method to convert a Story object to a Map
  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'text': text,
      'content': content,
      'date_uploaded': dateUploaded,
      'date_of_expiry': dateOfExpiry,
      'color': color,
    };
  }

  // Method to convert the hex color code to a Color object
  Color get colorAsColor {
    final hexCode = color?.replaceFirst('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
