import 'package:squiba/barrel/barrel.dart';

void routeFromAllAndTo(BuildContext ctx, Widget page) {
  Navigator.pushAndRemoveUntil(
    ctx,
    MaterialPageRoute(builder: (context) => page),
    (Route<dynamic> route) =>
        false, // This predicate always returns false, so all routes are removed.
  );
}
