// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserDto extends Equatable {
  const UserDto({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
    required this.phoneNumber,
    required this.username,
    this.role = 'USER',
  });
  final String username;
  final String role;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String phoneNumber;

  @override
  List<Object> get props => [email];

  // static const empty = User(id: 0);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'email': email,
      'phoneNumber': phoneNumber,
      'username': username,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    // print(map);
    return UserDto(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      username: map['username'],
      role: 'USER',
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      username: json['username'],
      role: json['role'],
    );
  }

  factory UserDto.UpdatefromJson(Map<String, dynamic> json) {
    return UserDto(
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'] ,
      email: '',
      phoneNumber: json['phoneNumber'],
      username: json['username'],
      role: 'USER',
    );
  }
}
