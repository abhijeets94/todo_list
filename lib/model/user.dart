import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String name;
  final String email;
  final String password;
  final String token;
  String? userType;
  User({
    required this.name,
    required this.email,
    required this.password,
    required this.token,
    this.userType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'token': token,
      'userType': userType,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      token: map['token'] as String,
      userType: map['userType'] != null ? map['userType'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
