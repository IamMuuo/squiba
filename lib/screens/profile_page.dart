import 'dart:math';

import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/providers/posts_provider.dart';
import 'package:squiba/screens/edit_profile_screen.dart';
import 'package:squiba/widgets/profile_post_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final postsProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("@${userProvider.user.firstName}"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          "Confirmation",
                        ),
                        content: const Text("Are you sure you want to leave? "),
                        actions: [
                          FilledButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("No"),
                          ),
                          FilledButton.tonal(
                            onPressed: () async {
                              final logout = await userProvider.logout();
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
              icon: const Icon(Ionicons.share))
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 12, right: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      // borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 200,
                        imageUrl: userProvider.user.profilePhoto ??
                            "https://i.pinimg.com/564x/20/05/e2/2005e27a39fa5f6d97b2e0a95233b2be.jpg",
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileStat(
                        stat: Random().nextInt(200).toString(),
                        label: "Post Views",
                      ),
                      ProfileStat(
                        stat: Random().nextInt(1000).toString(),
                        label: "Profile Views",
                      ),
                      ProfileStat(
                        stat: postsProvider.currentUserPostCount.toString(),
                        label: "Posts",
                      ),
                    ],
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(),
                          ),
                        );
                      },
                      child: const Text("Edit Profile")),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Text(
                "My posts",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              FutureBuilder(
                future:
                    postsProvider.fetchCurrentUserPosts(userProvider.user.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Column(
                      children: [
                        Lottie.asset(
                          "assets/lottie/loading.json",
                          height: 80,
                        ),
                        const Text("Fetching your posts"),
                      ],
                    );
                  }
                  if (snapshot.data?.isNotEmpty ?? false) {
                    return GridView.builder(
                      itemCount: snapshot.data?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ProfilePostCard(
                        post: snapshot.data![index],
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // number of items in each row
                        mainAxisSpacing: 8.0, // spacing between rows
                        crossAxisSpacing: 8.0, // spacing between columns
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          "assets/lottie/cat_dance.json",
                          height: 120,
                        ),
                        const Text(
                          "Your posts will be listed here once uploaded",
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
