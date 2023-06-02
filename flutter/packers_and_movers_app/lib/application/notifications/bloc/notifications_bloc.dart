import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/models.dart';
import '../../../infrastructure/repository/notifications/notification_repository.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationRepository notificationRepository = NotificationRepository();
  NotificationBloc() : super(NotificationDefaultState()) {
    on<NotificationEvent>((event, emit) {});

    on<NotificationPop>(((event, emit) {
      emit(NotificationDefaultState());
    }));

    on<NotificationsGet>(
      (event, emit) async {
        Map<String, dynamic> notifications = {};
        print("NOTIFICATIONS GET");
        for (var appointment in event.appointments) {
          print(appointment);
          // notifications.add(notificationRepository
          //     .getNotifications(appointment['appointmentId']));
          notifications['${appointment['appointmentId']}'] =
              await notificationRepository
                  .getNotifications(appointment['appointmentId']);
        }
        print(notifications);
        emit(NotificationsMainScreen(notifications));
      },
    );

    on<NotificationMoverScreenEvent>(
      (event, emit) async {
        print("event ${event.appointment}");
        final appointment = event.appointment;
        final notifications = await notificationRepository
            .getAllNotifications(event.appointment['appointmentId']);
        print(notifications);
        print("event builder check ${appointment}");
        emit(NotificationMoverScreen(appointment, notifications));
      },
    );

    on<NotificationsMoverCreate>(
      (event, emit) async {
        if (await notificationRepository.postNotification(event.notification)) {
          emit(NotificationUpdateSuccess());
        } else {
          emit(NotificationUpdateFail());
        }
      },
    );

    on<NotificationsMoverUpdate>(
      (event, emit) async {
        if (await notificationRepository
            .patchNotification(event.notification)) {
          emit(NotificationUpdateSuccess());
        } else {
          emit(NotificationUpdateFail());
        }
      },
    );

    on<NotificationsMoverDelete>(
      (event, emit) async {
        if (await notificationRepository.deleteNotification(
            event.stage, event.appointmentId)) {
          emit(NotificationDeleteSuccess());
        } else {
          emit(NotificationDeleteFail());
        }
      },
    );
  }
}
