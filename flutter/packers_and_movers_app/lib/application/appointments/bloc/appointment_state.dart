part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentsLoadedState extends AppointmentState {
  final List<Appointment> appointments;
  const AppointmentsLoadedState(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class AppointmentsLoadFailed extends AppointmentState {
  final Object error;
  const AppointmentsLoadFailed(this.error);
}

class AppointmentsLoadingState extends AppointmentState {
  const AppointmentsLoadingState();
}

class AppointmentSubmitted extends AppointmentState{}
class AppointmentSubmitFailed extends AppointmentState{}

