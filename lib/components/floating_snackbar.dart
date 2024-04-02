import 'package:flutter/material.dart';

class FabricSnackbar {
  static void floatingSnackBar({
    required Widget content,
    required BuildContext context,
    Duration? duration,
    TextStyle? textStyle,
    Color? textColor,
    Color? backgroundColor,
  }) {
    var snack = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      duration: duration ?? const Duration(milliseconds: 4000),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: content,
      backgroundColor: backgroundColor ?? Colors.black.withAlpha(200),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
