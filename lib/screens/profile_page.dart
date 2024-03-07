import 'package:squiba/barrel/barrel.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("@${userProvider.user.firstName}"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Ionicons.share))
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 12, right: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: userProvider.user.profilePhoto ??
                            "https://i.pinimg.com/564x/21/e1/27/21e127d26c2dcb4e94607b1feb361bea.jpg",
                      ),
                    ),
                  ),
                  const ProfileStat(
                    stat: "15k",
                    label: "followers",
                  ),
                  const ProfileStat(
                    stat: "0",
                    label: "following",
                  ),
                  const ProfileStat(
                    stat: "1",
                    label: "Posts",
                  ),
                ],
              ),
              FilledButton(
                  onPressed: () {}, child: const Text("Share Profile")),
              const SizedBox(
                height: 20,
              ),
              Text(
                "My posts",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              GridView.builder(
                itemCount: 12,
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                  child: CachedNetworkImage(
                      imageUrl:
                          "https://i.pinimg.com/736x/f8/7c/06/f87c0685cbc71885be6bdb18d8248510.jpg"),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // number of items in each row
                  mainAxisSpacing: 8.0, // spacing between rows
                  crossAxisSpacing: 8.0, // spacing between columns
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
