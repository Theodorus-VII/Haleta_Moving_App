part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  @override
  List<Object> get props {
    return [];
  }
}

class AppointmentDefaultEvent extends AppointmentEvent{}

// CREATE - only customer can create
class AppointmentUserCreate extends AppointmentEvent {
  final String bookdate;
  final int moverId;
  AppointmentUserCreate(this.bookdate, this.moverId);
}
////////////////////////////////////////////////////////////////

// READ//////////////
class AppointmentUserRead extends AppointmentEvent {
  final List<Mover> movers;
  AppointmentUserRead(this.movers);
}

class AppointmentMoverRead extends AppointmentEvent {}
/////////////////////////////////////////////////////////////////

// Update - only mover can update(on declining/accepting request)
class AppointmentMoverUpdate extends AppointmentEvent {
  final int statusUpdate;
  final int appointmentId;
  AppointmentMoverUpdate(this.appointmentId, this.statusUpdate);
}
/////////////////////////////////////////////////////////////////

// DELETE - only user on declined request
class AppointmentUserDelete extends AppointmentEvent {
  final int appointmentId;
  AppointmentUserDelete(this.appointmentId);
}
/////////////////////////////////////////////////////////////////