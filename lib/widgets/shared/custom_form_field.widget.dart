// ignore_for_file: no_logic_in_create_state, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';

class CustomFormField extends StatefulWidget {
  final IconData icon;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool required;
  const CustomFormField({
    super.key,
    required this.icon,
    required this.hint,
    required this.obscureText,
    required this.controller,
    required this.keyboardType,
    this.required = false,
  });

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState(
        icon: icon,
        hint: hint,
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        required: required,
      );
}

class _CustomFormFieldState extends State<CustomFormField> {
  final IconData icon;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  late bool showObscureText = false;
  late Color borderColor = required ? kRed : primaryColor;
  final bool required;
  _CustomFormFieldState({
    required this.icon,
    required this.hint,
    required this.obscureText,
    required this.controller,
    required this.keyboardType,
    required this.required,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9),
                bottomLeft: Radius.circular(9),
              ),
              color: primaryColor,
            ),
            child: Center(
              child: Icon(
                icon,
                color: kWhite,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.montserrat(
                fontSize: 20,
                color: primaryColor,
              ),
              onChanged: (value) {
                if (required && value.isEmpty) {
                  setState(() {
                    borderColor = kRed;
                  });
                } else {
                  setState(() {
                    borderColor = primaryColor;
                  });
                }
              },
              obscureText: obscureText ? !showObscureText : showObscureText,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                suffixIcon: obscureText
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: GestureDetector(
                          onTap: _onChangeObscureTextStatus,
                          child: Icon(
                            showObscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: primaryColor,
                          ),
                        ),
                      )
                    : null,
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onChangeObscureTextStatus() {
    setState(() {
      showObscureText = !showObscureText;
    });
  }
}
