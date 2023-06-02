// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Appointment {
  final int Id;
  final int customerId;
  final int moverId;
  final String startLocation;
  final String destination;
  final DateTime setDate;

  Appointment({
    required this.Id,
    required this.customerId,
    required this.moverId,
    required this.startLocation,
    required this.destination,
    required this.setDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'moverId': moverId,
      'setDate': setDate.millisecondsSinceEpoch,
      'startLocation': startLocation,
      'destination': destination,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    print('here');
    return Appointment(
      Id: map['Id'],
      customerId: map['customerId'],
      moverId: map['moverId'],
      startLocation: map['startLocation'],
      destination: map['destination'],
      setDate: DateTime.parse(map['setDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source) as Map<String, dynamic>);
}


