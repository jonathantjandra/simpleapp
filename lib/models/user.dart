class User {
  int id;
  String username;
  String email;
  String password;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'User{username: $username, email: $email, password: $password}';
  }

}