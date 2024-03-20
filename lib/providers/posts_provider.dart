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
}
