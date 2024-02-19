import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/screens/welcome.dart';

void main() {
  runApp(const Squiba());
}

class Squiba extends StatelessWidget {
  const Squiba({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: MaterialTheme.lightScheme().toColorScheme(),
        fontFamily: GoogleFonts.nunito().fontFamily,
      ),
      darkTheme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        useMaterial3: true,
        colorScheme: MaterialTheme.darkScheme().toColorScheme(),
      ),
      home: const Material(
        child: WelcomeScreen(),
      ),
    );
  }
}
