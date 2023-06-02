import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/local_data_source/local_data_provider.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/api_response.dart';
import 'package:http/http.dart' as http;

import '../../../../domain/models/user.dart';

class RemoteMoverDataProvider {
  String baseUrl = 'http://10.0.2.2:3000/movers';
  LocalDataProvider localDataProvider = LocalDataProvider();
  // fetch movers, add profile pic, remove profile pic, and all other pics

  Future<ApiResponse> getProfileImage({required int moverId}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Uri uri = Uri.parse('$baseUrl/images/profile/$moverId');
      var response = await http.get(uri);
      apiResponse.data = jsonDecode(response.body);
    } catch (e) {
      apiResponse.apiError = e;
    }
    return apiResponse;
  }

  Future<ApiResponse> getCarImage({required int moverId}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Uri uri = Uri.parse('$baseUrl/images/car/$moverId');
      var response = await http.get(uri);
      apiResponse.data = jsonDecode(response.body);
    } catch (e) {
      apiResponse.apiError = e;
    }
    return apiResponse;
  }

  Future<ApiResponse> getIdImage({required int moverId}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Uri uri = Uri.parse('$baseUrl/images/id/$moverId');
      var response = await http.get(uri);
      apiResponse.data = jsonDecode(response.body);
    } catch (e) {
      apiResponse.apiError = e;
    }
    return apiResponse;
  }

  Future<ApiResponse> deletePic({required String imageType}) async {
    ApiResponse apiResponse = ApiResponse();
    User user = await localDataProvider.getUser();
    String? token = user.token;
    if (token == null) {
      throw "No token";
    }
    int moverId = user.Id;
    try {
      Uri uri = Uri.parse('$baseUrl/image');
      var response = await http.delete(uri,
          headers: {"Authorization": "Bearer $token"},
          body: {'imageType': imageType});
      apiResponse.data = jsonDecode(response.body);
    } catch (e) {
      apiResponse.apiError = e;
    }
    return apiResponse;
  }

  
}
