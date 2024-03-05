import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/models/core/posts.dart';
import 'package:dartz/dartz.dart';

class PostServixe with ApiService {
  Future<Either<Exception, List<Post>>> fetchPosts() async {
    try {
      final response =
          await get(Uri.parse("${ApiService.urlPrefix}/posts/listings/"));

      if (response.statusCode != 200) {
        return left(Exception(response.body));
      }
      var posts = jsonDecode(response.body);
      final pp = <Post>[];
      for (var story in posts) {
        pp.add(Post.fromJson(story));
      }
      return Right(pp);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
