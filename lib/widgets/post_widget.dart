import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/models/core/posts.dart';
import 'package:squiba/providers/posts_provider.dart';
import 'package:squiba/screens/post_screen.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final _postProvider = Provider.of<PostProvider>(context);

    // userProvider.fetchUser(post.user).then((u) {
    //   user = u!;
    // });
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: GestureDetector(
        onDoubleTap: () async {
          await _postProvider.likePost(
            post.id!,
            userProvider.user.id!,
          );
        },
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return PostPage(post: post);
              },
            ),
          );
        },
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 35,
                child: FutureBuilder(
                  future: userProvider.fetchUser(post.user),
                  builder: (context, snapshot) => Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                            imageUrl: snapshot.data?.profilePhoto ??
                                "https://i.pinimg.com/736x/00/fe/19/00fe191b0c4dde7d29d81c67bee0f0cb.jpg",
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data?.firstName ?? "Anon",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.data?.email ?? "Anon",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const Spacer(),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(Ionicons.share_social_outline),
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 3),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ClipRect(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 350,
                    placeholder: (context, url) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/lottie/dog_loading.json",
                            height: 50),
                        const Text("Fetching post")
                      ],
                    ),
                    imageUrl: post.content ??
                        "https://i.pinimg.com/736x/00/fe/19/00fe191b0c4dde7d29d81c67bee0f0cb.jpg",
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      await _postProvider.likePost(
                        post.id!,
                        userProvider.user.id!,
                      );
                    },
                    icon: post.likedBy!.contains(userProvider.user.id!)
                        ? const Icon(Ionicons.heart, color: Colors.red)
                        : const Icon(Ionicons.heart_outline),
                  ),
                  Text(
                    post.likes.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return PostPage(post: post);
                          },
                        ),
                      );
                    },
                    icon: const Icon(Ionicons.paper_plane_outline),
                  ),
                  const Spacer()
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 8),
                child: Text(
                  post.description,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
