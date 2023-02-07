import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/bloc/personnel/personnel.bloc.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/personnel.model.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_text_field.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';
import 'package:tailor_book/widgets/shared/toast.dart';

class AddPersonnelPage extends StatefulWidget {
  final Personnel? personnel;
  const AddPersonnelPage({
    super.key,
    this.personnel,
  });

  @override
  State<AddPersonnelPage> createState() => _AddPersonnelPageState();
}

class _AddPersonnelPageState extends State<AddPersonnelPage> {
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  late Personnel personnel;

  @override
  void initState() {
    super.initState();
    if (widget.personnel != null) {
      lastNameCtrl.text = widget.personnel!.lastName!;
      firstNameCtrl.text = widget.personnel!.firstName!;
      phoneCtrl.text = widget.personnel!.phoneNumber!;
      personnel = widget.personnel!;
      log("${personnel.id}");
    } else {
      personnel = Personnel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Nouveau personnel",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          children: [
            CustomTextField(
              hint: "Nom",
              keyboardType: TextInputType.text,
              controller: lastNameCtrl,
            ),
            CustomTextField(
              hint: "Prénom",
              keyboardType: TextInputType.text,
              controller: firstNameCtrl,
            ),
            CustomTextField(
              hint: "Téléphone",
              keyboardType: TextInputType.phone,
              controller: phoneCtrl,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: BlocBuilder<PersonnelBloc, PersonnelStates>(
          builder: (builderContext, state) {
            log("$state");
            if (state is PersonnelLoadingState) {
              log("OK");
              return const LoadingSpinner();
            } else if (state is PersonnelErrorState) {
              showToast(builderContext, state.errorMessage, "error");
            } else if (state is SavePersonnelSuccessState) {
              showToast(builderContext, state.successMessage, "success");
            }
            return CustomButton(
              buttonText: "Enregistrer",
              buttonColor: primaryColor,
              borderColor: primaryColor,
              btnTextColor: kWhite,
              buttonSize: 18,
              buttonFonction: () {
                personnel.lastName = lastNameCtrl.text;
                personnel.firstName = firstNameCtrl.text;
                personnel.phoneNumber = phoneCtrl.text;
                builderContext.read<PersonnelBloc>().add(
                      SavePersonnelEvent(personnel: personnel),
                    );
              },
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

        if (type == 'success') {
          Navigator.pop(context, true);
        }
      },
    );
  }
}
