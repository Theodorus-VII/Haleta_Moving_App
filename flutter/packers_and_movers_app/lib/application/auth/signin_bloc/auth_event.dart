import 'package:equatable/equatable.dart';
import 'package:packers_and_movers_app/domain/models/models.dart';
import 'package:packers_and_movers_app/domain/models/mover_signup_dto.dart';
import 'package:packers_and_movers_app/domain/models/user_signup_dto.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AuthDefaultEvent extends AuthEvent{}
class AuthSignIn extends AuthEvent {
  final String email;
  final String password;
  const AuthSignIn({required this.email, required this.password});

  @override
  List<Object> get props => [];
}

class AuthUserUpdate extends AuthEvent {
  final String password;

  const AuthUserUpdate(this.password);

  @override
  List<Object> get props => [];
}

class AuthUserSignUp extends AuthEvent {
  final UserDto newUser;
  const AuthUserSignUp(this.newUser);

  @override
  List<Object> get props => [newUser];
}

class AuthMoverSignUp extends AuthEvent {
  final Map<String, dynamic> mover;

  const AuthMoverSignUp({required this.mover});

  @override
  List<Object> get props => [mover];
}

class AuthMoverSignUpSubmit extends AuthEvent {
  final MoverSignUpDto mover;
  const AuthMoverSignUpSubmit(this.mover);

  @override
  List<Object> get props => [mover];
}

class AuthMoverUpdate extends AuthEvent {
  final Map<String, dynamic> mover;

  const AuthMoverUpdate({required this.mover});

  @override
  List<Object> get props => [mover];
}

class AuthUserDelete extends AuthEvent {
  final int id;

  const AuthUserDelete(this.id);

  @override
  List<Object> get props => [id];
}

class AuthGetUser extends AuthEvent {
  @override
  List<Object> get props => [];
}

class AuthLogoutEvent extends AuthEvent {}
