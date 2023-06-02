import 'package:packers_and_movers_app/domain/models/mover_signup_dto.dart';
import 'package:packers_and_movers_app/domain/models/user_signup_dto.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/local_data_source/local_data_provider.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/api_response.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/auth/auth_data_provider.dart';

import '../../../domain/models/mover.dart';
import '../../../domain/models/user.dart';
import 'dart:convert';

class AuthRepository {
  // logic to route between the two data sources here. nothing more
  // will skip it till later
  final RemoteAuthDataProvider remoteDataProvider;
  AuthRepository(this.remoteDataProvider);
  final LocalDataProvider localDataProvider = LocalDataProvider();

  Future<ApiResponse> signIn(String email, String password) async {
    print("here");
    await localDataProvider.emptyDb();
    String? token = await localDataProvider.getToken();
    print('local token $token');
    print("going remote here");
    ApiResponse response = await remoteDataProvider.authenticateUser(
        email: email, password: password, token: token);
    print("Repository. initiating models");
    await localDataProvider.addUser(response.data as User);
    print('added to local db');
    print('repsponse data ${response.data}');

    String? t = await localDataProvider.getToken();
    print(t);

    return response;
  }

  Object modelUser(Map<String, dynamic> json) {
    print(json['role']);
    if (json['role'] == 'MOVER') {
      print('here');
      return Mover.fromMap(json);
    }
    return User.fromMap(json);
  }

  Future<ApiResponse> moverSignUp(MoverSignUpDto mover) async {
    // return remoteDataProvider.moverSignUp(mover: mover);
    print("mover");
    ApiResponse response = await remoteDataProvider.moverSignUp(mover: mover);
    return response;
  }

  Future<ApiResponse> userSignUp(UserDto user) async {
    print("user");
    ApiResponse response = await remoteDataProvider.UserSignUp(user);
    return response;
  }
}
