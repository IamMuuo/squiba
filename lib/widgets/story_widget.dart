import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/screens/story_screen.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({
    super.key,
    required this.stories,
    required this.imageUrl,
  });
  final String imageUrl;
  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StoryScreen(stories: stories)));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: CircleAvatar(
                radius: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                  ),
                ),
              ),
            ),
          ),
        ),
        FutureBuilder(
          future: userProvider.fetchUser(stories[0].user),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SizedBox();
            }
            return Text("@${snapshot.data?.username ?? 'anon'}");
          },
        ),
      ],
    );
  }
}
