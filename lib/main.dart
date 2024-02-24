import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/screens/layout_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const Squiba(),
    ),
  );
}

class Squiba extends StatelessWidget {
  const Squiba({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: MaterialTheme.lightScheme().toColorScheme(),
        fontFamily: GoogleFonts.merriweather().fontFamily,
      ),
      darkTheme: ThemeData(
        fontFamily: GoogleFonts.merriweather().fontFamily,
        useMaterial3: true,
        colorScheme: MaterialTheme.darkScheme().toColorScheme(),
      ),
      home: const Material(
        child: LayoutScreen(),
      ),
    );
  }
}
