import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/models/core/posts.dart';
import 'package:squiba/providers/posts_provider.dart';

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
    final _postsProvider = Provider.of<PostProvider>(context);
    final _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
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
                title: TextField(
                  controller: _captionsController,
                  decoration: InputDecoration(
                    hintText: "Whats on your mind",
                    suffixIcon: IconButton(
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
            // SliverList.builder(
            //   itemCount: 2,
            //   itemBuilder: (context, index) {
            //     return Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 12),
            //       child: Container(
            //         color: Colors.white,
            //         height: 100,
            //         width: MediaQuery.of(context).size.width,
            //       ),
            //     );
            //   },
            // )
            SliverFillRemaining(
              hasScrollBody: true,
              child: FutureBuilder(
                future: _postsProvider.fetchPostComments(widget.post.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          "assets/lottie/loading.json",
                          height: 80,
                          width: 80,
                        ),
                        const Text("Fetching Comments")
                      ],
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          FutureBuilder(
                            future: _userProvider.fetchUser(widget.post.user),
                            builder: (context, snapshot) {
                              return CircleAvatar(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data?.profilePhoto ??
                                        "https://i.pinimg.com/564x/20/05/e2/2005e27a39fa5f6d97b2e0a95233b2be.jpg",
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 3),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                  width: 1,
                                )),
                            child: Text(
                              snapshot.data![index].content,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
