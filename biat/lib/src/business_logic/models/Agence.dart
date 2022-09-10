import 'dart:io';

class Agence {
  final String id;
  final String agence;

  Agence({
    required this.id,
    required this.agence,
  });

  factory Agence.fromJson(Map<String, dynamic> json) {
    return Agence(id: json['id'], agence: json['agence']);
  }
}
