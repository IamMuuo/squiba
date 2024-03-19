class User {
  final String username;
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  String? mobilePhoneNumber;
  String? profilePhoto;
  final bool isStaff;
  final bool isActive;
  String? dateJoined;
  String? lastLogin;
  String? password;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    this.mobilePhoneNumber,
    this.profilePhoto,
    this.isStaff = false,
    this.isActive = true,
    this.dateJoined,
    this.lastLogin,
    this.password,
  });

  // Factory constructor to create a User instance from a Map (used for JSON decoding)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobilePhoneNumber: json['mobile_phone_number'],
      profilePhoto: json['profile_photo'],
      isStaff: json['is_staff'],
      isActive: json['is_active'],
      dateJoined: json['date_joined'],
      lastLogin: json['last_login'],
      password: json['password'],
    );
  }

  // Method to convert a User instance to a Map (used for JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile_phone_number': mobilePhoneNumber,
      'profile_photo': profilePhoto,
      'is_staff': isStaff,
      'is_active': isActive,
      'date_joined': dateJoined ?? DateTime.now().toIso8601String(),
      'last_login': lastLogin,
      'password': password,
    };
  }
}
