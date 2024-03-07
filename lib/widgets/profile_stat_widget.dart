import 'package:squiba/barrel/barrel.dart';

class ProfileStat extends StatelessWidget {
  const ProfileStat({
    super.key,
    required this.stat,
    required this.label,
  });
  final String stat;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            stat,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(label),
        ],
      ),
    );
  }
}
