// ignore_for_file: unused_local_variable, unused_element

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FacebookAuth facebookAuth = FacebookAuth.instance;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 2,
                  color: primaryColor,
                  child: const Center(),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "Ou avec",
                style: GoogleFonts.montserrat(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Container(
                  height: 2,
                  color: secondaryColor,
                  child: const Center(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SocialLoginButton(
              backgroundColor: primaryColor,
              mode: SocialLoginButtonMode.single,
              text: '',
              height: 52,
              buttonType: SocialLoginButtonType.facebook,
              onPressed: _onFacebookSignIn,
            ),
            SocialLoginButton(
              mode: SocialLoginButtonMode.single,
              text: '',
              height: 52,
              buttonType: SocialLoginButtonType.google,
              onPressed: signInWithGoogle,
            ),
          ],
        ),
      ],
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    bool isSigned = await GoogleSignIn().isSignedIn();
    if (isSigned) {
      await GoogleSignIn().signOut();
    }
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signIn().catchError(
      (onError) {
        log("Error $onError");
      },
    );

    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      log("accessToken ==> ${googleAuth.accessToken}");
      log("idToken ==> ${googleAuth.idToken}");
      log("ID ==> ${googleUser.id}");
      log("NAME ==> ${googleUser.displayName}");
      log("EMAIL ==> ${googleUser.email}");
      log("photoUrl ==> ${googleUser.photoUrl}");

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  _onFacebookSignIn() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    loginResult.accessToken;
    loginResult.message;
    loginResult.status;
    log("accessToken ==> ${loginResult.accessToken}");
    log("message ==> ${loginResult.message}");
    log("status ==> ${loginResult.status}");
  }

  void onGoogleSignIn() async {
    bool isSigned = await GoogleSignIn().isSignedIn();
    if (isSigned) {
      await GoogleSignIn().signOut();
    }
    try {
      GoogleSignInAccount? account = await GoogleSignIn().signIn().catchError(
        (onError) {
          log("Error $onError");
        },
      );
      var auth = await account?.authentication;
      log("idToken ==> ${auth?.idToken}");
      log("accessToken ==> ${auth?.accessToken}");
      log("id ==> ${account?.id}");
      log("displayName ==> ${account?.displayName}");
      log("email ==> ${account?.email}");
      log("photoUrl ==> ${account?.photoUrl}");
    } catch (e) {
      log("$e");
    }
  }
}
