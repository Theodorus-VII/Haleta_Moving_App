import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/appointments/appointment_remote.dart';

import '../../../domain/models/models.dart';
class AppointmentRepository {
  AppointmentRepository();
  RemoteProvider remoteProvider = RemoteProvider();

  Future<List<Appointment>> fetchAppointments() async {
    return await remoteProvider.fetchAppointments();
  }

  Future<User> fetchUserById(int userId) async {
    return await remoteProvider.fetchUserById(userId);
  }

  Future<bool> moverAppointmentUpdate(
      int appointmentId, int statusUpdate) async {
    return await remoteProvider.moverUpdateAppointment(
        appointmentId, statusUpdate);
  }

  Future<bool> deleteAppointment(int appointmentId) async {
    return await remoteProvider.deleteAppointment(appointmentId);
  }

  Future<bool> bookAppointment(bookDate, moverId) async{
    return await remoteProvider.bookAppointment(bookDate, moverId);
  }
}
