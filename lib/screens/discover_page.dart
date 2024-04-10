import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/providers/posts_provider.dart';
import 'package:squiba/widgets/post_widget.dart';
import 'package:squiba/widgets/skeletons/story_widget_skeleton.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final postProvider = Provider.of<PostProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Ionicons.search),
            ),
          ],
          title: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: "Search for someone",
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Featured Users",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: userProvider.fetchFeaturedUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        const StoryWidgetSkeleton(),
                    itemCount: 5,
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                              imageUrl: snapshot.data![index].profilePhoto ??
                                  "https://i.pinimg.com/564x/20/05/e2/2005e27a39fa5f6d97b2e0a95233b2be.jpg"),
                        ),
                      ),
                      Text(snapshot.data![index].username)
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Featured Posts",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: true,
          child: FutureBuilder(
            future: postProvider.fetchFeaturedPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Column(
                  children: [
                    Lottie.asset(
                      "assets/lottie/loading.json",
                      height: 80,
                    ),
                    const Text("Fetching featured posts")
                  ],
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) =>
                    PostWidget(post: snapshot.data![index]),
              );
            },
          ),
        )
      ],
    );
  }
}
