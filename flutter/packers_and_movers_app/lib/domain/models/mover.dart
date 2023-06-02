// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:packers_and_movers_app/domain/models/models.dart';

class Mover {
  Mover(
      {required this.Id,
      required this.firstName,
      required this.lastName,
      // required this.token,
      required this.email,
      required this.phoneNumber,
      required this.username,
      required this.licenceNumber,
      this.profilePic = 'http://10.0.2.2:3000/movers/images/profile/1000000',
      this.carPic = 'http://10.0.2.2:3000/movers/images/car/1000000',
      required this.Banned,
      required this.baseFee,
      required this.verified,
      required this.location,
      this.role = 'MOVER'});
  final int Id;
  final String username;
  final String role;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String licenceNumber;
   String? profilePic;
   String? carPic;
  final String location;
  final String baseFee;
  final bool Banned;
  final bool verified;
  // final String token;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'username': username,
      'role': role,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'baseFee': baseFee,
      'licenceNumber': licenceNumber,
      'location': location
    };
  }

  factory Mover.fromMap(Map<String, dynamic> map) {
    print("Mover initialization");
    print(map);
    print(map['Id']);
    print(map['username']);
    print(map['email']);
    print(map['firstName']);
    print(map['lastName']);
    print(map['phoneNumber']);
    print(map['profilePic']);
    print(map['licenceNumber']);
    print(map['carPic']);
    print(map['verified']);
    print(map['baseFee']);
    print(map['location']);
    print(map['location']);

    return Mover(
      Id: map['Id'],
      username: map['username'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
      licenceNumber: map['licenceNumber'],
      profilePic: map['profilePic'],
      carPic: map['carPic'],
      Banned: map['Banned'],
      verified: map['verified'],
      baseFee: map['baseFee'],
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Mover.fromJson(String source) =>
      Mover.fromMap(json.decode(source) as Map<String, dynamic>);
}
