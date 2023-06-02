// ignore_for_file: non_constant_identifier_names

part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  @override
  List<Object> get props {
    return [];
  }
}

class AppointmentScreen extends AppointmentState{}

// Create
class AppointmentCreateSuccess extends AppointmentState {}

class AppointmentCreateFail extends AppointmentState {}

// READ
class AppointmentRead extends AppointmentState {
  final List<dynamic> appointments;
  AppointmentRead(this.appointments);
}

// UPDATE
class AppointmentUpdateSuccess extends AppointmentState {}

class AppointmentUpdateFail extends AppointmentState {}

// DELETE
class AppointmentDeleteSuccess extends AppointmentState {}

class AppointmentDeleteFail extends AppointmentState {}
