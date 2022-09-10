import 'dart:io';

class User {
  final String id;
  final String email;
  final String fullname;
  final String cin;
  final String user_type;
  final bool enabled;
  final String status;

  User(
      {required this.id,
      required this.cin,
      required this.email,
      required this.enabled,
      required this.fullname,
      required this.user_type,
      required this.status});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        cin: json['cin'],
        email: json['email'],
        enabled: json['enabled'],
        fullname: json['fullname'],
        user_type: json['userType'],
        status: json['status']);
  }
}
