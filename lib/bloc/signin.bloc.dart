// Event
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/models/utilisateur.model.dart';
import 'package:tailor_book/services/user.service.dart';

abstract class SignInEvent {}

class SignInWithPhoneNumberEvent extends SignInEvent {
  final String phoneNumber;
  final String password;
  SignInWithPhoneNumberEvent({
    required this.phoneNumber,
    required this.password,
  });
}

// States
abstract class SignInStates {}

class SignInSuccessState extends SignInStates {
  final String successMessage;
  SignInSuccessState({
    required this.successMessage,
  });
}

class SignInErrorState extends SignInStates {
  final String errorMessage;
  SignInErrorState({
    required this.errorMessage,
  });
}

class SignInInitialState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

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
              successMessage: "Bienvenue ${utilisateur?.lastName} !",
            ),
          );
        } catch (e) {
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
