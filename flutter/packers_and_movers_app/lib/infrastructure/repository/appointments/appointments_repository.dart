import 'package:packers_and_movers_app/domain/models/appointment.dart';
import 'package:packers_and_movers_app/domain/models/appointment_model.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/local_data_source/local_data_provider.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/appointments/appointment_remote.dart';

class AppointmentRepository {
  final RemoteAppointmentDataProvider remoteAppointmentDataProvider;
  final LocalDataProvider localDataProvider = LocalDataProvider();
  AppointmentRepository(this.remoteAppointmentDataProvider);

  Future<List<Appointment>> getUserAppointments() async{
    return await this.remoteAppointmentDataProvider.getUserAppointments();
  }

  Future<Object> moverRejectAppointment(int appointmentId) async{
    return await this
        .remoteAppointmentDataProvider
        .moverRejectAppointment(appointmentId);
  }

  Future<Object> userPostAppointment(Map<String, dynamic> new_appointment) async{
    return await this
        .remoteAppointmentDataProvider
        .userPostAppointment(new_appointment);
  }

  Future<Object> moverGetAppointments(int moverId) async {
    return await this
        .remoteAppointmentDataProvider
        .getMoverAppointments(moverId);
  }
}