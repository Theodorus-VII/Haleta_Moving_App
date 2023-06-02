import 'package:equatable/equatable.dart';

import '../../../domain/models/models.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];

  Function map(
      {required Function(AuthState value) initial,
      required Function(AuthState value) authenticated,
      required Function(AuthState value) unauthenticated}) {
    return initial(this);
  }
}

class AuthLoading extends AuthState {
  @override
  Function map(
      {required Function(AuthState value) initial,
      required Function(AuthState value) authenticated,
      required Function(AuthState value) unauthenticated}) {
    return initial(this);
  }
}

class Authenticated extends AuthState {
  final dynamic? user;

  const Authenticated({this.user});

  @override
  List<Object> get props => [];

  @override
  Function map(
      {required Function(AuthState value) initial,
      required Function(AuthState value) authenticated,
      required Function(AuthState value) unauthenticated}) {
    return authenticated(this);
  }
}

class Unauthenticated extends AuthState {
  final Object error;

  const Unauthenticated(this.error);

  @override
  List<Object> get props => [error];

  @override
  Function map(
      {required Function(AuthState value) initial,
      required Function(AuthState value) authenticated,
      required Function(AuthState value) unauthenticated}) {
    return unauthenticated(this);
  }
}

class MoverSigningUp extends AuthState {
  final Map<String, dynamic> mover;
  const MoverSigningUp(this.mover);

  @override
  List<Object> get props => [mover];
}

class SignUpFailed extends AuthState {
  final String error;
  const SignUpFailed(this.error);

  @override
  List<Object> get props => [];
}

class AuthLogoutSuccess extends AuthState{}
class AuthSignUpSuccess extends AuthState{}

class AuthUserUpdateSuccess extends AuthState{}
class AuthUserUpdateFail extends AuthState{}



// class MoverMainState extends AuthState {
//   final Mover mover
// }

// class AuthSignupLoading extends AuthState{}

// class AuthSignUpSuccess extends AuthState{}
// since both are similar, making them the same
