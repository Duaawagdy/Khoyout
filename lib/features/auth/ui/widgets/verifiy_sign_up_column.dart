import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/localization/cubit/localization_cubit.dart';
import 'package:khouyot/core/theming/font_weight.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/features/auth/data/models/otp_model.dart';

import '../../../../core/db/cash_helper.dart';
import '../../../../core/widgets/app_otp_text_field.dart';
import '../../../../generated/l10n.dart';
import '../../logic/auth_cubit.dart';

class VerifySignUpColumn extends StatefulWidget {
  const VerifySignUpColumn({super.key});

  @override
  State<VerifySignUpColumn> createState() => _VerifySignUpColumnState();
}

class _VerifySignUpColumnState extends State<VerifySignUpColumn> {
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
    return SizedBox(
      width: 339.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          verticalSpace(32),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 22.0.w),
            child: Text(
              S.of(context).EnterVerificationCode,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyles.font14BlackRegular.copyWith(fontSize: 24.sp),
            ),
          ),
          verticalSpace(8),
          Text(
            S.of(context).Wehavesentyouaverificationcode,
            style: TextStyles.font14BlackRegular
                .copyWith(fontSize: 13.sp, color: Color(0xff676767)),
          ),verticalSpace(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/verivy-email.png',height: 20.h,width: 20.w,),
              horizontalSpace(4),
              Text(
                CashHelper.getString(key: Keys.email) ?? '',
                style: TextStyles.font20BlackMedium.copyWith(fontSize: 12.sp),
              ),
            ],
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
                      AuthCubit.get(context).focusPreviousField(context); // 👈 go back on empty backspace
                    },
                    validator: (value) =>
                        value == null || value.isEmpty ? "!" : null,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        AuthCubit.get(context).focusPreviousField(context);
                      } else {
                        AuthCubit.get(context).focusNextField(context);
                      }
                    },
                  );
                }),
              ),
            ),
          ),
          verticalSpace(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).DontreceiveOTP,
                style: TextStyles.font16BlackRegular,
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: (){
      AuthCubit.get(context).resendSignUpcode(CashHelper.getString(key: Keys.email)!);
                },
                  child: Text(
                S.of(context).Resendcode,

                style:
                    TextStyles.font16BoldWhite.copyWith(color: Color(0xff6C2326),decoration:TextDecoration.underline),
              ))
            ],
          ),
          verticalSpace(40),
          AppTextButton(
            buttonText: S.of(context).Verify,
            textStyle: TextStyles.font20WhiteMedium
                .copyWith(fontWeight: FontWeightHelper.bold),
            onPressed: () {
      if (otpControllers[3].text!='') {
              AuthCubit.get(context).verifySignUp(OtpModel(
                  email: CashHelper.getString(key: Keys.email),
                  otp: otpControllers
                      .map((controller) => controller.text)
                      .join()));
            }},
            buttonWidth: 307,
            buttonHeight: 48.h,
            backgroundColor: Color(0xff441618),
            borderRadius: 8.r,
          ),
        ],
      ),
    );
  }
}
