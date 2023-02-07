import 'package:flutter/cupertino.dart';

@immutable
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
