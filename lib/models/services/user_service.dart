import 'package:squiba/barrel/barrel.dart';
import 'package:dartz/dartz.dart';

class UserService with ApiService {
  Future<Either<Exception, User>> register(
      Map<String, dynamic> userPayload) async {
    debugPrint(userPayload.toString());
    try {
      final response = await post(
        Uri.parse("${ApiService.urlPrefix}/users/register/"),
        body: json.encode(userPayload),
        headers: headers,
      );

      debugPrint(response.body);

      if (response.statusCode != 201) {
        return Left(Exception(jsonDecode(response.body)["error"]));
      }

      return Right(User.fromJson(json.decode(response.body)));
    } catch (e) {
      return Left(
        Exception(
          "Host resolution error please check your internet connection and try again",
        ),
      );
    }
  }
}