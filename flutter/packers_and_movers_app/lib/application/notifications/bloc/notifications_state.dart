part of 'notifications_bloc.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotificationDefaultState extends NotificationState {}

class NotificationsMainScreen extends NotificationState {
  final notifications;
  NotificationsMainScreen(this.notifications);
}

class NotificationMoverScreen extends NotificationState {
  final appointment;
  final List<dynamic> notifications;
  NotificationMoverScreen(this.appointment, this.notifications);
}

class NotificationUpdateSuccess extends NotificationState {}

class NotificationUpdateFail extends NotificationState {}

class NotificationDeleteSuccess extends NotificationState {}

class NotificationDeleteFail extends NotificationState {}
