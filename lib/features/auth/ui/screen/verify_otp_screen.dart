import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/utils/assets.dart';
import '../widgets/verifiy_sign_up_column.dart';
import '../widgets/verify_reg_state_ui.dart';

class VerifySignUpScreen extends StatelessWidget{
  const VerifySignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetsData.logo), fit: BoxFit.cover)),
          ),
          SafeArea(
            child: Column(
              children: [
                verticalSpace(11),
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.only(top: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                      gradient: LinearGradient(
                        end: Alignment.topRight,
                        begin: Alignment.topLeft,
                        colors: [
                          ColorsManager.seconderyTextColor,
                          ColorsManager.lighKPrimaryColor,
                        ],
                      ),
                    ),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.only(top: 16.h, left: 18.w, right: 18.w),
                      decoration: BoxDecoration(
                        color: Color(0xffFAFAFA),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [

                          VerifySignUpColumn()
                        ],
                      ),
                    ),
                  ),
                ),
                VerifyRegStateUi()
              ],
            ),
          ),
        ],
      ),
    );
  }

}