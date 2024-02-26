import 'package:squiba/barrel/barrel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final status = await isLoggedIn();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
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
    final userProvider = Provider.of<UserProvider>(context);
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
        child: isLoggedIn
            ? FutureBuilder(
                future: userProvider.loadUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(
                      child: Lottie.asset("assets/lottie/loading.json"),
                    );
                  }
                  return const LayoutScreen();
                })
            : const WelcomeScreen(),
      ),
    );
  }
}
