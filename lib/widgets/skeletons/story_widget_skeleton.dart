import 'package:shimmer/shimmer.dart';
import 'package:squiba/barrel/barrel.dart';

class StoryWidgetSkeleton extends StatelessWidget {
  const StoryWidgetSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[500]!,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: CircleAvatar(
          radius: 40,
        ),
      ),
    );
  }
}
