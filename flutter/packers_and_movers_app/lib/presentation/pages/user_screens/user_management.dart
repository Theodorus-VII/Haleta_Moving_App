import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:packers_and_movers_app/application/auth/signin_bloc/auth_bloc.dart';
import 'package:packers_and_movers_app/application/auth/signin_bloc/auth_event.dart';
import 'package:packers_and_movers_app/application/auth/signin_bloc/auth_state.dart';
import 'package:packers_and_movers_app/application/user/bloc/user_main_bloc.dart';
import 'package:packers_and_movers_app/domain/models/models.dart';

import '../../widgets/custom_text_field.dart';

class UserEditScreen extends StatefulWidget {
  const UserEditScreen({super.key});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  bool? _mover = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: const BoxDecoration(
              // color: Color(0xff151f2c),
              ),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Hey there,",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        Text(
                          "Want to update your Account?",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        BuildTextField(
                          controller: passwordController,
                          icon: Icon(Icons.lock_outline_rounded),
                          labelText: 'Password',
                          hintText: '********',
                          obscured: true,
                        ),
                        BuildTextField(
                          controller: confirmPasswordController,
                          icon: Icon(Icons.lock_rounded),
                          labelText: 'Confirm Password',
                          hintText: '********',
                          obscured: true,
                        ),
                        const SizedBox(height: 10),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            print(state);
                            if (state is AuthUserUpdateSuccess) {
                              context.goNamed('signin');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Password Changed. Please login with the new password to continue.")));
                            }
                            if (state is AuthUserUpdateFail) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Update Failed. Please try again later.")));
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Check your password again")));
                                }
                                Map<String, dynamic> user_info = {
                                  'password': passwordController.text,
                                };
                                final AuthEvent event =
                                    AuthUserUpdate(passwordController.text);

                                setState(
                                  () {
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(event);
                                  },
                                );
                              },
                              child: const Text("Change Password"),
                            );
                          },
                        ),
                        const SizedBox(height: 100),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthLogoutSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Logging you out")));
                                context.goNamed('signin');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Logout Failed $state")));
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  final event = AuthLogoutEvent();
                                  setState(
                                    () {
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(event);
                                    },
                                  );
                                },
                                child: const Text("Logout"),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
