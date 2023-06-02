import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:packers_and_movers_app/domain/models/models.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/user/remote_user_data_source.dart';
import 'package:packers_and_movers_app/infrastructure/repository/user/userRepository.dart';

part 'user_main_event.dart';
part 'user_main_state.dart';

class UserMainBloc extends Bloc<UserMainEvent, UserMainState> {
  final UserRepository userRepository = UserRepository();
  UserMainBloc() : super(UserMainScreenState([])) {
    on<UserMainScreenEvent>((event, emit) async {
      List<Mover> movers = await userRepository.getMovers();
      print("fetched movers: $movers");
      emit(UserMainScreenLoadingState(movers));
    });

    on<UserMoverDetails>((event, emit) {
      Mover mover = event.mover;
      print("opening mover details screen");
      emit(UserMoverDetailsState(mover));
    });

    on<UserSubmitUpdateEvent>((event, emit) async {
      userRepository.userDataProvider.updatePassword(event.password);
      emit(UserUpdateSuccessful());
    });
  }
}
