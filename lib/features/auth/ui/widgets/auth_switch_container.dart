import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

class AuthSwitchContainer extends StatelessWidget {
  const AuthSwitchContainer({
    super.key, required this.onSwitch, required this.isLogin,
  });
  final bool isLogin;
final Function() onSwitch;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      padding: EdgeInsets.symmetric(horizontal: 7.w,vertical: 8.h),
      decoration: BoxDecoration(borderRadius:BorderRadius.circular(40.r),color: Colors.white10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(

            onTap: onSwitch,
            child: AnimatedContainer(
                width:162.w,
                padding: EdgeInsets.symmetric(
                    vertical: 12.h,),
                decoration: BoxDecoration(
                    color: isLogin?Colors.transparent:Colors.white10,
                    borderRadius: BorderRadius.circular(40.r)),
                duration: Duration(milliseconds: 300),
                child: Text(
                  textAlign: TextAlign.center,
                  S.of(context).SignUp,
                  style: TextStyles.font16BoldWhite,
                )),
          ),
          GestureDetector(
            onTap: onSwitch,
            child: AnimatedContainer(
                width:162.w,
              duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(
                    vertical: 12.h),
                decoration: BoxDecoration(
                    color: isLogin?Colors.white10:Colors.transparent,
                    borderRadius: BorderRadius.circular(40.r)),
                child: Text(
                  textAlign: TextAlign.center,
                 S.of(context).Login,
                  style: TextStyles.font16BoldWhite,
                )),
          )
        ],
      ),
    );
  }
}
