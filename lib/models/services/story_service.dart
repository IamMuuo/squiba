import 'package:squiba/barrel/barrel.dart';
import 'package:dartz/dartz.dart';

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
}
