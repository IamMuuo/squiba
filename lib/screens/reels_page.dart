import 'package:squiba/barrel/barrel.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

final x = [
  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
];

class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key});

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Platform.isAndroid
          ? PageView.builder(
              itemBuilder: (context, index) => Container(
                child: _buildVideoPlayer(
                  x[index],
                ),
              ),
            )
          : const Center(
              child: Text("Not Supported on desktop"),
            ),
    );
  }

  Widget _buildVideoPlayer(String url) {
    final VideoPlayerController controller =
        VideoPlayerController.networkUrl(Uri.parse(url))
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized.
            setState(() {});
          });

    return SizedBox(
      height: MediaQuery.of(context).size.width,
      child: VideoPlayer(controller),
    );
  }
}
