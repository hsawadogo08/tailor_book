import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Toast {
  static void showFlutterToast(
    BuildContext context,
    String message,
    String toastType,
  ) {
    final FToast fToast = FToast().init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: _getToastBgColor(toastType),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getToastIcon(toastType),
            color: Colors.white,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.comfortaa(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }

  static Color _getToastBgColor(String toastType) {
    switch (toastType.toLowerCase()) {
      case 'error':
        return Colors.red;
      case 'warning':
        return Colors.amber;
      case 'success':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  static IconData _getToastIcon(String toastType) {
    switch (toastType.toLowerCase()) {
      case 'error':
        return Icons.close;
      case 'warning':
        return Icons.info_outline;
      case 'success':
        return Icons.check_box;
      default:
        return Icons.info_outline;
    }
  }
}
