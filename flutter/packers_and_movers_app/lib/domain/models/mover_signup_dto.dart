// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:packers_and_movers_app/domain/models/models.dart';

class MoverSignUpDto {
  const MoverSignUpDto(
      {this.Id = 0,
      required this.firstName,
      required this.lastName,
      // required this.token,
      required this.email,
      required this.phoneNumber,
      required this.username,
      required this.password,
      required this.licenceNumber,
      this.profilePic,
      this.carPic,
      this.idPic,
      this.Banned = false,
      required this.baseFee,
      this.verified = true,
      required this.location,
      this.role = 'MOVER'});
  final int Id;
  final String username;
  final String password;
  final String role;
  final String email;
  final String firstName;
  final String lastName;
  final String location;
  final String phoneNumber;
  final String licenceNumber;
  final XFile? profilePic;
  final File? carPic;
  final XFile? idPic;
  final String baseFee;
  final bool Banned;
  final bool verified;
  // final String token;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'password': password,
      'role': role,
      'baseFee': baseFee,
      'licenceNumber': licenceNumber,
      'location': location,
    };
  }

  factory MoverSignUpDto.fromMap(Map<String, dynamic> map) {
    map['role'] = 'MOVER';

    // print(map['username']);
    // print(map['password']);
    // print(map['role']);
    // print(map['email']);
    // print(map['firstName']);
    // print(map['lastName']);
    // print(map['location']);
    // print(map['phoneNumber']);
    // print(map['licenceNumber']);
    // print(map['profilePic']);
    // print(map['carPic']);
    // print(map['idPic']);
    // print(map['baseFee']);
    return MoverSignUpDto(
      username: map['username'],
      password: map['password'],
      role: map['role'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      location: map['location'],
      phoneNumber: map['phoneNumber'],
      licenceNumber: map['licenceNumber'],
      profilePic: map['profilePic'],
      carPic: map['carPic'],
      idPic: map['idPic'],
      baseFee: map['baseFee'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MoverSignUpDto.fromJson(String source) =>
      MoverSignUpDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
