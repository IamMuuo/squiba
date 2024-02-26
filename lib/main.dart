import 'package:squiba/barrel/barrel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final status = await isLoggedIn();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider()..loadUser(),
        ),
      ],
      child: Squiba(
        isLoggedIn: status,
      ),
    ),
  );
}

class Squiba extends StatelessWidget {
  const Squiba({
    super.key,
    required this.isLoggedIn,
  });
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: MaterialTheme.lightScheme().toColorScheme(),
        fontFamily: GoogleFonts.workSans().fontFamily,
      ),
      darkTheme: ThemeData(
        fontFamily: GoogleFonts.workSans().fontFamily,
        useMaterial3: true,
        colorScheme: MaterialTheme.darkScheme().toColorScheme(),
      ),
      home: Material(
        child: isLoggedIn ? const LayoutScreen() : const WelcomeScreen(),
      ),
    );
  }
}
