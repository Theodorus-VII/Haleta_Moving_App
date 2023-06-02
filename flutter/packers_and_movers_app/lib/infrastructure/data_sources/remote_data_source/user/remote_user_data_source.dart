import 'dart:convert';

import 'package:packers_and_movers_app/domain/models/models.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/local_data_source/local_data_provider.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/api_response.dart';
import 'package:http/http.dart' as http;

class RemoteUserDataProvider {
  String baseUrl = 'http://10.0.2.2:3000';
  final LocalDataProvider localDataProvider = LocalDataProvider();

  Future<ApiResponse> getMovers() async {
    ApiResponse apiResponse = ApiResponse();
    Uri uri = Uri.parse('$baseUrl/users/allMovers');
    print("fetching movers");

    String? token = await localDataProvider.getToken();
    try {
      if (token != null) {
        var response =
            await http.get(uri, headers: {"Authorization": "Bearer $token"});
        List<dynamic> x = json.decode(response.body)['movers'];

        List<Mover> movers = [];
        // for (Map<String, dynamic> mover
        //     in json.decode(response.body)['movers']) {
        //   movers.add(Mover.fromMap(mover));
        // }

        print("movers fetched $x");
        for (int i = 0; i < x.length; i++) {
          print(x[i]);
          movers.add(Mover.fromMap(x[i]));
        }
        apiResponse.data = movers;
        print(movers);
      }
    } catch (e) {
      apiResponse.apiError = e;
    }
    return apiResponse;
  }

  Future<bool> updatePassword(String password) async {
    Uri uri = Uri.parse("$baseUrl/users");
    String? token = await localDataProvider.getToken();
    try {
      if (token != null) {
        var response = await http.patch(uri,
            headers: {"Authorization": "Bearer $token"},
            body: {"password": password});
        response = json.decode(response.body);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
