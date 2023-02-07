import 'package:flutter/cupertino.dart';

@immutable
abstract class SignInEvent {}

class SignInWithPhoneNumberEvent extends SignInEvent {
  final String phoneNumber;
  final String password;
  SignInWithPhoneNumberEvent({
    required this.phoneNumber,
    required this.password,
  });
}