import 'package:squiba/barrel/barrel.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstnameController = TextEditingController();
    TextEditingController lastnameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Consumer<UserProvider>(
      builder: (context, value, child) => Scaffold(
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
                            borderRadius:
                                BorderRadius.circular(containerRadius),
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
                            borderRadius:
                                BorderRadius.circular(containerRadius),
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
                    obscureText: value.showPassword,
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          value.toggleShowPassword();
                        },
                        icon: Icon(
                          value.showPassword ? Ionicons.eye_off : Ionicons.eye,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(containerRadius),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 24),
                  child: TextField(
                    obscureText: value.showConfirmPassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          value.toggleShowConfirmPassword();
                        },
                        icon: Icon(
                          value.showConfirmPassword
                              ? Ionicons.eye_off
                              : Ionicons.eye,
                        ),
                      ),
                      label: const Text("Confirm Password"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(containerRadius),
                      ),
                    ),
                  ),
                ),
                value.signUpLoading
                    ? Lottie.asset(
                        "assets/lottie/loading.json",
                        height: 40,
                      )
                    : FilledButton.icon(
                        onPressed: () async {
                          value.signUpLoading = true;
                          // await Future.delayed(Duration(seconds: 12));
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            await value.signUp(
                              firstnameController.text,
                              lastnameController.text,
                              phoneController.text,
                              emailController.text,
                              passwordController.text,
                            );
                          }
                          value.signUpLoading = false;
                        },
                        icon: const Icon(Ionicons.person_add),
                        label: const Text("Get started"),
                      ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  },
                  child: const Text("Already have account?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
