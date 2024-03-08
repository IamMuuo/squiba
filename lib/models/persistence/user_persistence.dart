import 'package:squiba/barrel/barrel.dart';

class UserPersistence {
  // Private constructor
  UserPersistence._privateConstructor();

  // Static instance of UserStorage
  static final UserPersistence _instance =
      UserPersistence._privateConstructor();

  // Factory constructor
  factory UserPersistence() {
    return _instance;
  }

  // Method to set the user
  Future<void> storeUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userMap = user.toJson();
    final userString = jsonEncode(userMap);
    await prefs.setString('user', userString);
  }

  // Method to get the user
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString != null) {
      final userMap = jsonDecode(userString) as Map<String, dynamic>;
      return User.fromJson(userMap);
    }
    return null;
  }

  // Clears everything from user persistence
  Future<bool> logout() async{
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
