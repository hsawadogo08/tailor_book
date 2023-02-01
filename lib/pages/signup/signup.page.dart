import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/pages/signup/signup_otp.page.dart';
import 'package:tailor_book/services/user.service.dart';
import 'package:tailor_book/widgets/shared/app_logo.widget.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_phone_number_input.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';
import 'package:tailor_book/widgets/shared/toast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int delayedDuration = 150;
  bool enableSpinner = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final normalPhoneNumberController = TextEditingController();
  final formatPhoneNumberController = TextEditingController();

  Future onVerifyPhoneNumber() async {
    String mobile = normalPhoneNumberController.text.trim();
    if (mobile == '') {
      Toast.showFlutterToast(
        context,
        "Veuillez renseigner le numéro de téléphone !",
        "warning",
      );
    } else {
      setState(() {
        enableSpinner = true;
      });
      bool userExist = await UserService.verifyPhoneNumber(mobile);
      if (userExist) {
        // ignore: use_build_context_synchronously
        Toast.showFlutterToast(
          context,
          "Désolé! Ce numéro de téléphone est déjà utilisé !",
          "warning",
        );
      } else {
        await validateUserPhoneNumber(mobile);
      }
    }
  }

  Future<void> validateUserPhoneNumber(String mobile) async {
    await auth.verifyPhoneNumber(
      phoneNumber: mobile,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential authCredential) async {},
      verificationFailed: (FirebaseAuthException authException) {
        setState(() {
          enableSpinner = false;
        });
        Toast.showFlutterToast(
          context,
          "Une erreur est survenue lors de la vérification du numéro de téléphone !",
          "error",
        );
      },
      codeSent: (String verificationId, [int? forceResendingToken]) {
        setState(() {
          enableSpinner = false;
        });
        onNavigateToOtpPage(mobile, verificationId, forceResendingToken);
      },
      codeAutoRetrievalTimeout: (String error) {
        setState(() {
          enableSpinner = false;
        });
        Toast.showFlutterToast(
          context,
          "Une erreur est survenue lors de la vérification du numéro de téléphone !",
          "error",
        );
      },
    );
  }

  void onNavigateToOtpPage(
      String mobile, String verificationId, int? forceResendingToken) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return SignupOtpPage(
            phoneNumber: mobile,
            verificationId: verificationId,
            forceResendingToken: forceResendingToken,
          );
        },
      ),
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
          "Inscription",
          style: GoogleFonts.exo2(
            fontSize: 20,
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
                  buttonText: "Envoyer le SMS",
                  buttonColor: primaryColor,
                  btnTextColor: kWhite,
                  buttonFonction: onVerifyPhoneNumber,
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
                      "Un code de validation sera envoyé à votre numéro de téléphone !",
                      style: GoogleFonts.exo2(
                        fontSize: 16,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delayedDuration * 5),
                  child: CustomPhoneNumberInput(
                    icon: Icons.add,
                    hint: 'Numéro de téléphone',
                    normalPhoneNumberController: normalPhoneNumberController,
                    formatPhoneNumberController: formatPhoneNumberController,
                    required: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showToast(BuildContext context, String message, String type) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Toast.showFlutterToast(
          context,
          message,
          type,
        );

        if (type == 'success') {
          Navigator.pop(context);
        }
      },
    );
  }
}
