import 'package:app/services/user_status.dart';

class User {
  String email;
  String firstName;
  String id;
  String lastName;
  String password; // Be cautious with storing passwords
  UserStatus userStatus;

  User({
    required this.email,
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.password,
    required this.userStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
      userStatus: UserStatus.fromJson(json['userStatus']),
    );
  }
}