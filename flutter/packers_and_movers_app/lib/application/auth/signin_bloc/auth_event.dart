import 'package:equatable/equatable.dart';
import 'package:packers_and_movers_app/domain/models/models.dart';
import 'package:packers_and_movers_app/domain/models/mover_signup_dto.dart';
import 'package:packers_and_movers_app/domain/models/user_signup_dto.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;
  const AuthSignIn({required this.email, required this.password});

  @override
  List<Object> get props => [];
}

class AuthUserUpdate extends AuthEvent {
  final User user;
  final int id;

  const AuthUserUpdate({required this.user, required this.id});

  @override
  List<Object> get props => [id];
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
