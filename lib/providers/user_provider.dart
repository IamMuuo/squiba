import 'package:dartz/dartz.dart';
import 'package:squiba/barrel/barrel.dart';
import 'package:squiba/models/helper/UserHelper.dart';
import 'package:squiba/models/user.dart';

class UserProvider extends ChangeNotifier {
  late User currentUser;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _signupIsLoading = false;
  final UserHelper _userHelper = UserHelper();

  User get user => currentUser;
  bool get showPassword => _showPassword;
  bool get showConfirmPassword => _showConfirmPassword;
  bool get signUpLoading => _signupIsLoading;

  bool login() {
    notifyListeners();
    return false;
  }

  Future<bool> signUp(String firstname, String lastname, String phone,
      String email, String password) async {
    _signupIsLoading = true;
    User u = User()
      ..firstname = firstname
      ..lastname = lastname
      ..phoneno = phone
      ..password = password
      ..email = email;

    final res = await _userHelper.signUp(u);

    return res.fold((l) {
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: l.toString(),
        backgroundColor: Colors.red,
      );
      return false;
    }, (r) {
      currentUser = r;
      notifyListeners();
      return true;
    });
  }

  set signUpLoading(bool val) {
    _signupIsLoading = val;
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
