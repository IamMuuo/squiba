import 'package:squiba/barrel/barrel.dart';

void routeFromAllAndTo(BuildContext ctx, Widget page) {
  Navigator.pushAndRemoveUntil(
    ctx,
    MaterialPageRoute(builder: (context) => page),
    (Route<dynamic> route) =>
        false, // This predicate always returns false, so all routes are removed.
  );
}

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final userString = prefs.getString('user');
  if (userString != null) {
    return true;
  }
  return false;
}
