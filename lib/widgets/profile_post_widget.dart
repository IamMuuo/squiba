import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/models/core/posts.dart';
import 'package:squiba/screens/post_screen.dart';

class ProfilePostCard extends StatelessWidget {
  const ProfilePostCard({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(8)),
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
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                height: 150,
                fit: BoxFit.cover,
                imageUrl: "${post.content}",
              ),
            ),
            Positioned(
              bottom: 0,
              left: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(
                      Ionicons.heart,
                    ),
                    Text("${post.likes}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
