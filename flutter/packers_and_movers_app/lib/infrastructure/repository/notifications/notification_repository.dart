import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/notifications/notifications_remote.dart';
import '../../../domain/models/models.dart';

class NotificationRepository {
  NotificationRepository();
  RemoteNotificationProvider remoteNotificationProvider =
      RemoteNotificationProvider();

  Future<Notification_?> getNotifications(int appointmentId) async {
    final notifications =
        await remoteNotificationProvider.getNotifications(appointmentId);
    if (notifications.length > 0) {
      print('NOTIFICATIONS : ${notifications[notifications.length - 1]}');
      return Notification_.fromMap(notifications[notifications.length - 1]);
    }
    return null;
  }

  Future<bool> postNotification(Notification_ notification) async {
    return await remoteNotificationProvider.postNotifications(notification);
  }

  Future<bool> patchNotification(Notification_ notification) async {
    return await remoteNotificationProvider.patchNotification(notification);
  }

  Future<bool> deleteNotification(int stage, int appointmentId) async {
    return await remoteNotificationProvider.deleteNotification(
        stage, appointmentId);
  }

  Future<List<dynamic>> getAllNotifications(int appointmentId) async {
    final notifications =
        await remoteNotificationProvider.getNotifications(appointmentId);
    print('NOTIFICATIONS : ${notifications}');
    final ret = [];
    for (var n in notifications) {
      ret.add(Notification_.fromMap(n));
    }
    return ret;
  }
}
