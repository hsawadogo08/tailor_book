// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool readOnly;
  const CustomTextField({
    super.key,
    required this.hint,
    required this.keyboardType,
    required this.controller,
    this.readOnly = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState(
        hint: hint,
        keyboardType: keyboardType,
        controller: controller,
      );
}

class _CustomTextFieldState extends State<CustomTextField> {
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController controller;

  _CustomTextFieldState({
    required this.hint,
    required this.keyboardType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: widget.readOnly,
        style: GoogleFonts.montserrat(
          fontSize: 20,
          color: primaryColor,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: kWhite,
          focusColor: primaryColor,
          floatingLabelStyle: GoogleFonts.montserrat(
            fontSize: 20,
            color: primaryColor,
            fontWeight: FontWeight.w700,
          ),
          labelStyle: GoogleFonts.montserrat(
            fontSize: 16,
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14,
            color: primaryColor,
            fontWeight: FontWeight.w300,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: primaryColor,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: hint,
        ),
      ),
    );
  }
}
