import 'package:squiba/barrel/barrel.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController firstnameController = TextEditingController();
    final TextEditingController lastnameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Consumer<UserProvider>(
      builder: (context, provider, child) => Scaffold(
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      label: const Text("Username"),
                      suffixIcon: const Icon(Ionicons.at),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(containerRadius),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: firstnameController,
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
                        controller: lastnameController,
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
                    controller: phoneController,
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
                    controller: emailController,
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
                    controller: passwordController,
                    obscureText: provider.showPassword,
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          provider.toggleShowPassword();
                        },
                        icon: Icon(
                          provider.showPassword
                              ? Ionicons.eye_off
                              : Ionicons.eye,
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
                    controller: confirmPasswordController,
                    obscureText: provider.showConfirmPassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          provider.toggleShowConfirmPassword();
                        },
                        icon: Icon(
                          provider.showConfirmPassword
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
                provider.signUpLoading
                    ? Lottie.asset(
                        "assets/lottie/loading.json",
                        height: 40,
                      )
                    : FilledButton.icon(
                        onPressed: () async {
                          provider.toggleSignUpLoading();
                          if (firstnameController.text.isEmpty ||
                              lastnameController.text.isEmpty ||
                              phoneController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              confirmPasswordController.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Please fill the form to continue",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor:
                                  MaterialTheme.lightScheme().error,
                            );
                            provider.toggleSignUpLoading();
                            return;
                          }
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            var isOk = await provider.signUp(
                              usernameController.text,
                              firstnameController.text,
                              lastnameController.text,
                              phoneController.text,
                              emailController.text,
                              passwordController.text,
                            );
                            isOk
                                ? routeFromAllAndTo(
                                    context,
                                    const LayoutScreen(),
                                  )
                                : debugPrint("Wrong creds..");
                          } else {
                            Fluttertoast.showToast(
                              msg: "Passwords dont match!",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor:
                                  MaterialTheme.lightScheme().error,
                            );
                          }
                          provider.toggleSignUpLoading();
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
