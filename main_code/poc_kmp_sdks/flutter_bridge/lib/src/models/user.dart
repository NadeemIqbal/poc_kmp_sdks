/// Dart representation of the User data class from the shared SDK
class User {
  final String id;
  final String name;
  final String email;

  const User({required this.id, required this.name, required this.email});

  /// Creates a User from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  /// Converts the User to a JSON map
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }

  /// Creates a copy of this User with optional parameter overrides
  User copyWith({String? id, String? name, String? email}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode => Object.hash(id, name, email);

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email)';
  }
}
