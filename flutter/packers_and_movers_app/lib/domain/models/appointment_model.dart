// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppointmentDto {
  final int customerId;
  final int moverId;
  final String startLocation = 'nowhere';
  final String destination = "nowhere";
  final DateTime setDate;

  AppointmentDto({
    required this.customerId,
    required this.moverId,
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

  factory AppointmentDto.fromMap(Map<String, dynamic> map) {
    return AppointmentDto(
      customerId: map['customerId'],
      moverId: map['moverId'],
      setDate: DateTime.parse(map['setDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentDto.fromJson(String source) =>
      AppointmentDto.fromMap(json.decode(source) as Map<String, dynamic>);
}


