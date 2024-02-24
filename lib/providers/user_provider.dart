import 'package:squiba/barrel/barrel.dart';

class UserProvider extends ChangeNotifier {
  late User currentUser;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _signupIsLoading = false;
  bool _loginLoading = false;

  User get user => currentUser;
  bool get showPassword => _showPassword;
  bool get showConfirmPassword => _showConfirmPassword;
  bool get signUpLoading => _signupIsLoading;
  bool get loginLoading => _loginLoading;

  Future<bool> login(String email, String password) async {
    return false;
  }

  Future<bool> signUp(String firstname, String lastname, String phone,
      String email, String password) async {
    _signupIsLoading = true;
    User _ = User(
      id: 0,
      email: email,
      lastName: lastname,
      firstName: firstname,
    );
    return false;
  }

  set signUpLoading(bool val) {
    _signupIsLoading = val;
    notifyListeners();
  }

  set loginLoading(bool val) {
    _loginLoading = val;
    notifyListeners();
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
