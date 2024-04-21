import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:squiba/barrel/barrel.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool hasProfile = false;
  Uint8List profilePic = Uint8List(0);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    hasProfile = false;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final TextEditingController firstnameController =
        TextEditingController(text: userProvider.user.firstName);
    final TextEditingController lastnameController =
        TextEditingController(text: userProvider.user.lastName);
    final TextEditingController emailController = TextEditingController(
      text: userProvider.user.email,
    );
    final TextEditingController passwordController =
        TextEditingController(text: userProvider.user.password ?? "");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage account"),
        elevation: 2,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Profile picker"),
                            content: const Text("Pick an image from"),
                            actions: [
                              FilledButton.tonalIcon(
                                onPressed: () async {
                                  if (Platform.isIOS || Platform.isAndroid) {
                                    ImagePicker()
                                        .pickImage(source: ImageSource.camera)
                                        .then((value) {
                                      value?.readAsBytes().then((value) {
                                        profilePic = value;
                                      });
                                    });
                                  }
                                  setState(() {
                                    hasProfile =
                                        profilePic.isNotEmpty ? true : false;
                                  });
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Ionicons.camera),
                                label: const Text("Camera"),
                              ),
                              FilledButton.tonalIcon(
                                onPressed: () async {
                                  if (Platform.isIOS || Platform.isAndroid) {
                                    ImagePicker()
                                        .pickImage(source: ImageSource.gallery)
                                        .then((value) {
                                      value?.readAsBytes().then((value) {
                                        profilePic = value;
                                      });
                                    });
                                  }
                                  setState(() {
                                    hasProfile =
                                        profilePic.isNotEmpty ? true : false;
                                  });

                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Ionicons.images),
                                label: const Text("Gallery"),
                              ),
                            ],
                          );
                        });
                  },
                  child: CircleAvatar(
                    radius: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      // radius: 30,
                      child: hasProfile
                          ? CachedNetworkImage(
                              height: 300,
                              width: 300,
                              fit: BoxFit.fill,
                              imageUrl: userProvider.user.profilePhoto ??
                                  "https://i.pinimg.com/564x/20/05/e2/2005e27a39fa5f6d97b2e0a95233b2be.jpg",
                            )
                          : Image.memory(
                              height: 300,
                              width: 300,
                              profilePic,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: firstnameController,
                  decoration: InputDecoration(
                      hintText: "First Name",
                      suffixIcon: const Icon(Ionicons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: lastnameController,
                  decoration: InputDecoration(
                      hintText: "Last Name",
                      suffixIcon: const Icon(Ionicons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Email",
                      suffixIcon: const Icon(Ionicons.mail),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: const Icon(Ionicons.key),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
              const SizedBox(height: 16),
              const Text("Account Control"),
              const Divider(),
              ListTile(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await userProvider.updateUser(
                    profilePic,
                    User(
                        id: userProvider.user.id!,
                        firstName: firstnameController.text,
                        lastName: lastnameController.text,
                        email: emailController.text,
                        username: userProvider.user.username),
                  );
                  setState(() {
                    isLoading = false;
                  });
                },
                trailing: isLoading
                    ? Lottie.asset("assets/lottie/loading.json", height: 30)
                    : const Icon(Ionicons.checkmark),
                title: const Text("Update Details"),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            "Confirmation",
                          ),
                          content: const Text(
                            "Are you sure you want to delete your account? This action cannot be undone",
                          ),
                          actions: [
                            FilledButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("No"),
                            ),
                            FilledButton.tonal(
                              onPressed: () async {
                                final logout = await userProvider
                                    .deleteAccount(userProvider.user.id!);
                                if (logout) {
                                  routeFromAllAndTo(context, WelcomeScreen());
                                }
                              },
                              child: const Text("Leave"),
                            ),
                          ],
                        );
                      });
                },
                trailing: Icon(
                  Ionicons.trash_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  "Delete Account",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
