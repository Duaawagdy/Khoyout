import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/networking/dio_factory.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/font_weight.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/show_dialog_error.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/generated/l10n.dart';

class VerifyRegStateUi extends StatelessWidget {
  const VerifyRegStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerifySignUpLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          );
        } else if (state is VerifySignUpSuccess) {
          CashHelper.setStringSecured(key: Keys.guestMode, value:'');
          context.pop();
          DioFactory.setTokenIntoHeaderAfterLogin(state.signUpResponse.token!);
          CashHelper.setStringSecured(key: Keys.token, value:state.signUpResponse.token!);
          // context.pushNamed(
          //   Routes.verifyCode,
          // );
          context.pushNamedAndRemoveUntil(
            Routes.navigationBar,
            arguments: 0,
            predicate: (Route<dynamic> route) => false,
          );
          _showErrorBottomSheet(context, '');
        } else if (state is SignUpFailure) {
          context.pop(); // Close loading dialog
          ShowDialogError.showErrorDialog(
              context, S.of(context).error, S.of(context).otpisnotright);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showErrorBottomSheet(BuildContext context, String message) {
    showModalBottomSheet(
      backgroundColor: Color(0xffFAFAFA),
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),

          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              Image.asset('assets/login-succes.png'),
              verticalSpace(40),
              SizedBox(
                width: 275.w,
                child: Text(
                  textAlign: TextAlign.center,
                  'Your account has been successfully created.',
                  style: TextStyles.font20BlackMedium
                      .copyWith(fontWeight: FontWeightHelper.bold),
                ),
              ),
              verticalSpace(8),
              SizedBox(
                width: 293.w,
                child: Text(
                  textAlign: TextAlign.center,
                  'Discover elegant scarves crafted with premium quality.',
                  style: TextStyles.font14BlackRegular,
                ),
              ),
              verticalSpace(48),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                child: AppTextButton(
                  buttonText: 'Start Shopping',
                  textStyle: TextStyles.font16BoldWhite,
                  onPressed: () {
                    //context.pop();
          
                    },
                  buttonWidth: 343,
                  buttonHeight: 43.h,
                  borderRadius: 8.r,
                ),
              ),
              verticalSpace(16)
            ],
          ),
        );
      },
    );
  }
}
