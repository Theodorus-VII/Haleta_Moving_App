// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Notification {
  final int Id;
  final String? update;
  final int appointmentId;
  final int stage;

  const Notification(this.Id, this.appointmentId, this.stage, {this.update});

  Map<String, dynamic> toMap() {
    // for update
    return <String, dynamic>{
      'update': update,
      'appointmentId': appointmentId,
      'stage': stage,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      map['Id'] as int,
      map['appointmentId'] as int,
      map['stage'] as int,
      update: map['update']
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) => Notification.fromMap(json.decode(source) as Map<String, dynamic>);
}
