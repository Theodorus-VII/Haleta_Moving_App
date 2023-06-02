// part of 'sign_up_bloc.dart';

import '../../../../domain/models/user.dart';

abstract class AuthSignUpEvent {
  const AuthSignUpEvent();
}

class AuthUserUpdate extends AuthSignUpEvent {
  final User user;
  final int id;

  const AuthUserUpdate({required this.user, required this.id});

  @override
  List<Object> get props => [id];
}

class AuthUserSignUp extends AuthSignUpEvent {
  final User newUser;
  const AuthUserSignUp(this.newUser);

  @override
  List<Object> get props => [newUser];
}

class AuthMoverSignUp extends AuthSignUpEvent {
  final Map<String, dynamic> mover;

  const AuthMoverSignUp({required this.mover});

  @override
  List<Object> get props => [mover];
}

class AuthMoverSignUpSubmit extends AuthMoverSignUp {
  const AuthMoverSignUpSubmit(mover) : super(mover: mover);

  @override
  List<Object> get props => [mover];
}

// class AuthMoverSignUpInitial extends AuthSignUpEvent{
//   const AuthMoverSignUpInitial(mover):super(mover: mover);

//   @override
//   List<Object> get props => [mover];
// }

class AuthMoverUpdate extends AuthSignUpEvent {
  final Map<String, dynamic> mover;

  const AuthMoverUpdate({required this.mover});

  @override
  List<Object> get props => [mover];
}

class AuthUserDelete extends AuthSignUpEvent {
  final int id;

  const AuthUserDelete(this.id);

  @override
  List<Object> get props => [id];
}
