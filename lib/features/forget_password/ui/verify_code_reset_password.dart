import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/features/forget_password/logic/forget_password_cubit.dart';
import 'package:khouyot/features/forget_password/ui/widgets/verify_otp_state_ui.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/utils/assets.dart';
import '../../../core/localization/cubit/localization_cubit.dart';
import '../../../core/theming/font_weight.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_otp_text_field.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../generated/l10n.dart';

class VerifyResetPasswordScreen extends StatelessWidget {
  const VerifyResetPasswordScreen({super.key, required this.email});
  final String email;
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
                      padding:
                          EdgeInsets.only(top: 16.h, left: 18.w, right: 18.w),
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
                          VerifyResetPasswordColumn(
                            email: email,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //VerifyRegStateUi()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VerifyResetPasswordColumn extends StatefulWidget {
  const VerifyResetPasswordColumn({
    super.key,
    required this.email,
  });
  final String email;
  @override
  State<VerifyResetPasswordColumn> createState() =>
      _VerifyResetPasswordColumnState();
}

class _VerifyResetPasswordColumnState extends State<VerifyResetPasswordColumn> {
  final formKey = GlobalKey<FormState>();

  List<TextEditingController> otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        verticalSpace(32),
        SizedBox(
          width: 289.w,
          child: Text(
            textAlign: TextAlign.center,
            S.of(context).EnterVerificationCode,
            style: TextStyles.font14BlackRegular.copyWith(fontSize: 24.sp),
          ),
        ),
        verticalSpace(8),
        Text(
          S.of(context).Wehavesentyouaverificationcode,
          style: TextStyles.font14BlackRegular
              .copyWith(fontSize: 13.sp, color: Color(0xff676767)),
        ),
        Text(
          widget.email,
          style: TextStyles.font20BlackMedium.copyWith(fontSize: 12.sp),
        ),
        verticalSpace(24),
        SizedBox(
          width: 300.w,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(otpControllers.length, (index) {
                return OtpInputField(
                  controller: otpControllers[index],

                  focusNode: focusNodes[index],
                  onBackspacePressed: () {
                    ForgetPasswordCubit.get(context).focusPreviousField(context); // 👈 go back on empty backspace
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? S.of(context).MustnotBeEmpty
                      : null,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      ForgetPasswordCubit.get(context)
                          .focusPreviousField(context);
                    } else {
                      ForgetPasswordCubit.get(context).focusNextField(context);
                    }
                  },
                );
              }),
            ),
          ),
        ),
        verticalSpace(24),
        Row(
          children: [
            Text(
              S.of(context).DontreceiveOTP,
              style: TextStyles.font16BlackRegular,
            ),
            Text(
              S.of(context).Resendcode,
              style:
                  TextStyles.font16BoldWhite.copyWith(color: Color(0xff441618)),
            )
          ],
        ),
        verticalSpace(40),
        AppTextButton(
          buttonText: S.of(context).Verify,
          textStyle: TextStyles.font20WhiteMedium
              .copyWith(fontWeight: FontWeightHelper.bold),
          onPressed: () {
            if(otpControllers[3].text!='') {
              ForgetPasswordCubit.get(context).verifyRestPasswordCode(
                widget.email,
                otpControllers.map((controller) => controller.text).join());
            }
          },
          buttonWidth: 339,
          buttonHeight: 48.h,
          backgroundColor: Color(0xff441618),
          borderRadius: 8.r,
        ),
        VerifyCodeOtpStateUi()
      ],
    );
  }
}
