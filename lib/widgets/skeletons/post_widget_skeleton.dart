import 'package:shimmer/shimmer.dart';
import 'package:squiba/barrel/barrel.dart';

class PostWidgetSkeleton extends StatelessWidget {
  const PostWidgetSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[500]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 4,
        ),
        child: SizedBox(
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                  ),
                  const SizedBox(width: 6),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Theme.of(context).disabledColor,
                        height: 12,
                        width: 120,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        color: Theme.of(context).disabledColor,
                        height: 12,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 300,
                color: Theme.of(context).disabledColor,
              ),
              Container(
                height: 12,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).disabledColor,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                    ),
                    CircleAvatar(
                      radius: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
