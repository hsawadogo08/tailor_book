// ignore_for_file: no_logic_in_create_state, use_build_context_synchronously

import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/pages/signup/signup_complete.dart';
import 'package:tailor_book/widgets/shared/app_logo.widget.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';
import 'package:tailor_book/widgets/shared/toast.dart';

class SignupOtpPage extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final int? forceResendingToken;
  const SignupOtpPage({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    required this.forceResendingToken,
  });

  @override
  State<SignupOtpPage> createState() => _SignupOtpPageState(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        forceResendingToken: forceResendingToken,
      );
}

class _SignupOtpPageState extends State<SignupOtpPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final String phoneNumber;
  final String verificationId;
  final int? forceResendingToken;
  int delayedDuration = 150;
  bool enableSpinner = false;
  late int? _forceResendingToken;

  _SignupOtpPageState({
    required this.phoneNumber,
    required this.verificationId,
    required this.forceResendingToken,
  });

  @override
  void initState() {
    _forceResendingToken = forceResendingToken;
    super.initState();
  }

  Future<void> resendSms() async {
    setState(() {
      enableSpinner = true;
    });
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: _forceResendingToken,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential authCredential) async {},
      verificationFailed: (FirebaseAuthException authException) {
        setState(() {
          enableSpinner = false;
        });
        Toast.showFlutterToast(
          context,
          "Une erreur est survenue lors de l'envoi du code de validation !",
          "error",
        );
      },
      codeSent: (String verificationId, [int? forceResendingToken]) {
        setState(() {
          _forceResendingToken = forceResendingToken;
          enableSpinner = false;
        });
      },
      codeAutoRetrievalTimeout: (String error) {
        setState(() {
          enableSpinner = false;
        });
        Toast.showFlutterToast(
          context,
          "Une erreur est survenue lors de l'envoi du code de validation !",
          "error",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          textAlign: TextAlign.center,
          "Vérification",
          style: GoogleFonts.exo2(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: kWhite,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: enableSpinner
            ? const LoadingSpinner()
            : Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: CustomButton(
                  buttonText: "Continuer",
                  buttonColor: primaryColor,
                  btnTextColor: kWhite,
                  buttonFonction: () {},
                ),
              ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delayedDuration),
                  child: const AppLogo(
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delayedDuration * 2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Un code de validation a été envoyé à ce numéro de téléphone !",
                      style: GoogleFonts.exo2(
                        fontSize: 16,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delayedDuration * 3),
                  child: OtpTextField(
                    numberOfFields: 6,
                    // fieldWidth: 45,
                    borderColor: primaryColor,
                    enabledBorderColor: primaryColor,
                    focusedBorderColor: secondaryColor,
                    borderWidth: 2.0,
                    textStyle: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    showFieldAsBox: true,
                    autoFocus: true,
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    onSubmit: (String verificationCode) async {
                      // Create a PhoneAuthCredential with the code
                      setState(() {
                        enableSpinner = true;
                      });
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: verificationCode,
                      );

                      // Sign the user in (or link) with the credential
                      UserCredential userCredential =
                          await auth.signInWithCredential(credential);
                      setState(() {
                        enableSpinner = false;
                      });

                      if (userCredential.user?.uid == null) {
                        Toast.showFlutterToast(
                          context,
                          "Une erreur est survenue lors de la vérification du code de validation !",
                          "error",
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return SignupCompletePage(
                                phoneNumber: phoneNumber,
                                // userUID: userCredential.user!.uid,
                                userUID: phoneNumber,
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delayedDuration * 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous n'avez pas reçu le code ?",
                        style: GoogleFonts.montserrat(
                          color: primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: resendSms,
                        child: Text(
                          "Renvoyer",
                          style: GoogleFonts.montserrat(
                            color: secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
