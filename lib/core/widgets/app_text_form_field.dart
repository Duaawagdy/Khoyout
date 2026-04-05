import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final bool? enable;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final double? borderRadius;
  final Widget? prefexIcon;
  final TextInputType? keyboardType;
  final bool? readOnly;final bool? autofocus;
  final int? maxline;
 final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final double? width;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.validator,
    this.onTap,
    this.onFieldSubmitted,
    this.readOnly,
    this.borderRadius,
    this.prefexIcon,this.width, this.focusNode,this.maxline, this.inputFormatters, this.keyboardType, this.enable, this.autofocus,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,

      child: TextFormField(
        autofocus: autofocus??false,
        textAlignVertical: TextAlignVertical.center,
        maxLines: maxline??1,
minLines: 1,
      enabled:enable??true ,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onTap: onTap,
        readOnly: readOnly ?? false,
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.only(left: 10.w, right: 10.w, bottom: 25.h),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.kPrimaryColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(borderRadius?.r ?? 16.0.r),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.grey,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(borderRadius?.r ?? 16.0.r),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(borderRadius?.r ?? 16.0.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(borderRadius?.r ?? 16.0.r),
        ),
        hintStyle: hintStyle ?? TextStyles.font32BlueBold,
        hintText: hintText,
        suffixIcon: suffixIcon,
        // ✅ prefix sits inline with text — perfectly aligned
        prefix: prefexIcon,
        // ✅ removed prefixIconConstraints — was clipping to maxHeight:16
        fillColor: backgroundColor ?? ColorsManager.grey,
        filled: true,
      ),
        obscureText: isObscureText ?? false,
        style: hintStyle??TextStyles.font16WhiteRegular,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return "Must not be empty";
              }
              return null;
            },
      ),
    );
  }
}
