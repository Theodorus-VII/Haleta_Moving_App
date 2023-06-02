import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:packers_and_movers_app/infrastructure/repository/appointments/appointments_repository.dart';

import '../../../domain/models/mover.dart';


part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final repository = AppointmentRepository();
  AppointmentBloc() : super(AppointmentScreen()) {
    on<AppointmentEvent>((event, emit) {});

    on<AppointmentDefaultEvent>((event, emit) {
      emit(AppointmentScreen());
    });

    on<AppointmentUserCreate>(
      (event, emit) async {
        // when user tries to make a new appointment
        var x = await repository.bookAppointment(event.bookdate, event.moverId);
        print("book appointment: $x");
        if (x) {
          emit(AppointmentCreateSuccess());
        } else {
          emit(AppointmentCreateFail());
        }
      },
    );

    on<AppointmentUserRead>(
      (event, emit) async {
        // read user appointments
        print("AppointmentUserRead");
        final appointments = await repository.fetchAppointments();
        final List<Map<String, dynamic>> processedItems = [];
        print(event.movers);
        Mover mover;
        for (var appointment in appointments) {
          mover = event.movers
              .firstWhere((mover) => (mover.Id == appointment.moverId));
          // print('MOVER NAME ${mover.firstName}');
          print("bookdate");
          print("${mover.firstName} ${mover.lastName}");
          print(appointment.bookDate);
          processedItems.add({
            "name": "${mover.firstName} ${mover.lastName}",
            "rating": 5,
            "phone": mover.phoneNumber,
            "status": appointment.status,
            "appointmentId": appointment.Id,
            "bookDate": appointment.bookDate
          });
        }
        print("order info state emitting");
        emit(AppointmentRead(processedItems));
      },
    );
    on<AppointmentMoverRead>(
      (event, emit) async {
        // read mover appointments
        final appointments = await repository.fetchAppointments();
        final List<Map<String, dynamic>> processedItems = [];
        for (var appointment in appointments) {
          print(appointment.bookDate);
          var user = await repository.fetchUserById(appointment.customerId);
          processedItems.add({
            ...appointment.toMap(),
            ...user.toMap(),
            "appointmentId": appointment.Id,
            "bookDate": appointment.bookDate
          });
        }
        print("Mover read $processedItems");
        emit(AppointmentRead(processedItems));
      },
    );

    on<AppointmentMoverUpdate>(
      (event, emit) async {
        // mover decline or accept
        if (await repository.moverAppointmentUpdate(
            event.appointmentId, event.statusUpdate)) {
          emit(AppointmentUpdateSuccess());
        } else {
          emit(AppointmentUpdateFail());
        }
      },
    );

    on<AppointmentUserDelete>(
      (event, emit) async {
        // user delete appointment
        print("APPOINTMENT DELTE");
        if (await repository.deleteAppointment(event.appointmentId)) {
          emit(AppointmentDeleteSuccess());
        } else {
          emit(AppointmentDeleteFail());
        }
      },
    );
  }
}
