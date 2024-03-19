import 'package:squiba/barrel/barrel.dart';
import 'package:dartz/dartz.dart';
// import 'package:http/http.dart' as http;

class StoryService with ApiService {
  Future<Either<Exception, List<Story>>> fetchAllStories() async {
    try {
      final response =
          await get(Uri.parse("${ApiService.urlPrefix}/stories/create/"));

      if (response.statusCode != 200) {
        return left(Exception(response.body));
      }
      var stories = jsonDecode(response.body);
      final ss = <Story>[];
      for (var story in stories) {
        ss.add(Story.fromJson(story));
      }
      return Right(ss);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  // Future<Either<Exception, bool>> postStory(
  //   int userID,
  //   File image, {
  //   String? text,
  // }) async {
  //   var request = http.MultipartRequest(
  //       "POST", Uri.parse("${ApiService.urlPrefix}/stories/create"));
  //   request.fields["user"] = userID.toString();
  //   request.fields["text"] = text ?? "";
  //   request.files.add(http.MultipartFile.fromBytes("content", image.readAsBytes()))
  // }
}
