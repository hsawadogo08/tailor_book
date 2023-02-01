import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/bloc/user.bloc.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/password.model.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_form_field.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';
import 'package:tailor_book/widgets/shared/toast.dart';

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPasswordCtrl = TextEditingController();
    final newPasswordCtrl = TextEditingController();
    final confirmPasswordCtrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Modifier mon mot de passe",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            icon: Icons.lock,
            hint: "Entrez le mot de passe actuel",
            obscureText: true,
            controller: currentPasswordCtrl,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            icon: Icons.lock,
            hint: "Entrez le nouveau mot de passe",
            obscureText: true,
            controller: newPasswordCtrl,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            icon: Icons.lock,
            hint: "Confirmez le nouveau mot de passe",
            obscureText: true,
            controller: confirmPasswordCtrl,
            keyboardType: TextInputType.text,
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: BlocConsumer<UserBloc, UserStates>(
          listener: (context, state) {
            if (state is UserErrorState) {
              showToast(context, state.errorMessage, "error");
            } else if (state is UpdatePasswordSuccessState) {
              showToast(context, state.successMessage, "success");
              onGoBack(context);
            }
          },
          builder: (builderContext, state) {
            if (state is UserLoadingState) {
              return const LoadingSpinner();
            }
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: CustomButton(
                buttonText: "Enregistrer",
                buttonColor: primaryColor,
                btnTextColor: kWhite,
                buttonFonction: () {
                  Password password = Password();
                  password.currentPassword = currentPasswordCtrl.text;
                  password.newPassword = newPasswordCtrl.text;
                  password.confirmNewPassword = confirmPasswordCtrl.text;
                  builderContext.read<UserBloc>().add(
                        UpdatePasswordEvent(
                          password: password,
                        ),
                      );
                },
              ),
            );
          },
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
      },
    );
  }

  void onGoBack(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.pop(context, true);
      },
    );
  }
}
