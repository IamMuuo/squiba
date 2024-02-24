import 'package:squiba/barrel/barrel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) => Scaffold(
        body: Center(
          child: Text("${value.user.firstname}"),
        ),
      ),
    );
  }
}
