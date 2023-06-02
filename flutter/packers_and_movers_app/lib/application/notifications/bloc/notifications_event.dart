part of 'notifications_bloc.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class NotificationPop extends NotificationEvent{}

class NotificationsMain extends NotificationEvent {}

class NotificationsGet extends NotificationEvent {
  final appointments;
  NotificationsGet(this.appointments);
}

class NotificationMoverScreenEvent extends NotificationEvent {
  final appointment;
  NotificationMoverScreenEvent(this.appointment);
}

class NotificationsMoverCreate extends NotificationEvent {
  final Notification_ notification;
  NotificationsMoverCreate(this.notification);
}

class NotificationsMoverUpdate extends NotificationEvent {
  final Notification_ notification;
  NotificationsMoverUpdate(this.notification);
}

class NotificationsMoverDelete extends NotificationEvent {
  final int stage;
  final int appointmentId;
  NotificationsMoverDelete(this.stage, this.appointmentId);
}
