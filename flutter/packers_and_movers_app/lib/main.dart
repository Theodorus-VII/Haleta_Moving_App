import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:packers_and_movers_app/application/appointments/bloc/appointment_bloc.dart';
import 'package:packers_and_movers_app/application/auth/signin_bloc/auth_bloc.dart';
import 'package:packers_and_movers_app/application/user/bloc/user_main_bloc.dart';
import 'package:packers_and_movers_app/block_observer.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/auth/auth_data_provider.dart';
import 'package:packers_and_movers_app/presentation/pages/splash_page.dart';
import 'package:packers_and_movers_app/presentation/pages/user_screens/user_management.dart';
import 'infrastructure/repository/auth/auth_repository.dart';
import 'landing.dart';
import 'presentation/pages/auth_screens/auth.dart';
import 'presentation/pages/mover_screens/mover.dart';
import 'presentation/pages/user_screens/user.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color.fromARGB(255, 66, 30, 139)),
  textTheme: GoogleFonts.latoTextTheme(),
);

final _router = GoRouter(routes: [
  GoRoute(
      // home widget. checks if the user is already logged in
      // if so, should open the users screen
      // if not open the login screen
      name: "landing",
      path: '/',
      builder: (context, state) {
        return const Landing();
        // return UserMain();
      }),
  GoRoute(
      name: "signin",
      path: '/signin',
      builder: (context, state) {
        return const SignInScreen();
      },
      routes: [
        GoRoute(
            name: "signup",
            path: 'signin/signup',
            builder: (context, state) {
              return const SignUpScreen();
            },
            routes: [
              GoRoute(
                  name: "mover_signup",
                  path: 'signin/signup/mover_signup',
                  builder: (context, index) {
                    return const MoverSignupScreen();
                  }),
            ]),
      ]),
  GoRoute(
      name: 'user',
      path: '/user',
      builder: (BuildContext context, GoRouterState state) {
        // return const MoverMain();
        return const UserMain();
      },
      routes: [
        GoRoute(
          path: 'user/user_edit_screen',
          name: "user_edit_screen",
          builder: (context, state) {
            return UserEditScreen();
          },
        ),
      ]
      // routes: [
      // GoRoute(
      //     name: 'mover_detail',
      //     path: 'mover_detail',
      //     builder: (BuildContext context, GoRouterState state) {
      //       return const SeeMoverInfo();
      //     }),

      // GoRoute(
      //     path: 'order_info',
      //     builder: (BuildContext context, GoRouterState state){
      //       return OrderDetail();
      //     }
      // )
      // ]
      ),
  GoRoute(
      name: 'mover_detail',
      path: '/user/mover_detail',
      builder: (BuildContext context, GoRouterState state) {
        return SeeMoverInfo();
      }),
  GoRoute(
      name: "user_order_info",
      path: '/user/order_info',
      builder: (BuildContext context, GoRouterState state) {
        return OrderDetail();
      }),
  GoRoute(
      name: 'user_see_bookings',
      path: '/mover/see_bookings',
      builder: (BuildContext context, GoRouterState state) {
        return MoverSeeOrders();
      }),
]);
void main() {
  BlocOverrides.runZoned(() {
    WidgetsFlutterBinding.ensureInitialized();
    return runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc(
                authRepository: AuthRepository(RemoteAuthDataProvider()))),
        BlocProvider(create: (context) => UserMainBloc()),
        BlocProvider(create: (context)=>AppointmentBloc()),
      ],
      child: MaterialApp.router(
        theme: theme,
        routerConfig: _router,
        title: 'MY APP',
        debugShowCheckedModeBanner: false,
      ),
    ));
  }, blocObserver: SimpleBlocObserver());
}
