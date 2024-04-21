import 'dart:math';

import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/providers/posts_provider.dart';
import 'package:squiba/widgets/profile_post_widget.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key, required this.userID});
  final int userID;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final postsProvider = Provider.of<PostProvider>(context);
    return FutureBuilder(
      future: userProvider.fetchUser(userID),
      builder: (context, snapshot) => Scaffold(
        appBar: snapshot.connectionState == ConnectionState.done
            ? AppBar(
                title: Text("@${snapshot.data!.firstName}"),
                centerTitle: true,
              )
            : null,
        body: snapshot.connectionState != ConnectionState.done
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Lottie.asset("assets/lottie/loading.json", height: 80),
                  const Text("Fetching user posts", textAlign: TextAlign.center)
                ],
              )
            : SafeArea(
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
                                imageUrl: snapshot.data?.profilePhoto ??
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
                                stat: postsProvider.currentUserPostCount
                                    .toString(),
                                label: "Posts",
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Text(
                        "${snapshot.data?.firstName ?? 'user'}'s posts",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      FutureBuilder(
                        future: postsProvider
                            .fetchCurrentUserPosts(snapshot.data!.id!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
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
                                crossAxisCount:
                                    3, // number of items in each row
                                mainAxisSpacing: 8.0, // spacing between rows
                                crossAxisSpacing:
                                    8.0, // spacing between columns
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
                                  "This user has no posts yet youll see them here once they post something",
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
      ),
    );
  }
}
