import 'package:squiba/barrel/barrel.dart';

class User {
  int? id;
  String? firstname;
  String? lastname;
  String? phoneno;
  String? profile;
  bool? active;
  String? email;

  // Maps the user struct to json
  Map<String, dynamic> get toJson {
    return {
      "id": id,
      "first_name": firstname,
      "last_name": lastname,
      "mobile_phone_number": phoneno,
      "profile_photo": profile,
      "active": active,
      "email": email,
    };
  }

  User.fromJson(Map<String, dynamic> json) {
    firstname = json["first_name"];
    lastname = json["last_name"];
    phoneno = json["mobile_phone_number"];
    profile = json["profile_photo"];
    active = json["active"];
    email = json["email"];
  }
}
