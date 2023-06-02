// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.Id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.username,
      this.role = 'USER',
      this.token});
  final int Id;
  final String username;
  final String role;
  final String email;
  final String firstName;
  final String lastName;
  // final String token;
  final String phoneNumber;
  final String? token;

  @override
  List<Object> get props => [Id, email];

  // static const empty = User(id: 0);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': Id,
      'firstName': firstName,
      'lastName': lastName,
      'token': token,
      'email': email,
      'phoneNumber': phoneNumber,
      'username': username,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    // print(map['Id']);
    // print(map['firstName']);
    // print(map['lastName']);
    // print(map['email']);
    // print(map['phoneNumber']);
    // print(map['username']);

    return User(
      Id: map['Id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      username: map['username'],
      role: (map['role'] == null) ? "USER" : map['role'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      Id: json['Id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      // token: json['token'] ,
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      username: json['username'],
      role: json['role'],
    );
  }
}
