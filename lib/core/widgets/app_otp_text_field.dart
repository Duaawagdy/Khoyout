// otp_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theming/styles.dart';

import '../theming/colors.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onBackspacePressed; // 👈 add this

  const OtpInputField({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.validator,
    this.onChanged,
    this.onBackspacePressed, // 👈 add this
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      width: 61.w,
      child: RawKeyboardListener( // 👈 wrap with this
        focusNode: FocusNode(),
        onKey: (event) {
          if (event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              controller.text.isEmpty) {
            onBackspacePressed?.call(); // 👈 fire only when field is already empty
          }
        },
        child: TextFormField(
          validator: validator,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: controller,
          focusNode: focusNode,
          style: TextStyles.font20WhiteMedium.copyWith(color: Color(0xff922F34)),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],

          decoration: InputDecoration(

            filled: true,
            fillColor: Color(0xffFFF9F0),
            enabledBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xff922F34),
              ),
            ),
            focusedBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: ColorsManager.darkBlue,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 40,
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}