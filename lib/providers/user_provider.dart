import 'package:squiba/barrel/barrel.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  late User _currentUser;
  bool _showPassword = true;
  bool _isLoggedIn = false;
  bool _showConfirmPassword = true;
  bool _signupIsLoading = false;
  bool _loginLoading = false;

  User get user => _currentUser;
  bool get showPassword => _showPassword;
  bool get showConfirmPassword => _showConfirmPassword;
  bool get signUpLoading => _signupIsLoading;
  bool get loginLoading => _loginLoading;

  Future<void> loadUser() async {
    final user = await UserPersistence().getUser();
    if (user != null) {
      _currentUser = user;
      debugPrint("loadUser done!");
      // notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    final result = await _userService.login(email, password);
    return result.fold((l) {
      Fluttertoast.showToast(msg: l.toString());
      return false;
    }, (r) {
      _currentUser = r;
      UserPersistence().storeUser(r);
      _isLoggedIn = true;
      notifyListeners();
      return true;
    });
  }

  Future<User?> fetchUser(int id) async {
    final result = await _userService.find(id);

    return result.fold((l) {
      Fluttertoast.showToast(msg: l.toString());
      return null;
    }, (r) {
      return r;
    });
  }

  Future<bool> signUp(String firstname, String lastname, String phone,
      String email, String password) async {
    User u = User(
      id: 0,
      email: email,
      lastName: lastname,
      firstName: firstname,
      password: password,
      mobilePhoneNumber: phone,
    );

    final result = await _userService.register(u.toJson());
    return result.fold((l) {
      Fluttertoast.showToast(
        msg: l.toString(),
      );
      return false;
    }, (r) {
      _currentUser = r;
      _isLoggedIn = true;
      UserPersistence().storeUser(r);
      return true;
    });
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

  void toggleSignUpLoading() {
    _signupIsLoading = !_signupIsLoading;
    notifyListeners();
  }

  void toggleSignInLoading() {
    _loginLoading = !_loginLoading;
    notifyListeners();
  }

  bool get isLoggedIn {
    return _isLoggedIn;
  }
}
