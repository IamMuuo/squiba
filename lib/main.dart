import 'package:squiba/barrel/barrel.dart';

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
        fontFamily: GoogleFonts.workSans().fontFamily,
      ),
      darkTheme: ThemeData(
        fontFamily: GoogleFonts.workSans().fontFamily,
        useMaterial3: true,
        colorScheme: MaterialTheme.darkScheme().toColorScheme(),
      ),
      home: const Material(
        child: WelcomeScreen(),
      ),
    );
  }
}
