part of 'user_main_bloc.dart';

@freezed
abstract class UserMainEvent extends Equatable {
  const UserMainEvent();

  @override
  List<Object> get props => [];
}

class UserMainScreenEvent extends UserMainEvent {
  // where the user can view the movers
  // final List<Mover> movers;
  const UserMainScreenEvent();

  @override
  List<Object> get props => [];
}

class UserMoverDetails extends UserMainEvent {
  final Mover mover;
  final List<Review>? reviews;
  const UserMoverDetails(this.mover, {this.reviews});

  @override
  List<Object> get props => [mover];
}

class UserUpdateEvent extends UserMainEvent {
  final UserDto user;

  const UserUpdateEvent(this.user);

  @override
  List<Object> get props => [user.email];
}

class UserSubmitUpdateEvent extends UserMainEvent {
  final String password;
  const UserSubmitUpdateEvent(this.password);

  @override
  List<Object> get props => [password];
}

class UserLogoutEvent extends UserMainEvent {}

class UserDeleteEvent extends UserMainEvent {}
