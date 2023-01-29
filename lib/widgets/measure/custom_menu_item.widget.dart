import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomMenuItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final Color color;
  final VoidCallback onPressed;
  const CustomMenuItem({
    super.key,
    required this.icon,
    required this.name,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          name,
          style: GoogleFonts.montserrat(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
