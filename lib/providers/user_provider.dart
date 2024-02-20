import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/models/user.dart';

class UserProvider extends ChangeNotifier {
  late User currentUser;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  User get user => currentUser;
  bool get showPassword => _showPassword;
  bool get showConfirmPassword => _showConfirmPassword;

  bool login() {
    notifyListeners();
    return false;
  }

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  void toggleShowConfirmPassword() {
    _showConfirmPassword = !_showConfirmPassword;
    notifyListeners();
  }
}
