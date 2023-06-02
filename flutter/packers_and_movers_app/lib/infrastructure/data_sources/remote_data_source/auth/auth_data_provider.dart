import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:packers_and_movers_app/domain/models/mover_signup_dto.dart';
import 'package:packers_and_movers_app/domain/models/user_signup_dto.dart';

import '../../../../domain/models/mover.dart';
import '../../../../domain/models/user.dart';
import '../../local_data_source/local_data_provider.dart';
import '../api_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RemoteAuthDataProvider {
  String baseUrl = 'http://10.0.2.2:3000';
  final LocalDataProvider localDataProvider = LocalDataProvider();

  Future<ApiResponse> authenticateUser(
      {required String email,
      required String password,
      required String? token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      if (token == null) {
        Uri uri = Uri.parse('$baseUrl/auth/signin');
        var response =
            await http.post(uri, body: {'email': email, 'password': password});
        token = json.decode(response.body)['access_token'];
      }

      print('found token $token');
      apiResponse = await signInWithToken(token: token as String);
      print('authenticated: ${apiResponse.data}');
    } on SocketException {
      apiResponse.apiError = ApiError(error: "Account not found");
    }
    return apiResponse;
  }

  Future<ApiResponse> signInWithToken({required String token}) async {
    // gets user info.
    ApiResponse apiResponse = ApiResponse();
    try {
      Uri uri = Uri.parse('$baseUrl/users/me');
      var response =
          await http.get(uri, headers: {"Authorization": "Bearer $token"});
      print("the response is ${response.body}");
      Map<String, dynamic> raw_user = await json.decode(response.body);
      raw_user['token'] = token;
      raw_user['Id'] = 0;
      print('raw user $raw_user');
      apiResponse.data = User.fromMap(raw_user);
      print('here');
    } on SocketException {
      apiResponse.apiError = ApiError(error: "Server error");
      // print("error``````````````````````````````````````````````````````");
    }
    return apiResponse;
  }

  Future<ApiResponse> UserSignUp(UserDto user) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Uri uri = Uri.parse('$baseUrl/auth/signup');
      var response =
          json.decode((await http.post(uri, body: user.toMap())).body);
      // print('${response['statusCode'] == 403}');
      // print(response);
      if (response['statusCode'] == 403) {
        apiResponse.apiError = response['error'];
        throw HttpException('Email Taken');
      }

      String token = response['access_token'];
      User u = User.fromMap(
          (await signInWithToken(token: token)).data as Map<String, dynamic>);
      apiResponse.data = u;
    } catch (e) {
      return apiResponse;
    }
    return apiResponse;
  }

  Future<ApiResponse> moverSignUp({required MoverSignUpDto mover}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Uri uri = Uri.parse("$baseUrl/auth/signup/mover");
      // send the regular signup stuff first.
      // send each of the 3 images separately
      var response =
          json.decode((await http.post(uri, body: mover.toMap())).body);

      String token = response['access_token'];
      print(mover.carPic);
      if (mover.carPic != null) {
        postPic(imageType: 'carPic', token: token, image: mover.carPic);
      }
      // if (mover.profilePic != null) {
      //   postPic(imageType: 'profilePic', token: token, image: mover.profilePic);
      // }
      // if (mover.idPic != null) {
      //   postPic(imageType: 'idPic', token: token, image: mover.idPic);
      // }
      apiResponse.data = response;
    } catch (e) {
      apiResponse.apiError = e;
      return apiResponse;
    }
    return apiResponse;
  }

  Future<ApiResponse> postPic(
      {required String imageType,
      required String token,
      required File? image}) async {
    ApiResponse apiResponse = ApiResponse();
    if (token == null) {
      throw "No token";
    }
    try {
      Uri uri = Uri.parse('$baseUrl/image');
      // var request = new http.MultipartRequest('POST', uri);
      // request.headers.addAll({"Authorization": "Bearer $token"});
      // List<int> imageBytes = await image.readAsBytes();
      // request.files.add(await http.MultipartFile.fromBytes(
      //   'file',
      //   imageBytes,
      //   filename: image.name,
      // ));

      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl'));
      request.headers.addAll({"Authorization": "Bearer $token"});
      if (image != null) {
        request.files.add(http.MultipartFile(
            'file', image.readAsBytes().asStream(), image.lengthSync(),
            filename: image.path.split('/').last));
        var response = await request.send();
        apiResponse.data = response;
        print(response);
      }
    } catch (e) {
      apiResponse.apiError = e;
    }
    return apiResponse;
  }
}
