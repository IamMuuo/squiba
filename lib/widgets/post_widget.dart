import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/models/core/posts.dart';
import 'package:squiba/screens/post_screen.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // userProvider.fetchUser(post.user).then((u) {
    //   user = u!;
    // });
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: GestureDetector(
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
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://i.pinimg.com/736x/00/fe/19/00fe191b0c4dde7d29d81c67bee0f0cb.jpg",
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Anon",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "IamMuuo",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Ionicons.share_social_outline),
                    ),
                  ],
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
                    onPressed: () {},
                    icon: const Icon(Ionicons.heart_outline),
                  ),
                  Text(
                    post.likes.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {},
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
