import 'package:squiba/barrel/barrel.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    final TextEditingController firstnameController = TextEditingController();
    final TextEditingController lastnameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage account"),
        elevation: 2,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: ClipRRect(
                child: CircleAvatar(
                  radius: 60,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "First Name",
                    suffixIcon: const Icon(Ionicons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Last Name",
                    suffixIcon: const Icon(Ionicons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Email",
                    suffixIcon: const Icon(Ionicons.mail),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: const Icon(Ionicons.key),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4))),
            ),
            const Spacer(),
            const Text("Account Control"),
            const Divider(),
            const ListTile(
              trailing: Icon(Ionicons.checkmark),
              title: Text("Update Details"),
            ),
            const Divider(),
            const ListTile(
              trailing: Icon(Ionicons.trash_outline),
              title: Text("Delete Account"),
              
            )
          ],
        ),
      ),
    );
  }
}
