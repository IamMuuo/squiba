import 'dart:typed_data';

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

  Future<Either<Exception, bool>> postStory(
    int userID,
    Uint8List? image, {
    String? text,
  }) async {
    try {
      var request = MultipartRequest(
          "POST", Uri.parse("${ApiService.urlPrefix}/stories/create/"));
      request.fields["user"] = userID.toString();
      request.fields["date_of_expiry"] = DateTime.now().toIso8601String();

      if (text == null && image == null) {
        return Left(Exception("Text or image cannot be null"));
      }

      request.fields["text"] = "Squiba post";
      if (image != null) {
        request.files.add(
          await MultipartFile.fromBytes("content", image,
              filename: "story.jpg"),
        );
      }

      final response = await request.send();

      debugPrint(await response.stream.bytesToString());

      if (response.statusCode != 201) {
        return Left(Exception("Error sending page data"));
      }

      return const Right(true);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
