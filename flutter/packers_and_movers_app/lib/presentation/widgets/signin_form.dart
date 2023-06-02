import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:packers_and_movers_app/application/auth/signin_bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packers_and_movers_app/application/auth/signin_bloc/auth_state.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/appointments/appointment_remote.dart';

import '../../application/auth/signin_bloc/auth_bloc.dart';
import '../../infrastructure/data_sources/remote_data_source/api_response.dart';
import '../../infrastructure/data_sources/remote_data_source/auth/auth_data_provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is Authenticated) {
        if (state.user!.role == "MOVER") {
          context.pushReplacementNamed('mover_main');
        } else {
          context.pushReplacementNamed('user');
        }
      }
      // state.map(
      //     initial: (_) {},
      //     authenticated: (_) => {
      //           if (state is Authenticated)
      //             {
      //               if (state.user!.role == "MOVER")
      //                 {context.pushReplacementNamed('mover_main')}
      //               else
      //                 {context.pushReplacementNamed('user')}
      //             }
      //         },
      //     unauthenticated: (_) => context.pushReplacementNamed('signin'));
    }, builder: (context, state) {
      // BlocProvider.of<AuthBloc>(context).add(AuthDefaultEvent());
      print(state);
      return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Sign In"),
              // backgroundColor: Colors.amber,
            ),
            // backgroundColor: Colors.amber,
            body: Center(
                child: SafeArea(
              child: Stack(children: [
                SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/home-logo.png',
                          width: 250,
                          // color: const Color.fromARGB(171, 218, 8, 8),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 70),
                            child: TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Can not be empty";
                                }
                                return null;
                              },
                              obscureText: false,
                              style: const TextStyle(
                                  height: 0.7, backgroundColor: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Email',
                                hintText: "jondoe@gmail.com",
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 70),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Can not be empty";
                              }
                              return null;
                            },
                            obscureText: true,
                            style: const TextStyle(
                                height: 0.7, backgroundColor: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: 'Password',
                              hintText: "Enter your password",
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              // emailController.text = 'mover@gmail.com';
                              // emailController.text = 'user1@gmail.com';
                              // passwordController.text = 'password';

                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing')));
                                // _handleSubmitted();
                                // print(state);

                                final FormState? form = _formKey.currentState;
                                if (form != null && form.validate()) {
                                  form.save();

                                  final AuthEvent event = AuthSignIn(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  BlocProvider.of<AuthBloc>(context).add(event);

                                  if (state is Authenticated) {}
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Please use valid input")));
                              }
                            },
                            child: const Text("Sign In")),
                        const SizedBox(height: 50),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Dont have an account? Sign up"),
                              TextButton(
                                  onPressed: () {
                                    context.goNamed("signup");
                                  },
                                  child: const Text("Here")),
                            ])
                      ]),
                )
              ]),
            )),
          ));
    });
  }
}
