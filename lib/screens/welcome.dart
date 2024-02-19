import 'package:squiba/barrel/barrel.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(containerRadius),
                bottomRight: Radius.circular(containerRadius),
              ),
              child: Image.asset(
                "assets/images/cat.jpg",
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 40,
              width: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: Image.asset("assets/icons/pets.png"),
            ),
            const SizedBox(height: 30),
            Text.rich(
              TextSpan(
                text: "Welcome\n",
                style: GoogleFonts.merriweather(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                ),
                children: [
                  TextSpan(
                      text: "to ",
                      style: GoogleFonts.nunito(
                          textStyle: Theme.of(context).textTheme.displaySmall)),
                  const TextSpan(
                    text: "Squiba",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Ionicons.lock_open),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                  label: const Text("Login"),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text("Or"),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Ionicons.people_circle_outline),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SignUpScreen();
                    }));
                  },
                  label: const Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
