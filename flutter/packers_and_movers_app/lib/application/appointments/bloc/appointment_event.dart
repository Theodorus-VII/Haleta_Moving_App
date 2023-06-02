part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class AppointmentsLoading extends AppointmentEvent {
  const AppointmentsLoading();
}

class AppointmentsLoadedEvent extends AppointmentEvent {
  final List<Appointment> appointments;
  const AppointmentsLoadedEvent(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class UserPostAppointmentEvent extends AppointmentEvent {
  // final AppointmentDto appointment;
  final Map<String, dynamic> appointment;
  const UserPostAppointmentEvent(this.appointment);
}

class AppointmentDelete extends AppointmentEvent {
  final int appointmentId;
  const AppointmentDelete(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

class MoverRejectAppointmentEvent extends AppointmentEvent {
  final int appointmentId;
  const MoverRejectAppointmentEvent(this.appointmentId);
}


class getUserAppointments extends AppointmentEvent{
}