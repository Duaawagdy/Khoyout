import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/localization/cubit/localization_cubit.dart';
import 'package:khouyot/core/routing/routes.dart';

import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

class GuestModeLanguageBar extends StatelessWidget {
  const GuestModeLanguageBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: GestureDetector(
                onTap: (){
                  CashHelper.setStringSecured(key: Keys.guestMode, value: 'guest');
                  context.pushNamed(Routes.navigationBar,arguments: 0);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.5.h, horizontal: 12.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Color(0xAFFFFFF),
                      border: Border.all(color: Color(0xAFFFFFF))),
                  child: Text(
                    S.of(context).Imguest,
                    textAlign: TextAlign.center,
                    style: TextStyles.font14SeconderyBold,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.language_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
              //horizontalSpace(8),
              DropdownMenu(
                  width: 116.w,
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'en', label: 'English'),
                    DropdownMenuEntry(value: 'ar', label: 'Arabic'),
                  ],
                  initialSelection: LocalizationCubit.get(context).locale.languageCode,
                  inputDecorationTheme:  InputDecorationTheme(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8.w, // 👈 reduce space here
                      vertical: 12.h,
                    ),
                  ),
                  onSelected: (value) {
                    LocalizationCubit.get(context).changeLocale(value ?? "en");
                  },
                  selectedTrailingIcon: Icon(Icons.keyboard_arrow_up_rounded,
                      color: Colors.white, size: 24.sp),
                  textStyle: TextStyles.font16BoldWhite,
                  trailingIcon: Icon(Icons.keyboard_arrow_down_rounded,
                      color: Colors.white, size: 24.sp))
            ],
          )
        ],
      ),
    );
  }
}
