import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:squiba/barrel/barrel.dart';
import 'package:crop_image/crop_image.dart';
import 'package:squiba/providers/posts_provider.dart';

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
  bool isLoading = false;

  final controller = CropController(
    aspectRatio: 4.0 / 3.0,
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
    final _postProvider = Provider.of<PostProvider>(context);
    final _userProvider = Provider.of<UserProvider>(context);
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
                    onPressed: () async {
                      if (_imageBytes != null && _done) {
                        setState(() {
                          isLoading = true;
                        });
                        await _postProvider.addPost(_imageBytes!,
                            _postTextController.text, _userProvider.user.id!);

                        setState(() {
                          _imageBytes = null;
                          _postImage = null;
                          isLoading = true;
                        });
                      }
                    },
                    icon: const Icon(Ionicons.checkmark_outline)),
              ],
      ),
      body: _postImage == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Ionicons.camera,
                    size: 120,
                  ),
                  const Text(
                      "Please take a photo or pick from gallery to continue"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        tooltip: "Take a photo",
                        iconSize: 30,
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () async {
                          setState(() {
                            _currentScreen = _GalleryScreens.camera;
                          });
                          await _loadImage();
                        },
                        icon: const Icon(Ionicons.camera),
                      ),
                      IconButton(
                        tooltip: "Pick image",
                        // iconSize: 30,
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () async {
                          setState(() {
                            _currentScreen = _GalleryScreens.gallery;
                          });
                          await _loadImage();
                        },
                        icon: const Icon(Ionicons.images),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : !isLoading
              ? Center(
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
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
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
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                _done = true;
                              } else {
                                _done = false;
                              }
                            },
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
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/lottie/loading.json",
                      height: 80,
                    ),
                    const Text("Uploading your post")
                  ],
                ),
    );
  }
}
