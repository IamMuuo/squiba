import 'package:dartz/dartz.dart';
import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/models/services/UserApi.dart';
import 'package:squiba/models/user.dart';

class UserHelper {
  final api = UserApi();

  Future<Either<Glitch, User>> signUp(User u) async {
    final result = await api.signUp(u);
    return result.fold(
      (l) => Left(Glitch(message: l.toString())),
      (r) => Right(User.fromJson(r as Map<String, dynamic>)),
    );
  }
}
