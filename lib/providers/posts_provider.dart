import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/models/core/posts.dart';
import 'package:squiba/models/services/post_service.dart';

class PostProvider extends ChangeNotifier {
  final PostServixe _postService = PostServixe();
  List<Post> posts = <Post>[];

  Future<void> fetchPosts() async {
    final response = await _postService.fetchPosts();
    response.fold((l) {
      Fluttertoast.showToast(msg: l.toString());
    }, (r) {
      posts = r;
    });
  }
}
