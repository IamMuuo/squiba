import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/widgets/post_widget.dart';
import 'package:squiba/widgets/story_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 0, right: 0, left: 0, top: 12),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
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
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => const StoryWidget(
                    imageUrl:
                        "https://i.pinimg.com/564x/a6/2b/73/a62b73acb6b9859e1d0d1245287b0f65.jpg",
                  ),
                ),
              ),
            ),

            // Posts
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const PostWidget(),
                childCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
