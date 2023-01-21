import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';

class AddPhotoButton extends StatelessWidget {
  final String title;
  final VoidCallback function;
  const AddPhotoButton({
    super.key,
    required this.title,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryColor, width: 2),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.add,
              size: 35,
              color: primaryColor,
            ),
            Text(
              title,
              style: GoogleFonts.exo2(
                color: primaryColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
