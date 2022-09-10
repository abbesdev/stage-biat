import 'dart:io';

class Demande {
  final String typeDemande;
  final String status;

  Demande({
    required this.typeDemande,
    required this.status,
  });

  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(typeDemande: json['typeDemande'], status: json['status']);
  }
}
