import 'package:squiba/barrel/barrel.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    Center(
      child: Text("Favourites"),
    ),
    Center(
      child: Text("Text"),
    ),
    Center(
      child: Text("Profile"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: pages,
          ),
          Align(
            alignment: const Alignment(0.0, 1.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 26),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Theme(
                  data: Theme.of(context).copyWith(canvasColor: Colors.black),
                  child: BottomNavigationBar(
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    currentIndex: _currentIndex,
                    unselectedItemColor: Colors.white54,
                    selectedItemColor: Colors.white,
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    showUnselectedLabels: false,
                    showSelectedLabels: false,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Ionicons.home_outline),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Ionicons.heart_outline),
                        label: "Favourites",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Ionicons.chatbox_ellipses_outline),
                        label: "Chat",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Ionicons.person_circle_outline),
                        label: "Favourites",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
