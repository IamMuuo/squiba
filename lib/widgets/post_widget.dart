import 'package:squiba/barrel/barrel.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 35,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://i.pinimg.com/736x/00/fe/19/00fe191b0c4dde7d29d81c67bee0f0cb.jpg",
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Erick",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "IamMuuo",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Ionicons.ellipsis_vertical_outline),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                fit: BoxFit.fill,
                child: CachedNetworkImage(
                  height: 250,
                  imageUrl:
                      "https://i.pinimg.com/564x/be/1e/09/be1e09b31eef3bfb18fef17f25cab2d8.jpg",
                ),
              ),
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.heart_outline),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.paper_plane_outline),
                ),
                const Spacer()
              ],
            )
          ],
        ),
      ),
    );
  }
}