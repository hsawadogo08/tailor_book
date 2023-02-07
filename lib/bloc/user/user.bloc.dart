import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/models/password.model.dart';
import 'package:tailor_book/models/utilisateur.model.dart';
import 'package:tailor_book/services/user.service.dart';

abstract class UserEvent {}

class RegistedStatusEvent extends UserEvent {}

class UserInfosEvent extends UserEvent {}

class UpdateUserInfosEvent extends UserEvent {
  final Utilisateur currentUser;
  UpdateUserInfosEvent({
    required this.currentUser,
  });
}

class UpdatePasswordEvent extends UserEvent {
  final Password password;
  UpdatePasswordEvent({
    required this.password,
  });
}

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

class UpdateUserSuccessState extends UserStates {
  final String successMessage;
  UpdateUserSuccessState({
    required this.successMessage,
  });
}

class UpdatePasswordSuccessState extends UserStates {
  final String successMessage;
  UpdatePasswordSuccessState({
    required this.successMessage,
  });
}

class UserErrorState extends UserStates {
  final String errorMessage;
  UserErrorState({
    this.errorMessage = "",
  });
}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UpdateUserInfoLoadingState extends UserStates {}

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

    on((UpdateUserInfosEvent event, emit) async {
      log("Update");
      if (event.currentUser.companyName == '') {
        emit(
          UserErrorState(
            errorMessage: "Le nom de l'entreprise est obligatoire !",
          ),
        );
      } else if (event.currentUser.lastName == '') {
        emit(
          UserErrorState(
            errorMessage: "Le nom est obligatoire !",
          ),
        );
      } else if (event.currentUser.firstName == '') {
        emit(
          UserErrorState(
            errorMessage: "Le prénom est obligatoire !",
          ),
        );
      } else {
        emit(UserLoadingState());
        await UserService.updateCurrentUserInfos(event.currentUser);
        emit(
          UpdateUserSuccessState(
            successMessage: "Votre profil a été mis à jour avec succès !",
          ),
        );
      }
    });

    on((UpdatePasswordEvent event, emit) async {
      if (event.password.currentPassword == '') {
        emit(
          UserErrorState(
            errorMessage: "Veuillez renseigner le mot de passe actuel !",
          ),
        );
      } else if (event.password.newPassword == '') {
        emit(
          UserErrorState(
            errorMessage: "Veuillez renseigner le nouveau mot de passe !",
          ),
        );
      } else if (event.password.confirmNewPassword == '') {
        emit(
          UserErrorState(
            errorMessage:
                "Veuillez renseigner la confirmation du nouveau mot de passe !",
          ),
        );
      } else if (event.password.newPassword !=
          event.password.confirmNewPassword) {
        emit(
          UserErrorState(
            errorMessage:
                "La confirmation du nouveau mot de passe est incorrecte !",
          ),
        );
      } else {
        emit(UserLoadingState());
        Utilisateur currentUser = await UserService.getCurrentUserInfos();

        log("Current password ==> ${currentUser.password}");
        log("New password ==> ${event.password.currentPassword}");
        if (currentUser.password != event.password.currentPassword) {
          emit(
            UserErrorState(
              errorMessage: "Le mot de passe actuel est incorrect !",
            ),
          );
        } else {
          await UserService.updatePassword(
              event.password.newPassword!, currentUser,);
          emit(
            UpdatePasswordSuccessState(
              successMessage: "Votre mot de passe a été modifié avec succès !",
            ),
          );
        }
      }
    });
  }
}
