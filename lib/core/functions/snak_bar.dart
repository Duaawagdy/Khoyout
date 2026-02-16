import 'package:flutter/material.dart';

import '../theming/colors.dart';

void showSnackBar(
    {required BuildContext context,
    required String text,
    Color? color,
    TextStyle? style}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      content: Center(
        child: Text(
          text,
          style: style,
        ),
      ),
      backgroundColor: color ?? ColorsManager.kPrimaryColor,
    ),
  );
}
