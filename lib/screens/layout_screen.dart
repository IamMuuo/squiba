import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/screens/gallery_page.dart';
import 'package:squiba/screens/reels_page.dart';

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
      child: Text("Discover"),
    ),
    GalleryScreen(),
    ReelsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
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
            icon: Icon(Ionicons.search_outline),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.duplicate_outline),
            label: "Create",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.videocam_outline),
            label: "Reels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_circle_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
