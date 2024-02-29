import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/widgets/post_widget.dart';
import 'package:squiba/widgets/story_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final storyProvider = Provider.of<StoryProvider>(context);
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 0, right: 0, left: 0, top: 12),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              onStretchTrigger: () async {
                await storyProvider.fetchStories();
              },
              floating: true,
              pinned: true,
              snap: false,
              title: Text(
                "Squiba",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontFamily: GoogleFonts.caveat().fontFamily,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.heart_outline),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.chatbubble_outline),
                )
              ],
            ),

            // Stories
            SliverToBoxAdapter(
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 60,
                    child: GestureDetector(
                      child: CircleAvatar(
                        radius: 60,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: userProvider.user.profilePhoto ??
                                    "https://i.pinimg.com/564x/a6/2b/73/a62b73acb6b9859e1d0d1245287b0f65.jpg",
                              ),
                              const Positioned(
                                right: 4,
                                bottom: 0,
                                child: Icon(
                                  Ionicons.add_circle,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width - 60,
                    child: FutureBuilder(
                      future: storyProvider.fetchStories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Lottie.asset("assets/lottie/dog_loading.json",
                              height: 50);
                        }
                        return ListView.builder(
                          itemCount: storyProvider.stories.keys.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => FutureBuilder(
                            future: userProvider.fetchUser(
                              storyProvider.stories.keys.toList()[index],
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return Lottie.asset(
                                  "assets/lottie/loading.json",
                                  height: 16,
                                );
                              }
                              return StoryWidget(
                                stories: storyProvider.stories[storyProvider
                                    .stories.keys
                                    .elementAt(index)]!,
                                imageUrl: snapshot.data?.profilePhoto ??
                                    "https://i.pinimg.com/564x/a6/2b/73/a62b73acb6b9859e1d0d1245287b0f65.jpg",
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Posts
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: PostWidget(),
                ),
                childCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
