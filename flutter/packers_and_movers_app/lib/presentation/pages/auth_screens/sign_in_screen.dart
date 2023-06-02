import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packers_and_movers_app/application/auth/signin_bloc/auth_bloc.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/auth/auth_data_provider.dart';
import 'package:packers_and_movers_app/infrastructure/repository/auth/auth_repository.dart';
import 'package:packers_and_movers_app/presentation/widgets/signin_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SignInForm();
    // return BlocProvider(
    //   create: (_)=>AuthBloc(authRepository: AuthRepository(RemoteDataProvider())),
    //   child: const SignInForm());
  }
}
