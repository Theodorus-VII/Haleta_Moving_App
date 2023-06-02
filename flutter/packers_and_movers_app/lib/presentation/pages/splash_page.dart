import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:packers_and_movers_app/application/auth/signin_bloc/auth_state.dart';

import '../../application/auth/signin_bloc/auth_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          print(state.user!.role);
          if (state.user!.role == "MOVER") {
            // context.pushReplacementNamed('mover_main');
          } else {
            // context.pushReplacementNamed('user');
          }
        }


        // state.map(
        //     initial: (_) {},
        //     authenticated: (_) {
        //       if (state is Authenticated) {
        //         print(state.user!.role);
        //       }
        //       String role = 'user';
        //       if (state is Authenticated) {
        //         role = state.user!.role;
        //       }
        //       print(role);
        //       if (role == 'MOVER') {
        //         context.pushReplacementNamed('mover_main');
        //       }
        //       context.pushReplacementNamed('user');
        //     },
        //     unauthenticated: (_) => context.pushReplacementNamed('signin'));
      },
      child: _PageWidget(),
    );
  }
}

class _PageWidget extends StatelessWidget {
  const _PageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/home-logo.png',
                width: 300,
              ),
              // Image.network(src)
              const SizedBox(
                height: 10,
              ),
              const Text("Make moving effortless with us!"),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    print("HERE BABY");
                    return context.go('/signin');
                    // GoRouter.of(context).push('/signin');
                  },
                  child: const Text("Continue")),
              // SizedBox(height: 2),
              // ElevatedButton(onPressed: (){}, child: const Text("Sign in"))
            ],
          ),
        ),
      ),
    );
  }
}
