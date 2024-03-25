import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/models/core/posts.dart';

class PostPage extends StatefulWidget {
  const PostPage({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _captionsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              floating: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Ionicons.heart,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Ionicons.trash_bin,
                  ),
                ),
              ],
              bottom: AppBar(
                bottomOpacity: 1,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                title: TextField(
                  controller: _captionsController,
                  decoration: InputDecoration(
                    hintText: "Whats on your mind",
                    suffix: IconButton(
                      onPressed: () {},
                      icon: const Icon(Ionicons.send),
                    ),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: CachedNetworkImage(
                  imageUrl: widget.post.content ??
                      "https://i.pinimg.com/236x/3a/67/19/3a67194f5897030237d83289372cf684.jpg",
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, child, loadingProgress) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          "assets/lottie/loading.json",
                          height: 50,
                        ),
                        const Text("Fetching post")
                      ],
                    );
                  },
                ),
              ),
            ),
            SliverList.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    color: Colors.white,
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
