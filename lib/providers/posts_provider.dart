import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/models/core/posts.dart';
import 'package:squiba/models/services/post_service.dart';

class PostProvider extends ChangeNotifier {
  final PostServixe _postService = PostServixe();
  List<Post> posts = <Post>[];
  List<Post> currentUserPosts = List.empty();

  Future<void> fetchPosts() async {
    final response = await _postService.fetchPosts();
    response.fold((l) {
      Fluttertoast.showToast(msg: l.toString());
    }, (r) {
      posts = r;
    });
  }

  Future<void> fetchCurrentUserPosts(int userID) async {
    final response = await _postService.fetchCurrentUserPosts(userID);
    response.fold(
      (l) => Fluttertoast.showToast(msg: l.toString()),
      (r) {
        currentUserPosts = r;
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
}
