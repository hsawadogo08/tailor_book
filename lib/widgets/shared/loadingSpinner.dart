// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tailor_book/constants/color.dart';

class LoadingSpinner extends StatelessWidget {
  final double size;
  final Color color;
  const LoadingSpinner({
    super.key,
    this.size = 75,
    this.color = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: SpinKitCircle(
          size: size,
          color: color,
        ),
      ),
    );
  }
}
