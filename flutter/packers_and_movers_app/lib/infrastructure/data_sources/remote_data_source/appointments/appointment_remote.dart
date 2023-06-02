import 'dart:convert';

import 'package:packers_and_movers_app/domain/models/appointment.dart';

import '../../../../domain/models/user.dart';
import '../../local_data_source/local_data_provider.dart';
import 'package:http/http.dart' as http;

class RemoteProvider {
  final LocalDataProvider localDataProvider = LocalDataProvider();

  Future<List<Appointment>> fetchAppointments() async {
    // print("fetching appointments");
    String? token = await localDataProvider.getToken();
    if (token == null) {
      throw "Unauthorised User";
    }
    Uri uri = Uri.parse('http://10.0.2.2:3000/appointments/user');
    final response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode != 200) {
      throw "Error";
    }
    final raw_appointments = await jsonDecode(response.body)['appointments'];
    uri = Uri.parse('http://10.0.2.2:3000/users/allMovers');
    final List<Appointment> appointments = [];
    for (var appointment in raw_appointments) {
      appointments.add(Appointment.fromMap(appointment));
    }
    return appointments;
  }

  Future<User> fetchUserById(int userId) async {
    String? token = await localDataProvider.getToken();
    print("MOVER READ");
    if (token == null) {
      throw "Unauthorised User";
    }
    Uri uri = Uri.parse('http://10.0.2.2:3000/users/$userId');
    final response =
        await http.get(uri, headers: {"Authorization": "Bearer $token"});
    print("MOVER READ ${json.decode(response.body)}");
    if (response.statusCode != 200) {
      throw "failed to fetch user";
    }
    print('MOVER READ returning');
    return User.fromMap(json.decode(response.body));
  }

  Future<bool> moverUpdateAppointment(
      int appointmentId, int statusUpdate) async {
    String? token = await localDataProvider.getToken();

    if (token == null) {
      throw "Unauthorised User";
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.Request('PATCH', Uri.parse('http://10.0.2.2:3000/appointments'));
    request.body =
        json.encode({"appointmentId": appointmentId, "status": statusUpdate});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print("APPOINTMENT UPDATE FAIL ${response.reasonPhrase}");
      return false;
    }
  }

  Future<bool> deleteAppointment(int appointmentId) async {
    String? token = await localDataProvider.getToken();

    if (token == null) {
      throw "Unauthorised User";
    }
    print("deleting appointment");

    print(appointmentId);
    Uri uri = Uri.parse('http://10.0.2.2:3000/appointments');
    final response = await http.delete(uri,
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: json.encode({"appointmentId": appointmentId}));

    print("deleting appointment ${json.decode(response.body)}");

    if (response.statusCode != 204) {
      return false;
    }
    return true;
  }

  Future<bool> bookAppointment(String bookDate, int moverId) async {
    Uri uri = Uri.parse("http://10.0.2.2:3000/appointments/create");
    String? token = await localDataProvider.getToken();
    try {
      // print("book appointment token $token");
      if (token != null) {
        // print("book appointment '$bookDate' $moverId $uri");
        final response = await http.post(uri,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              "Authorization": "Bearer $token"
            },
            body: json.encode({
              "moverId": moverId,
              "setDate": bookDate,
              "startLocation": "unimplemented",
              "destination": "unimplemented",
            }));
        // print("book appointment response ${response.body}")
        if (response.statusCode != 201) {
          throw Exception("failed to book");
        }
        return true;
      }
      return false;
    } catch (e) {
      // print('book appointment $e');
      rethrow;
    }
  }
}
