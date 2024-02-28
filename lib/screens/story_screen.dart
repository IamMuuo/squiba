import 'package:squiba/barrel/barrel.dart';
import 'package:story_view/story_view.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({
    super.key,
    required this.stories,
  });
  final List<Story> stories;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    final StoryController storyController = StoryController();

    List<StoryItem> storyItems = [];

    for (var story in widget.stories) {
      storyItems.add(story.content == null
          ? StoryItem.text(
              title: story.text,
              backgroundColor: Colors.teal,
            )
          : StoryItem.pageImage(
              url: story.content ??
                  "https://i.pinimg.com/564x/f5/4c/bb/f54cbb0625a385be7702e6429c9751e0.jpg",
              controller: storyController,
            ));
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: StoryView(
        storyItems: storyItems,
        controller: storyController,
      ),
    );
  }
}
