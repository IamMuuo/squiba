import 'dart:typed_data';

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

  Future<Either<Exception, List<Post>>> fetchCurrentUserPosts(
      int userID) async {
    try {
      final response =
          await get(Uri.parse("${ApiService.urlPrefix}/posts/find/$userID"));
      if (response.statusCode != 200) {
        return left(Exception(response.body));
      }
      List<Map<String, dynamic>> posts =
          jsonDecode(response.body).cast<Map<String, dynamic>>();
      return right(posts.map((e) => Post.fromJson(e)).toList());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, List<Comment>>> fetchPostComments(int postID) async {
    try {
      final response =
          await get(Uri.parse("${ApiService.urlPrefix}/comments/find/$postID"));
      if (response.statusCode != 200) {
        return left(Exception(response.body));
      }

      final rawComments =
          jsonDecode(response.body).cast<Map<String, dynamic>>();

      return right(
          rawComments.map<Comment>((json) => Comment.fromJson(json)).toList());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, bool>> addComment(Comment comment) async {
    print(json.encode(comment));
    try {
      final response = await post(
        Uri.parse(
          "${ApiService.urlPrefix}/comments/create/",
        ),
        headers: headers,
        body: json.encode(comment.toJson()),
      );
      if (response.statusCode != 201) {
        return left(Exception(response.body));
      }
      return right(true);
    } catch (e) {
      return left(Exception(e));
    }
  }

  Future<Either<Exception, bool>> likePost(int postID, int userID) async {
    try {
      final response = await patch(
        Uri.parse("${ApiService.urlPrefix}/posts/like/$postID"),
        headers: headers,
        body: json.encode({
          "user_id": userID,
        }),
      );

      if (response.statusCode != 200) {
        return left(Exception("Failed to like post"));
      }
      return right(true);
    } catch (e) {
      return left(Exception(e));
    }
  }

  Future<Either<Exception, bool>> addPost(
      Uint8List image, String description, int userID) async {
    try {
      var request = MultipartRequest(
          'POST', Uri.parse('${ApiService.urlPrefix}/posts/create/'));

      request.files.add(await MultipartFile.fromBytes(
        "content",
        image,
        filename: "image.jpg",
      ));
      request.fields["description"] = description;
      request.fields["likes"] = 0.toString();
      request.fields["user"] = userID.toString();

      final response = await request.send();

      if (response.statusCode == 201) {
        return right(true);
      } else {
        // debugPrint(response.statusCode.toString());
        // debugPrint(await response.stream.bytesToString());
        return left(Exception("Failed to upload post"));
      }
    } catch (e) {
      debugPrint(e.toString());
      return left(Exception(e.toString()));
    }
  }
}
