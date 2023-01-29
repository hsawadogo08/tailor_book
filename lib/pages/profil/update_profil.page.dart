import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/bloc/signup.bloc.dart';
import 'package:tailor_book/bloc/user.bloc.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_form_field.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';

class UpdateProfilPage extends StatelessWidget {
  const UpdateProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final companyController = TextEditingController();
    final nomController = TextEditingController();
    final prenomController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Modifier mon profil",
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
            icon: Icons.home_repair_service,
            hint: "Entrez le nom de votre entreprise",
            obscureText: false,
            controller: companyController,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            icon: Icons.person,
            hint: 'Entrez votre nom',
            obscureText: false,
            controller: nomController,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            icon: Icons.person,
            hint: 'Entrez votre prénom(s)',
            obscureText: false,
            controller: prenomController,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            icon: Icons.email,
            hint: "Entrez votre email",
            obscureText: false,
            controller: companyController,
            keyboardType: TextInputType.text,
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: BlocBuilder<UserBloc, UserStates>(
          builder: (builderContext, state) {
            if (state is UserInitialState) {
              return const LoadingSpinner();
            } else if (state is UserErrorState) {
              // showToast(builderContext, state.errorMessage, "error");
            } else if (state is SignUpSuccessState) {
              // showToast(builderContext, state.successMessage, "success");
              // onNavigateToHomePage(context);
            }
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: CustomButton(
                buttonText: "Enregistrer",
                buttonSize: 16,
                buttonColor: primaryColor,
                btnTextColor: kWhite,
                buttonFonction: () {
                  // onPushEvent(builderContext);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
