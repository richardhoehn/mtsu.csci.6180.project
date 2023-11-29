class User {
  String email;
  String firstName;
  String id;
  String lastName;
  String password; // Be cautious with storing passwords
  int userStatusId;

  User({
    required this.email,
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.password,
    required this.userStatusId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['firstName'],
      id: json['id'],
      lastName: json['lastName'],
      password: json['password'],
      userStatusId: json['userStatusId'],
    );
  }
}