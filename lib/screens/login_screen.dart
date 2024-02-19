import 'package:squiba/barrel/barrel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_circle_outline),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Welcome back! Glad to see you",
                style: GoogleFonts.ptSerif(
                  textStyle: Theme.of(context).textTheme.displayMedium,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Lottie.asset("assets/lottie/happy.json",
                      fit: BoxFit.cover),
                ),
              ),

              const SizedBox(
                height: 16,
              ),
              // Textfields
              TextField(
                decoration: InputDecoration(
                  label: const Text("Email"),
                  suffixIcon: const Icon(Ionicons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(containerRadius),
                  ),
                ),
              ),
              // Textfields
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Password"),
                  suffixIcon: const Icon(Ionicons.eye),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(containerRadius),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: TextButton(
                      onPressed: () {}, child: const Text("Forgot Password?")),
                ),
              ),

              FilledButton.icon(
                icon: const Icon(Ionicons.lock_open),
                onPressed: () {},
                label: const Text("Login"),
              ),

              const SizedBox(height: 50),
              IntrinsicWidth(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Or Login With",
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.bold,
                        textStyle: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Ionicons.logo_google),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Ionicons.logo_facebook),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Ionicons.logo_snapchat),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Register for account?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
