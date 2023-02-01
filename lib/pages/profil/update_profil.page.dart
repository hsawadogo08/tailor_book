import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/bloc/user.bloc.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/utilisateur.model.dart';
import 'package:tailor_book/services/user.service.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_form_field.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';
import 'package:tailor_book/widgets/shared/toast.dart';

class UpdateProfilPage extends StatefulWidget {
  const UpdateProfilPage({super.key});

  @override
  State<UpdateProfilPage> createState() => _UpdateProfilPageState();
}

class _UpdateProfilPageState extends State<UpdateProfilPage> {
  final companyController = TextEditingController();
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  late Utilisateur currentUser;

  void _getCurrentUserInfos() async {
    currentUser = await UserService.getCurrentUserInfos();
    companyController.text = "${currentUser.companyName}";
    nomController.text = "${currentUser.lastName}";
    prenomController.text = "${currentUser.firstName}";
    emailController.text = "${currentUser.email}";
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUserInfos();
  }

  @override
  Widget build(BuildContext context) {
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
            controller: emailController,
            keyboardType: TextInputType.text,
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: BlocConsumer<UserBloc, UserStates>(
          listener: (context, state) {
            log("UPDATE STATES ==> $state");
            if (state is UserErrorState) {
              showToast(context, state.errorMessage, "error");
            } else if (state is UpdateUserSuccessState) {
              showToast(context, state.successMessage, "success");
              onGoBack(context);
            }
          },
          builder: (builderContext, state) {
            log("UPDATE builder STATES ==> $state");
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
                  log("Save");
                  currentUser.companyName = companyController.text;
                  currentUser.lastName = nomController.text;
                  currentUser.firstName = prenomController.text;
                  currentUser.email = emailController.text;
                  builderContext.read<UserBloc>().add(
                        UpdateUserInfosEvent(
                          currentUser: currentUser,
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
