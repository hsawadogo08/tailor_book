// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';

import 'package:dynamic_form/dynamic_form.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tailor_book/bloc/dynamic_form.bloc.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/customer.model.dart';
import 'package:tailor_book/models/measurement.model.dart';
import 'package:tailor_book/pages/add_photo.page.dart';
import 'package:tailor_book/pages/confirm_add_measure.page.dart';
import 'package:tailor_book/widgets/shared/add_photo_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_calendar.widget.dart';
import 'package:tailor_book/widgets/shared/custom_select_field.widget.dart';
import 'package:tailor_book/widgets/shared/custom_text_field.widget.dart';
import 'package:tailor_book/widgets/shared/dynamic_form.widget.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';
import 'package:tailor_book/widgets/shared/toast.dart';

class AddMeasure extends StatefulWidget {
  const AddMeasure({super.key});

  @override
  State<AddMeasure> createState() => _AddMeasureState();
}

class _AddMeasureState extends State<AddMeasure> {
  List<String> typeTenues = [
    "Robe",
    "Chemise",
    "Pantalon",
    "Culotte",
    "Complet",
  ];
  List<Map<String, dynamic>> fields = [];
  int _currentStep = 0;
  Measurement measurement = Measurement();

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final totalPriceCtrl = TextEditingController();
  final advancedPriceCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final typeTenueCtrl = TextEditingController();
  final formController = FormController();

