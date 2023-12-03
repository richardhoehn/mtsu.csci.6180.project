class UserStatus {
  int id;
  String name;

  UserStatus({required this.id, required this.name});

  factory UserStatus.fromJson(Map<String, dynamic> json) {
    return UserStatus(
      id: json['id'],
      name: json['name'],
    );
  }
}