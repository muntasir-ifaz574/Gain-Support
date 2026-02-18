class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatarUrl;
  final String role;
  final String group;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatarUrl,
    required this.role,
    required this.group,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      role: json['role'],
      group: json['group'],
    );
  }

  String get fullName => '$firstName $lastName';
}
