class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String username;
  final String password;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      username: map['username'],
      password: map['password'],
    );
  }
}