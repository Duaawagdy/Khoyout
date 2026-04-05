import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/functions/snak_bar.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/features/forget_password/data/model/reset_password_request.dart';
import 'package:khouyot/features/forget_password/logic/forget_password_cubit.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/show_dialog_error.dart';
import '../../../../generated/l10n.dart';

class ResetPasswordStateUI extends StatelessWidget {
  const ResetPasswordStateUI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          );
        } else if (state is ResetPasswordSuccess) {
          //CashHelper.putBool(key: Keys.guestMode, value:false);
          context.pop();
          showSnackBar(context: context, text: S.of(context).passwordResetSuccessfully);
          //DioFactory.setTokenIntoHeaderAfterLogin(state.signUpResponse.token!);
          // NavBarCubit.get(context).changeIndex(0,jumping: false);
          context.pushNamedAndRemoveUntil(Routes.signUpScreen,

              predicate: (Route<dynamic> route) {
            return false;
          });
          // context.pushNamedAndRemoveUntil(
          //   Routes.navigationBar,
          //   predicate: (Route<dynamic> route) => false,
          // );
        } else if (state is ForgetPasswordFailure) {
          context.pop(); // Close loading dialog
          ShowDialogError.showErrorDialog(
              context, S.of(context).error, state.error.message!);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
