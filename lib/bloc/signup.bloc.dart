// Events
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/models/utilisateur.model.dart';
import 'package:tailor_book/services/sharedPrefConfig.dart';
import 'package:tailor_book/services/sharedPrefKeys.dart';
import 'package:tailor_book/services/user.service.dart';

abstract class SignUpEvent {}

class SendOtpEvent extends SignUpEvent {
  final String phoneNumber;
  final int? forceResendingToken;
  SendOtpEvent({
    required this.phoneNumber,
    this.forceResendingToken,
  });
}

// States
abstract class SignUpStates {}

class SendOtpSuccessState extends SignUpStates {
  final String verificationId;
  final int? forceResendingToken;
  SendOtpSuccessState({
    required this.verificationId,
    this.forceResendingToken,
  });
}

class SignupCompeletEvent extends SignUpEvent {
  final Utilisateur utilisateur;
  SignupCompeletEvent({
    required this.utilisateur,
  });
}

class SignUpSuccessState extends SignUpStates {
  final String successMessage;
  SignUpSuccessState({
    required this.successMessage,
  });
}

class SignUpErrorState extends SignUpStates {
  final String errorMessage;
  SignUpErrorState({
    required this.errorMessage,
  });
}

class SignUpLoadingState extends SignUpStates {}

class SignUpInitialState extends SignUpStates {}

// Bloc
class SignUpBloc extends Bloc<SignUpEvent, SignUpStates> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  SignUpBloc() : super(SignUpInitialState()) {
    on<SendOtpEvent>((SendOtpEvent event, emit) async {
      if (event.phoneNumber == '') {
        emit(
          SignUpErrorState(
            errorMessage: "Désolé! Le numéro de téléphone est obligatoire !",
          ),
        );
      } else {
        String verificationId = "";
        emit(SignUpLoadingState());
        auth
            .verifyPhoneNumber(
          phoneNumber: event.phoneNumber,
          forceResendingToken: event.forceResendingToken,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential authCredential) {},
          verificationFailed: (FirebaseAuthException authException) {
            emit(
              SignUpErrorState(
                errorMessage: "Une erreur est survenue lors de l'inscription !",
              ),
            );
          },
          codeSent: (String verificationId, [int? forceResendingToken]) {
            log("verificationId => $verificationId");
            verificationId = verificationId;
            emit(
              SendOtpSuccessState(
                verificationId: verificationId,
                forceResendingToken: forceResendingToken,
              ),
            );
          },
          codeAutoRetrievalTimeout: (String error) {
            emit(
              SignUpErrorState(
                errorMessage: "Une erreur est survenue lors de l'inscription !",
              ),
            );
          },
        )
            .then((value) {
          log("verificationId 1 => $verificationId");
        });
        log("verificationId 2 => $verificationId");
      }
    });

    on((SignupCompeletEvent event, emit) async {
      Utilisateur utilisateur = event.utilisateur;

      if (utilisateur.lastName == '') {
        emit(
          SignUpErrorState(errorMessage: "Veuillez saisir le nom."),
        );
      } else if (utilisateur.firstName == '') {
        emit(
          SignUpErrorState(errorMessage: "Veuillez saisir le prénom."),
        );
      } else if (utilisateur.password == '') {
        emit(
          SignUpErrorState(errorMessage: "Veuillez saisir le mot de passe."),
        );
      } else if (utilisateur.password != utilisateur.confirmPassword) {
        emit(
          SignUpErrorState(
              errorMessage: "La confirmation du mot de passe est incorrecte !"),
        );
      } else {
        emit(SignUpLoadingState());
        await UserService.createUser(utilisateur);
        await SharedPrefConfig.saveStringData(
          SharePrefKeys.JWT_TOKEN,
          utilisateur.userUID!,
        );
        emit(
          SignUpSuccessState(
            successMessage: "Bienvenue ${utilisateur.firstName} !",
          ),
        );
      }
    });
  }
}
