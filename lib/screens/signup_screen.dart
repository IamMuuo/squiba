import 'package:squiba/barrel/barrel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: [
              Text(
                "Sign up to continue.Goodies Await!",
                style: GoogleFonts.ptSerif(
                  textStyle: Theme.of(context).textTheme.displayMedium,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Lottie.asset("assets/lottie/cat_dance.json",
                      fit: BoxFit.cover),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextField(
                      decoration: InputDecoration(
                        label: const Text("First Name"),
                        suffixIcon: const Icon(Ionicons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(containerRadius),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextField(
                      decoration: InputDecoration(
                        label: const Text("Last Name"),
                        suffixIcon: const Icon(Ionicons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(containerRadius),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextField(
                  decoration: InputDecoration(
                    label: const Text("Phone"),
                    suffixIcon: const Icon(Ionicons.call),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(containerRadius),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextField(
                  decoration: InputDecoration(
                    label: const Text("Email"),
                    suffixIcon: const Icon(Ionicons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(containerRadius),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextField(
                  decoration: InputDecoration(
                    label: const Text("Password"),
                    suffixIcon: const Icon(Ionicons.eye),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(containerRadius),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                child: TextField(
                  decoration: InputDecoration(
                    label: const Text("Confirm Password"),
                    suffixIcon: const Icon(Ionicons.eye),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(containerRadius),
                    ),
                  ),
                ),
              ),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Ionicons.person_add),
                label: const Text("Get started"),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const Text("Already have account?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
