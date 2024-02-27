import 'package:squiba/barrel/barrel.dart';

class ReelsPage extends StatelessWidget {
  const ReelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _pageViewController = PageController(initialPage: 0);
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.red,
          ),
          Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.orange,
          ),
          Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.yellow,
          ),
          Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.green,
          ),
          Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.blue,
          ),
          Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.indigo,
          ),
          Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
