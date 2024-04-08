import 'dart:typed_data';

import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/models/core/posts.dart';
import 'package:squiba/models/services/post_service.dart';

class PostProvider extends ChangeNotifier {
  final PostServixe _postService = PostServixe();
  List<Post> posts = <Post>[];
  int currentUserPostCount = 0;

  Future<void> fetchPosts() async {
    final response = await _postService.fetchPosts();
    response.fold((l) {
      Fluttertoast.showToast(msg: l.toString());
    }, (r) {
      posts = r;
    });
  }

  Future<List<Post>> fetchCurrentUserPosts(int userID) async {
    final response = await _postService.fetchCurrentUserPosts(userID);
    return response.fold(
      (l) {
        Fluttertoast.showToast(msg: l.toString());
        return List.empty();
      },
      (r) {
        currentUserPostCount = r.length;
        return r;
      },
    );
  }

  Future<List<Comment>> fetchPostComments(int postID) async {
    final response = await _postService.fetchPostComments(postID);

    return response.fold((l) {
      Fluttertoast.showToast(msg: l.toString());
      return [];
    }, (r) {
      return r;
    });
  }

  Future<bool> postComment(String comment, int post, int user) async {
    Comment c = Comment(
      id: null,
      user: user,
      post: post,
      content: comment,
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
    final res = await _postService.addComment(c);

    return res.fold((l) {
      debugPrint(l.toString());
      Fluttertoast.showToast(msg: l.toString());
      return false;
    }, (r) {
      Fluttertoast.showToast(msg: "Comment succeffully posted");
      notifyListeners();
      return r;
    });
  }

  Future<void> likePost(int postID, int userID) async {
    final res = await _postService.likePost(postID, userID);
    res.fold((l) {
      debugPrint(l.toString());
      Fluttertoast.showToast(msg: l.toString());
      return false;
    }, (r) {
      Fluttertoast.showToast(msg: "Post liked!");
      notifyListeners();
    });
  }

  Future<void> addPost(Uint8List post, String description, int userID) async {
    final res = await _postService.addPost(post, description, userID);
    res.fold((l) {
      debugPrint(l.toString());
      Fluttertoast.showToast(msg: l.toString());
      return false;
    }, (r) {
      Fluttertoast.showToast(msg: "Post successfully added!");
      notifyListeners();
    });
  }
}
