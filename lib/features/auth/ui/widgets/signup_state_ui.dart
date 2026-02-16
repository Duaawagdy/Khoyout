import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/networking/dio_factory.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/widgets/show_dialog_error.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/generated/l10n.dart';

class SignUpStateUi extends StatelessWidget {
  const SignUpStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          );
        } else if (state is SignUpSuccess) {
          //CashHelper.putBool(key: Keys.guestMode, value:false);
          context.pop();
          //DioFactory.setTokenIntoHeaderAfterLogin(state.signUpResponse.token!);
          CashHelper.putString(key: Keys.email, value:state.signUpResponse.email!);
         // NavBarCubit.get(context).changeIndex(0,jumping: false);
          context.pushNamed(
            Routes.verifyCode,
          );
          // context.pushNamedAndRemoveUntil(
          //   Routes.navigationBar,
          //   predicate: (Route<dynamic> route) => false,
          // );
        } else if (state is SignUpFailure) {
          context.pop(); // Close loading dialog
          ShowDialogError.showErrorDialog(context, S.of(context).error, state.error.message!);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
