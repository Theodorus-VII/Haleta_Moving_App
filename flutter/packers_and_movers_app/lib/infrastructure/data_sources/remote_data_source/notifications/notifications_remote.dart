import 'dart:convert';

import '../../../../domain/models/models.dart';
import '../../local_data_source/local_data_provider.dart';
import 'package:http/http.dart' as http;

class RemoteNotificationProvider {
  final LocalDataProvider localDataProvider = LocalDataProvider();

  getNotifications(int appointmentId) async {
    String? token = await localDataProvider.getToken();
    if (token == null) {
      throw "Unauthorised User";
    }
    Uri uri = Uri.parse('http://10.0.2.2:3000/notification/$appointmentId');
    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      print(res);
      return res['notification'];
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<bool> postNotifications(Notification_ notification) async {
    String? token = await localDataProvider.getToken();
    if (token == null) {
      throw "Unauthorised User";
    }
    Uri uri = Uri.parse('http://10.0.2.2:3000/notification');
    print("posting notification");
    print(notification.stage);
    try {
      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({
            "appointmentId": notification.appointmentId,
            "update": notification.update,
            "stage": notification.stage
          }));
      print(json.decode(response.body));
      print(response.statusCode);
      if (response.statusCode < 300) {
        final res = json.decode(response.body);
        print(res);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> patchNotification(Notification_ notification) async {
    String? token = await localDataProvider.getToken();
    if (token == null) {
      throw "Unauthorised User";
    }
    Uri uri = Uri.parse('http://10.0.2.2:3000/notification');
    print("patching notification");
    print(notification.stage);
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final Map<String, dynamic> body = {
        "appointmentId": notification.appointmentId,
        "stage": notification.stage,
      };
      if (notification.update.isNotEmpty) {
        body["update"] = notification.update;
      }
      final response =
          await http.patch(uri, headers: headers, body: json.encode(body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw "${response.reasonPhrase}";
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteNotification(int stage, int appointmentId) async {
    String? token = await localDataProvider.getToken();
    if (token == null) {
      throw "Unauthorised User";
    }
    Uri uri = Uri.parse('http://10.0.2.2:3000/notification');
    print("patching notification");
    print(stage);
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final Map<String, dynamic> body = {
        "stage": stage,
        "appointmentId": appointmentId
      };
      final response =
          await http.delete(uri, headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        return true;
      } else {
        throw "${response.reasonPhrase}";
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
