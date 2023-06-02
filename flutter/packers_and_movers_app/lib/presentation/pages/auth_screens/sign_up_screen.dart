import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:packers_and_movers_app/application/auth/signin_bloc/auth_bloc.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/auth/auth_data_provider.dart';
import 'package:packers_and_movers_app/infrastructure/repository/auth/auth_repository.dart';
import 'package:packers_and_movers_app/presentation/widgets/custom_text_field.dart';
import 'package:packers_and_movers_app/presentation/widgets/user_signup_form.dart';

import '../../../application/auth/signin_bloc/auth_event.dart';
import '../../../application/auth/signin_bloc/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SignUpForm();
    // return BlocProvider(
    //     create: (_) =>
    //         AuthBloc(authRepository: AuthRepository(RemoteDataProvider())),
    //     child: SignUpForm());
  }
}
