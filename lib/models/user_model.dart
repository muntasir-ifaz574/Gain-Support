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

  String get fullName => '$firstName $lastName';
}
