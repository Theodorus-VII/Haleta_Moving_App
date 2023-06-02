import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:packers_and_movers_app/application/auth/signin_bloc/auth_bloc.dart';
import 'package:packers_and_movers_app/application/auth/signin_bloc/auth_event.dart';
import 'package:packers_and_movers_app/domain/models/models.dart';
import 'package:packers_and_movers_app/domain/models/user_signup_dto.dart';
import 'package:packers_and_movers_app/presentation/pages/auth_screens/auth.dart';

import '../../application/auth/signin_bloc/auth_state.dart';
import 'custom_text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print(state);
        if (state is SignUpFailed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text("Email Taken. Please choose another Email Address")));
        } else if (state is MoverSigningUp) {
          context.pushNamed('mover_signup');
        } else if (state is AuthSignUpSuccess) {
          print(state);
          BlocProvider.of<AuthBloc>(context).add(AuthDefaultEvent());
          context.goNamed('signin');
        }
      },
      builder: (context, state) {
        print(state);
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
                      child: Column(
                        children: [
                          Text(
                            "Hey there,",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          Text(
                            "Create an Account",
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          BuildTextField(
                              controller: usernameController,
                              labelText: 'Username',
                              hintText: 'jondoe21',
                              icon: const Icon(Icons.person)),
                          BuildTextField(
                              controller: firstNameController,
                              labelText: 'First Name',
                              hintText: 'Jon',
                              icon: const Icon(Icons.person_2_rounded)),
                          BuildTextField(
                              controller: lastNameController,
                              labelText: 'Last Name',
                              hintText: 'Doe',
                              icon: const Icon(Icons.person_2_rounded)),
                          BuildTextField(
                              controller: emailController,
                              labelText: 'Email',
                              hintText: 'jondoe@gmail.com',
                              icon: const Icon(Icons.email_rounded)),
                          BuildTextField(
                              controller: phoneNumberController,
                              labelText: 'Phone Number',
                              hintText: '+2519554477',
                              icon: const Icon(Icons.phone)),
                          BuildTextField(
                            controller: passwordController,
                            icon: const Icon(Icons.lock_outline_rounded),
                            labelText: 'Password',
                            hintText: '********',
                            obscured: true,
                          ),
                          BuildTextField(
                            controller: confirmPasswordController,
                            icon: const Icon(Icons.lock_rounded),
                            labelText: 'Confirm Password',
                            hintText: '********',
                            obscured: true,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: _mover,
                                onChanged: (value) {
                                  setState(() {
                                    _mover = value;
                                  });
                                },
                              ),
                              const Text(
                                  "Are you a mover/packer? check this box and proceed")
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                print(passwordController.text);
                                if ((passwordController.text !=
                                        confirmPasswordController.text) ||
                                    passwordController.text == '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Check your password again")));
                                } else {
                                  Map<String, dynamic> user_info = {
                                    'username': usernameController.text,
                                    'firstName': firstNameController.text,
                                    'lastName': lastNameController.text,
                                    'email': emailController.text,
                                    'phoneNumber': phoneNumberController.text,
                                    'password': passwordController.text,
                                  };
                                  // print(user_info);

                                  if (_mover == true) {
                                    // mover signup
                                    final AuthEvent event =
                                        AuthMoverSignUp(mover: user_info);
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(event);
                                    // context.pushNamed('mover_signup');

                                    // MoverSignupScreen();
                                  } else {
                                    UserDto new_user =
                                        UserDto.fromMap(user_info);
                                    print(new_user);
                                    final AuthEvent event =
                                        AuthUserSignUp(new_user);
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(event);
                                  }
                                }
                              },
                              child: const Text("Sign up")),
                          const SizedBox(
                            height: 50,
                          ),
                          const Text("Already have an account?"),
                          TextButton(
                              onPressed: () {
                                if (context.canPop()) {
                                  context.pop();
                                } else {
                                  context.go("signin");
                                }
                              },
                              child: const Text("Sign in")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
