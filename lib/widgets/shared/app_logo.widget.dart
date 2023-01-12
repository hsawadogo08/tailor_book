import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;
  const AppLogo({
    super.key,
    this.width = 256,
    this.height = 256,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/tailor_book_logo.png",
      width: width,
      height: height,
    );
  }
}
