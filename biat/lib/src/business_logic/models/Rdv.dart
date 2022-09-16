import 'dart:io';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class Rdv {
  String id;
  String title;
  String description;
  String clientId;
  String chefId;
  String status;
  DateTime startDate;
  DateTime endDate;

  Rdv({
    required this.id,
    required this.title,
    required this.description,
    required this.clientId,
    required this.chefId,
    required this.status,
    required this.startDate,
    required this.endDate,
  });

  factory Rdv.fromJson(Map<String, dynamic> json) {
    return Rdv(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        clientId: json['clientId'],
        chefId: json['chefId'],
        status: json['status'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']));
  }
}
