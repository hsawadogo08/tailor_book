// ignore_for_file: unused_local_variable, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:tailor_book/constants/color.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    Future<UserCredential> signInWithGoogle() async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

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
              onPressed: () {},
            ),
            SocialLoginButton(
              mode: SocialLoginButtonMode.single,
              text: '',
              height: 52,
              buttonType: SocialLoginButtonType.google,
              onPressed: () async {
                await GoogleSignIn().signIn();
              },
            ),
            SocialLoginButton(
              mode: SocialLoginButtonMode.single,
              text: '',
              height: 52,
              buttonType: SocialLoginButtonType.twitter,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
