import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/features/auth/ui/widgets/auth_input.dart';
import 'package:khouyot/features/forget_password/logic/forget_password_cubit.dart';
import 'package:khouyot/features/forget_password/ui/widgets/send_email_state_ui.dart';

import '../../../core/theming/colors.dart';
import '../../../core/theming/font_weight.dart';
import '../../../core/theming/styles.dart';
import '../../../core/utils/assets.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../generated/l10n.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
              child: SingleChildScrollView(
                child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 18.w, top: 20.h),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 20.sp,
                          color: Colors.white,
                        )),
                  ),
                ),
                verticalSpace(86),
                Image.asset("assets/logo.png",width: 150.w,),
                verticalSpace(12),
                Text(
                  S.of(context).ForgotPassword,
                  style: TextStyles.font24BlackBold.copyWith(color: Colors.white),
                ),
                verticalSpace(8),
                Text(
                  S.of(context).EnteryourEmail,
                  style: TextStyles.font16WhiteRegular.copyWith(fontSize: 12.sp),
                ),
                verticalSpace(140),
                ForgetPasswordContainer(),
                            ],
                          ),
              ))
        ],
      ),
    );
  }
}

class ForgetPasswordContainer extends StatefulWidget {
  const ForgetPasswordContainer({
    super.key,
  });

  @override
  State<ForgetPasswordContainer> createState() => _ForgetPasswordContainerState();
}

class _ForgetPasswordContainerState extends State<ForgetPasswordContainer> {
  TextEditingController emailController=TextEditingController();
  final formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthInput(
                  title: S.of(context).Email,
                  controller: emailController,
                  hintText: S.of(context).EnteryourEmail,
                  prefixIcon: AssetsData.email),
              verticalSpace(87),
              AppTextButton(
                buttonText: S.of(context).Continue,
                textStyle: TextStyles.font16BoldWhite
                    ,
                onPressed: () {
                  if(formKey.currentState!.validate()) {
                    ForgetPasswordCubit.get(context).forgetPassword(emailController.text);
                  }
                },
                buttonWidth: 339,
                buttonHeight: 43.h,
                backgroundColor: ColorsManager.kPrimaryColor,
                borderRadius: 8.r,
              ), verticalSpace(14),AppTextButton(
                buttonText: S.of(context).Cancel,
                textStyle: TextStyles.font16BoldWhite
                    .copyWith(color: Color(0xff011213)),
                onPressed: () {
                  context.pop();
                },
                buttonWidth: 339,
                borderColor: Color(0x33000000),
                buttonHeight: 43.h,
                backgroundColor: Colors.transparent,
                borderRadius: 8.r,
              ),
                  verticalSpace(80),
              SendEmailStateUi()
            ],
          ),
        ),
      ),
    );
  }
}
