import 'dart:convert';

import 'package:squiba/barrel/barrel.dart';
import 'package:dartz/dartz.dart';
import 'package:squiba/models/user.dart';

class UserApi {
  Future<Either<Exception, String>> login(String email, String password) async {
    try {
      final uri = Uri.parse("$baseUrl/users/");
      final res = await post(
        uri,
        body: json.encode(
          {"email": email, "password": password},
        ),
      );

      if (res.statusCode != 200) {
        return (left(json.decode(res.body)));
      }
      return (right(json.decode(res.body)));
    } catch (e) {
      return (left(Exception(e)));
    }
  }

  Future<Either<Exception, Map>> signUp(User u) async {
    try {
      final uri = Uri.parse("$baseUrl/users/register/");
      final res = await post(
        uri,
        body: json.encode(
          u.toJson,
        ),
      );

      if (res.statusCode != 200) {
        return (left(json.decode(res.body)));
      }
      return (right(json.decode(res.body)));
    } catch (e) {
      return (left(Exception(e)));
    }
  }
}
