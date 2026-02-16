import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class AuthInput extends StatelessWidget {
  const AuthInput({
    super.key,
    this.controller,
    this.validator,
    required this.title,
    required this.hintText,
    required this.prefixIcon, this.lastIcon, this.onTap, this.obscureText,
  });
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String title;
  final Widget? lastIcon;
  final bool? obscureText;
  final Function()? onTap;
  final String hintText;
  final String prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.font16WhiteRegular.copyWith(color: Colors.black),
        ),
    verticalSpace(8),
        SizedBox(
            width: 339.w,
            height: 48.h,
            child: AppTextFormField(
              isObscureText: obscureText,
              controller: controller,
              backgroundColor: Colors.white,
              suffixIcon: GestureDetector(onTap:onTap,child: lastIcon??SizedBox()),
              prefexIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
                child: Image.asset(
                  prefixIcon,
                ),
              ),
              hintText: hintText,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorsManager.kPrimaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Color(0xffE5E7EB))),
              hintStyle: TextStyles.font16WhiteRegular
                  .copyWith(color: Colors.grey[500]),
            )),
      ],
    );
  }
}
