part of 'user_main_bloc.dart';

abstract class UserMainState extends Equatable {
  const UserMainState();

  @override
  List<Object> get props => [];
}

class UserMainScreenState extends UserMainState {
  final List<Mover> movers;
  const UserMainScreenState(this.movers);
}

class UserMainScreenLoadingState extends UserMainState {
  final List<Mover> movers;
  const UserMainScreenLoadingState(this.movers);
}

class UserMoverDetailsState extends UserMainState {
  final Mover mover;
  const UserMoverDetailsState(this.mover);

  @override
  List<Object> get props => [mover];
}

class UserUpdateState extends UserMainState {
  final String password;
  const UserUpdateState(this.password);
  @override
  List<Object> get props => [password];
}

class UserUpdateSuccessful extends UserMainState {
  const UserUpdateSuccessful();
}

class UserUpdateFailed extends UserMainState {
  final Object error;
  const UserUpdateFailed(this.error);
}

class UserDeleteSuccessful extends UserMainState {
  var message;
  UserDeleteSuccessful({this.message});
}

class UserDeleteUnSuccessful extends UserMainState {
  var message;
  UserDeleteUnSuccessful({this.message});
}
