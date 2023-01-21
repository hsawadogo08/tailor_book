import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/models/utilisateur.model.dart';
import 'package:tailor_book/services/user.service.dart';

abstract class UserEvent {}

class RegistedStatusEvent extends UserEvent {}

class UserInfosEvent extends UserEvent {}

// States
abstract class UserStates {}

class GetRegistedStatusSuccessState extends UserStates {
  final bool status;
  GetRegistedStatusSuccessState({
    required this.status,
  });
}

class GetUserInfosState extends UserStates {
  final Utilisateur user;
  GetUserInfosState({
    required this.user,
  });
}

class UserErrorState extends UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

// Bloc
class UserBloc extends Bloc<UserEvent, UserStates> {
  UserBloc() : super(UserInitialState()) {
    on((RegistedStatusEvent event, emit) async {
      emit(UserLoadingState());

      bool registedStatus = await UserService.getRegistedStatus();
      emit(
        GetRegistedStatusSuccessState(
          status: registedStatus,
        ),
      );
    });

    on((UserInfosEvent event, emit) async {
      emit(UserLoadingState());
      Utilisateur user = await UserService.getCurrentUserInfos();
      emit(GetUserInfosState(user: user));
    });
  }
}
