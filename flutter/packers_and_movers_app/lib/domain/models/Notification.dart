// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Notification_ extends Equatable {
  final int Id;
  final String update;
  final int appointmentId;
  final String timestamp;
  final int stage;
  Notification_({
    required this.Id,
    required this.update,
    required this.appointmentId,
    required this.timestamp,
    required this.stage,
  });

  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'update': update,
      'appointmentId': appointmentId,
      'stage': stage,
    };
  }

  factory Notification_.fromMap(Map<String, dynamic> map) {
    print("Notification initialization");
    return Notification_(
      Id: map['Id'] as int,
      update: map['update'] as String,
      appointmentId: map['appointmentId'] as int,
      timestamp: map['timestamp'] as String,
      stage: (map['stage'] + 1),
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification_.fromJson(String source) =>
      Notification_.fromMap(json.decode(source) as Map<String, dynamic>);
}
