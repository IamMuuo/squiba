import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:squiba/barrel/barrel.dart';
import 'package:crop_image/crop_image.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

enum _GalleryScreens { camera, gallery }

class _GalleryScreenState extends State<GalleryScreen> {
  var _currentScreen = _GalleryScreens.camera;
  final TextEditingController _postTextController = TextEditingController();
  XFile? _postImage;
  Uint8List? _imageBytes;
  bool _done = false;

  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );

  _loadImage() async {
    if (Platform.isAndroid || Platform.isIOS) {
      _postImage = _currentScreen == _GalleryScreens.gallery
          ? await ImagePicker().pickImage(
              source: ImageSource.gallery,
            )
          : await ImagePicker().pickImage(
              source: ImageSource.camera,
            );
      _imageBytes = await _postImage?.readAsBytes();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Add a post"),
        actions: _postImage == null
            ? null
            : [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _imageBytes = null;
                        _postImage = null;
                      });
                    },
                    icon: const Icon(Ionicons.trash)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _done = true;
                      });
                    },
                    icon: const Icon(Ionicons.checkmark_outline)),
              ],
      ),
      body: _postImage == null
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Ionicons.camera,
                    size: 120,
                  ),
                  Text("Please take a photo or pick from gallery to continue")
                ],
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !_done
                          ? CropImage(
                              controller: controller,
                              image: Image.memory(
                                _imageBytes!,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.scaleDown,
                              ),
                            )
                          : FutureBuilder(
                              future: controller.croppedImage(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return const Text("Cropping");
                                }
                                return snapshot.data!;
                              },
                            ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        controller: _postTextController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            hintText: "Write something to your post",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      )
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: _postImage == null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    setState(() {
                      _currentScreen = _GalleryScreens.camera;
                    });
                    await _loadImage();
                  },
                  child: const Icon(Ionicons.camera),
                ),
                const SizedBox(
                  width: 2,
                ),
                FloatingActionButton(
                  onPressed: () async {
                    setState(() {
                      _currentScreen = _GalleryScreens.gallery;
                    });
                    await _loadImage();
                  },
                  child: const Icon(Ionicons.images_outline),
                )
              ],
            )
          : null,
    );
  }
}
