import 'package:squiba/barrel/barrel.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

final x = [
  "https://video.blender.org/download/videos/ac71efff-5e26-440b-8c38-dd1f5b598e02-1080.mp4",
  "https://video.blender.org/download/videos/ee623d80-fd8d-4a2a-8aae-1f5acf796f27-1080.mp4",
  "https://video.blender.org/download/videos/23f3ef79-15dc-44c5-aa45-cf92e78a4509-1080.mp4",
  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
];

class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key});

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  late VideoPlayerController _videoPlayerController;
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS || Platform.isAndroid) {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(x[0]))
        ..initialize().then(
          (value) => setState(
            () {
              _isPlaying = false;
              _videoPlayerController.pause();
            },
          ),
        );
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Platform.isAndroid || Platform.isIOS
          ? Focus(
              onFocusChange: (value) {
                if (!value) {
                  _videoPlayerController.pause();
                }
              },
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: x.length,
                onPageChanged: (value) {
                  _videoPlayerController.pause();
                  _videoPlayerController =
                      VideoPlayerController.networkUrl(Uri.parse(x[value]))
                        ..initialize().then(
                          (value) => setState(
                            () {
                              _videoPlayerController.play();
                            },
                          ),
                        );
                },
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    if (_isPlaying) {
                      _videoPlayerController.pause();
                      _isPlaying = false;
                    } else {
                      _videoPlayerController.play();
                      _isPlaying = true;
                    }
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: SizedBox(
                          height: 200,
                          child: Column(children: [
                            IconButton(
                              icon: const Icon(
                                Ionicons.heart,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {});
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Ionicons.musical_note,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {});
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Ionicons.logo_tux,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(
                                  () {},
                                );
                              },
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              child: Text(
                "Not Supported on desktop",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
