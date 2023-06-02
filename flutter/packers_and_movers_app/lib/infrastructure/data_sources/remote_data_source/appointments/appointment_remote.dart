import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:packers_and_movers_app/domain/models/appointment.dart';
import 'package:packers_and_movers_app/domain/models/appointment_model.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/api_response.dart';
import 'package:http/http.dart' as http;

import '../../local_data_source/local_data_provider.dart';

class RemoteAppointmentDataProvider {
  // get appointments for user and mover, add appointment, update appointment, delete appointment
  //
  final String baseUrl = 'http://10.0.2.2:3000/appointments';
  final LocalDataProvider localDataProvider = LocalDataProvider();

  Future<List<Appointment>> getUserAppointments() async {
    try {
      Uri uri = Uri.parse('$baseUrl/user');
      // String? token = await storage.read(key: 'token');
      // String token =
      //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjcsImVtYWlsIjoidXNlcjNAZ21haWwuY29tIiwicm9sZXMiOlsiVVNFUiJdLCJpYXQiOjE2ODU2Mjc1NDUsImV4cCI6MTY4NTg2Nzg0NX0.iG7mljM5raJnb0zyMZ4QHvrmCoZckraW50NxE-70ciA';
      String? token = await localDataProvider.getToken();
      var response =
          await http.get(uri, headers: {"Authorization": "Bearer $token"});

      List<dynamic> raw_appointments =
          jsonDecode(response.body)['appointments'];
      print(raw_appointments);
      List<Appointment> appointments = [];
      for (int i = 0; i < raw_appointments.length; i++) {
        appointments.add(Appointment.fromMap(raw_appointments[i]));
        print(appointments);
      }
      print(appointments);
      return appointments;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Appointment>> getMoverAppointments(int moverId) async {
    try {
      Uri uri = Uri.parse('$baseUrl/mover');
      // String token =
      //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjgsImVtYWlsIjoibW92ZXIxQGdtYWlsLmNvbSIsInJvbGVzIjpbIk1PVkVSIl0sImlhdCI6MTY4NTYyOTE4NywiZXhwIjoxNjg1ODY5NDg3fQ.COFSp699LU8IN8vT9qTcFK_e8jXXhrU5wwLf00fOo1M';
      String? token = await localDataProvider.getToken();
      var response =
          await http.get(uri, headers: {"Authorization": "Bearer $token"});

      List<dynamic> raw_appointments =
          jsonDecode(response.body)['appointments'];
      List<Appointment> appointments = [];
      for (int i = 0; i < raw_appointments.length; i++) {
        // print(raw_appointments[i]['Id']);
        appointments.add(Appointment.fromMap(raw_appointments[i]));
        // print(appointments);
      }
      // print(appointments);
      return appointments;
    } catch (e) {
      // print(e);
      throw e;
    }
  }

  Future<AppointmentDto> userPostAppointment(
      Map<String, dynamic> new_appointment) async {
    try {
      Uri uri = Uri.parse('$baseUrl/create');
      String? token = await localDataProvider.getToken();
      print("$new_appointment $token");
      var response = await http.post(uri, headers: {
        "Authorization": "Bearer $token"
      }, body: {
        "moverId": new_appointment['moverId'],
        "setDate": new_appointment['setDate'],
        "startLocation": "nowhere",
        "destination": "nowhere"
      });
      print("herer");
      var appointment = AppointmentDto.fromMap(jsonDecode(response.body));

      return appointment;
    } catch (e) {
      throw e;
    }
  }

  Future<Object> moverRejectAppointment(int appointmentId) async {
    try {
      Uri uri = Uri.parse('$baseUrl/$appointmentId');
      String? token = await localDataProvider.getToken();
      var response =
          await http.patch(uri, headers: {"Authorization": "Bearer $token"});
      return response;
    } catch (e) {
      throw e;
    }
  }

  // Future<Appointment> userUpdateAppointment(Appointment new_appointment) async{
  //   try{
  //     Uri uri =
  //   }
  // }
}
