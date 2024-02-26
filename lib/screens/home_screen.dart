import 'package:cached_network_image/cached_network_image.dart';
import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/widgets/post_widget.dart';

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
                  itemBuilder: (context, index) => Padding(
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
                        radius: 30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://i.pinimg.com/564x/47/31/77/473177d48711cd0f8b1ff1c6d614b37a.jpg",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Posts
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => PostWidget(),
                childCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
