// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Appointment {
  final int Id;
  final int customerId;
  final int moverId;
  final double status;
  final String? bookDate;
  const Appointment(this.Id, this.customerId, this.moverId, this.status,
      {this.bookDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'customerId': customerId,
      'moverId': moverId,
      'status': status,
      'bookDate': bookDate
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      map['Id'] as int,
      map['customerId'] as int,
      map['moverId'] as int,
      map['status'] / 4.0 as double,
      bookDate: map['setDate'],
    );
  }
  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source) as Map<String, dynamic>);
}
