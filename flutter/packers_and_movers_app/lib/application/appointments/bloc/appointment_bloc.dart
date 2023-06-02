import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:packers_and_movers_app/domain/models/appointment_model.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/appointments/appointment_remote.dart';
import 'package:packers_and_movers_app/infrastructure/repository/appointments/appointments_repository.dart';

import '../../../domain/models/appointment.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository appointmentRepository =
      AppointmentRepository(RemoteAppointmentDataProvider());
  AppointmentBloc() : super(const AppointmentsLoadingState()) {
    on<AppointmentsLoading>((event, emit) async {
      try {
        List<Appointment> appointments =
            await appointmentRepository.getUserAppointments();
        print("fetched appointments: $appointments");
        emit(AppointmentsLoadedState(appointments));
      } catch (e) {
        emit(const AppointmentsLoadFailed("error"));
      }
    });

    on<AppointmentsLoadedEvent>((event, emit) async {});

    on<AppointmentDelete>((event, emit) async {});

    on<MoverRejectAppointmentEvent>((event, emit) async {});

    on<UserPostAppointmentEvent>((event, emit) async {
      try {
        appointmentRepository.userPostAppointment(event.appointment);
        emit(AppointmentSubmitted());
      } catch (e) {
        emit(AppointmentSubmitFailed());
      }
    });
  }
}
