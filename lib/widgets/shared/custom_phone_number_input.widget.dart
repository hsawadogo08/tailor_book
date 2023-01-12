// ignore_for_file: no_logic_in_create_state, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tailor_book/constants/color.dart';

class CustomPhoneNumberInput extends StatefulWidget {
  final IconData icon;
  final String hint;
  final TextEditingController? normalPhoneNumberController;
  final TextEditingController? formatPhoneNumberController;
  final bool required;
  const CustomPhoneNumberInput({
    super.key,
    required this.icon,
    required this.hint,
    this.normalPhoneNumberController,
    this.formatPhoneNumberController,
    this.required = false,
  });

  @override
  _CustomPhoneNumberInputState createState() => _CustomPhoneNumberInputState(
        icon: icon,
        hint: hint,
        normalPhoneNumberController: normalPhoneNumberController,
        formatPhoneNumberController: formatPhoneNumberController,
        required: required,
      );
}

class _CustomPhoneNumberInputState extends State<CustomPhoneNumberInput> {
  final IconData icon;
  final String hint;
  final TextEditingController? normalPhoneNumberController;
  final TextEditingController? formatPhoneNumberController;
  late Color borderColor = required ? kRed : primaryColor;
  final bool required;

  String initialCountry = 'BF';
  String initialDialCode = '+226';
  late PhoneNumber currentNumber;

  _CustomPhoneNumberInputState({
    required this.icon,
    required this.hint,
    this.normalPhoneNumberController,
    this.formatPhoneNumberController,
    required this.required,
  });

  @override
  void initState() {
    super.initState();
    currentNumber = PhoneNumber(
      isoCode: initialCountry,
      dialCode: initialDialCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          normalPhoneNumberController?.text = "${number.phoneNumber}";
        },
        onFieldSubmitted: (String value) {
          formatPhoneNumberController?.text = value;
        },
        onInputValidated: (bool value) {},
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          trailingSpace: false,
        ),
        ignoreBlank: false,
        spaceBetweenSelectorAndTextField: 0,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          color: primaryColor,
        ),
        cursorColor: kRed,
        textStyle: GoogleFonts.montserrat(
          fontSize: 20,
          color: primaryColor,
        ),
        initialValue: currentNumber,
        textFieldController: formatPhoneNumberController,
        formatInput: true,
        keyboardType: const TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        inputDecoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 16,
            color: primaryColor,
          ),
        ),
        searchBoxDecoration: InputDecoration(
          hintText: 'Rechercher par code ou par nom ...',
          hintStyle: GoogleFonts.montserrat(
            fontSize: 16,
            color: primaryColor,
          ),
        ),
        onSaved: (PhoneNumber number) {},
      ),
    );
  }
}