  @override
  void initState() {
    measurement.customer = Customer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Nouvelle mesure",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: stepperButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              elevation: 0,
              controlsBuilder: (context, details) {
                return Container();
              },
              currentStep: _currentStep,
              steps: [
                Step(
                  title: Text(
                    "Client",
                    style: GoogleFonts.exo2(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  content: customerStep(),
                  isActive: _currentStep == 0 ? true : false,
                  state: _currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: Text(
                    "Mesure",
                    style: GoogleFonts.exo2(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  content: measureStep(),
                  isActive: _currentStep == 1 ? true : false,
                  state: _currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: Text(
                    "Prix",
                    style: GoogleFonts.exo2(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  content: priceStep(),
                  isActive: _currentStep == 2 ? true : false,
                  state: _currentStep >= 3
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // *****START STEPPERS BUTTONS**** //
  Widget stepperButton() {
    double width = MediaQuery.of(context).size.width;
    if (_currentStep == 0) {
      return CustomButton(
        buttonText: "Continuer",
        buttonColor: primaryColor,
        borderColor: primaryColor,
        btnTextColor: kWhite,
        buttonSize: 18,
        buttonFonction: getCustomerInfos,
      );
    } else if (_currentStep == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: (width / 5) * 2,
            child: CustomButton(
              buttonText: "Précédent",
              buttonSize: 16,
              pH: 24,
              buttonColor: secondaryColor,
              borderColor: secondaryColor,
              btnTextColor: kWhite,
              buttonFonction: () {
                setState(() {
                  _currentStep--;
                });
              },
            ),
          ),
          SizedBox(
            width: (width / 5) * 2,
            child: CustomButton(
              buttonText: "Suivant",
              buttonSize: 16,
              pH: 24,
              buttonColor: primaryColor,
              btnTextColor: kWhite,
              buttonFonction: getMeasureInfos,
            ),
          ),
        ],
      );
    } else if (_currentStep == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: (width / 5) * 2,
            child: CustomButton(
              buttonText: "Précédent",
              buttonSize: 16,
              pH: 24,
              buttonColor: secondaryColor,
              borderColor: secondaryColor,
              btnTextColor: kWhite,
              buttonFonction: () {
                setState(() {
                  _currentStep--;
                });
              },
            ),
          ),
          SizedBox(
            width: (width / 5) * 2,
            child: CustomButton(
              buttonText: "Terminer",
              buttonSize: 16,
              pH: 24,
              buttonColor: primaryColor,
              btnTextColor: kWhite,
              buttonFonction: getPriceInfos,
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  // *****END STEPPERS BUTTONS**** //

  Widget customerStep() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // const SizedBox(height: 16),
          CustomTextField(
            hint: "Nom du client",
            keyboardType: TextInputType.text,
            controller: lastNameCtrl,
          ),
          CustomTextField(
            hint: "Prénom du client",
            keyboardType: TextInputType.text,
            controller: firstNameCtrl,
          ),
          CustomTextField(
            hint: "Téléphone du client",
            keyboardType: TextInputType.phone,
            controller: phoneCtrl,
          ),
        ],
      ),
    );
  }

  Widget measureStep() {
    return BlocBuilder<DynamicFormBloc, DynamicStates>(
        builder: (builderContext, state) {
      if (state is DynamicLoadingState) {
        return const LoadingSpinner();
      } else if (state is DynamicSuccessState) {
        fields = state.fields;
        return Column(
          children: [
            CustomSelectField(
              title: "Type de tenue",
              placeholder: "Choisir le type de tenue",
              items: typeTenues,
              controller: typeTenueCtrl,
              selectedValue: typeTenueCtrl.text,
              function: () {
                builderContext.read<DynamicFormBloc>().add(
                      DynamicFormEvent(
                        docId: typeTenueCtrl.text,
                      ),
                    );
              },
            ),
            DynamicForm(
              formController: formController,
              fields: state.fields,
            ),
          ],
        );
      }

      return Column(
        children: [
          CustomSelectField(
            title: "Type de tenue",
            placeholder: "Choisir le type de tenue",
            items: typeTenues,
            controller: typeTenueCtrl,
            function: () {
              builderContext.read<DynamicFormBloc>().add(
                    DynamicFormEvent(
                      docId: typeTenueCtrl.text,
                    ),
                  );
            },
          ),
        ],
      );
    });
  }

  Widget priceStep() {
    return Column(
      children: [
        // const SizedBox(height: 16),
        CustomTextField(
          hint: "Prix de la tenue",
          keyboardType: TextInputType.number,
          controller: totalPriceCtrl,
        ),
        CustomTextField(
          hint: "Montant de l'avance",
          keyboardType: TextInputType.number,
          controller: advancedPriceCtrl,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) {
                  return CustomCalendar(
                    currentDate: measurement.removedDate ?? DateTime.now(),
                  );
                },
              ),
            ).then(
              (value) {
                setState(() {
                  measurement.removedDate = value;
                });

                var newFormat = DateFormat("dd/MM/yyyy");
                String updatedDt =
                    DateFormat("dd/MM/yyyy").format(measurement.removedDate!);
                log(updatedDt);
              },
            );
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                measurement.removedDate == null
                    ? "Date du rendez vous"
                    : "Rendez-vous : ${DateFormat("dd/MM/yyyy").format(measurement.removedDate!)}",
                textAlign: TextAlign.start,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        AddPhotoButton(
          title: "Ajouter une photo du model",
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) {
                  return const AddPhoto(title: "Ajouter une photo du model");
                },
              ),
            ).then((value) {
              if (value != null) {
                setState(() {
                  measurement.photoModel = value;
                });
              }
            });
          },
        ),
        measurement.photoModel != null
            ? Container(
                height: 256,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
                child: Image.file(
                  File(measurement.photoModel!.path),
                ),
              )
            : const SizedBox.shrink(),
        AddPhotoButton(
          title: "Ajouter une photo du tissu",
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) {
                  return const AddPhoto(title: "Ajouter une photo du tissu");
                },
              ),
            ).then((value) {
              if (value != null) {
                setState(() {
                  measurement.photoTissu = value;
                });
              }
            });
          },
        ),
        measurement.photoTissu != null
            ? Container(
                height: 256,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
                child: Image.file(
                  File(measurement.photoTissu!.path),
                  height: 256,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget recapStep() {
    return Column(
      children: [],
    );
  }

  // Steppers infos
  void getCustomerInfos() {
    String firstName = firstNameCtrl.text;
    String lastName = lastNameCtrl.text;
    String phoneNumber = phoneCtrl.text;

    if (lastName == "") {
      Toast.showFlutterToast(
        context,
        "Le nom du client est obligatoire !",
        "error",
      );
    } else if (firstName == "") {
      Toast.showFlutterToast(
        context,
        "Le prénom du client est obligatoire !",
        "error",
      );
    } else {
      measurement.customer?.lastName = lastName;
      measurement.customer?.firstName = firstName;
      measurement.customer?.phoneNumber = phoneNumber;
      setState(() {
        _currentStep++;
      });
    }
  }

  void getMeasureInfos() {
    if (fields.isEmpty) {
      Toast.showFlutterToast(
        context,
        "Veuillez renseigner les mesures de la tenue !",
        "warning",
      );
    } else {
      measurement.measures = formController.getAllValuesByIds();
      measurement.model = typeTenueCtrl.text;
      setState(() {
        _currentStep++;
      });
    }
  }

  void getPriceInfos() {
    final totalPrice =
        totalPriceCtrl.text == "" ? 0 : int.parse(totalPriceCtrl.text);
    final advancedPrice =
        advancedPriceCtrl.text == "" ? 0 : int.parse(advancedPriceCtrl.text);

    if (totalPriceCtrl.text == "") {
      Toast.showFlutterToast(
        context,
        "Le prix de la tenue est obligatoire !",
        "error",
      );
    } else if (totalPrice <= 0) {
      Toast.showFlutterToast(
        context,
        "Le prix de la tenue doit être supperieure à 0 !",
        "error",
      );
    } else if (advancedPrice > totalPrice) {
      Toast.showFlutterToast(
        context,
        "Le montant de l'avance depasse le prix total de la tenue !",
        "error",
      );
    } else if (measurement.removedDate == null) {
      Toast.showFlutterToast(
        context,
        "La date du rendez-vous est obligatoire !",
        "error",
      );
    } else {
      measurement.totalPrice = totalPrice;
      measurement.advancedPrice = advancedPrice;
      measurement.createdDate = DateTime.now();
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) {
            return ConfirmAddMeasure(
              measurement: measurement,
            );
          },
        ),
      ).then(
        (value) {
          if (value == true) {
            resetStepper();
          }
        },
      );
    }
  }

  void resetStepper() {
    setState(() {
      measurement = Measurement();
      lastNameCtrl.clear();
      firstNameCtrl.clear();
      totalPriceCtrl.clear();
      advancedPriceCtrl.clear();
      dateCtrl.clear();
      phoneCtrl.clear();
      typeTenueCtrl.clear();
      formController.clearValues();
      _currentStep = 0;
    });
  }
}
