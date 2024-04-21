import 'dart:typed_data';

import 'package:squiba/barrel/barrel.dart';

class StoryProvider extends ChangeNotifier {
  final StoryService storyService = StoryService();
  final Map<int, List<Story>> stories = Map<int, List<Story>>();
  Future<void> fetchStories() async {
    final response = await storyService.fetchAllStories();
    response.fold(
      (l) {
        Fluttertoast.showToast(
          msg: l.toString(),
        );
      },
      (r) {
        stories.clear(); // temporary fix
        for (var story in r) {
          stories.putIfAbsent(story.user, () => <Story>[]).add(story);
        }
      },
    );
  }

  Future<void> postStory(int id, Uint8List? s, {String? text}) async {
    debugPrint("Wacha");
    final status = await storyService.postStory(id, s, text: text);

    status.fold((l) {
      Fluttertoast.showToast(
        msg: l.toString(),
      );
    }, (r) {
      Fluttertoast.showToast(
        msg: "Successfully posted a story",
      );
    });
    notifyListeners();
  }
}
