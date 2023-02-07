import 'dart:developer';
import 'package:bloc/bloc.dart';

import '../../models/utilisateur.model.dart';
import '../../services/user.service.dart';
import 'signin_event.dart';
import 'signin_state.dart';

// Bloc
class SignInBloc extends Bloc<SignInEvent, SignInStates> {
  SignInBloc() : super(SignInInitialState()) {
    on((SignInWithPhoneNumberEvent event, emit) async {
      String phoneNumber = event.phoneNumber;
      String password = event.password;
      if (phoneNumber == "") {
        emit(
          SignInErrorState(
            errorMessage: "Le numéro de téléphone est obligatoire !",
          ),
        );
      } else if (password == "") {
        emit(
          SignInErrorState(
            errorMessage: "Le mot de passe est obligatoire !",
          ),
        );
      } else {
        emit(SignInLoadingState());
        try {
          Utilisateur? utilisateur =
              await UserService.onSignin(phoneNumber, password);
          emit(
            SignInSuccessState(
              successMessage: "Bienvenue ${utilisateur?.firstName} !",
            ),
          );
        } catch (e, stackTrace) {
          log("stackTrace: $stackTrace");
          log("SignIn Error: $e");
          emit(
            SignInErrorState(
              errorMessage: e.toString().split(": ")[1],
            ),
          );
        }
      }
    });
  }
}
