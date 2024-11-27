class User {
  final int id;
  final String username;
  final String? password;

  User({
    required this.id,
    required this.username,
    this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      username: map['username'] as String,
    );
  }
}
