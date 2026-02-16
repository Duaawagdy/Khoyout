import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key, required this.onTap, required this.iconContent});
  final VoidCallback onTap;
  final IconData iconContent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          //margin: EdgeInsets.symmetric(horizontal: 8.w),
          padding: const EdgeInsets.all(8),
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            border: Border.all(
              color: ColorsManager.grey,
              width: 1.5,
            ),
          ),
          child: Icon(
            iconContent,
            color: ColorsManager.darkBlack,
          ),
        ),
      );
  }
}