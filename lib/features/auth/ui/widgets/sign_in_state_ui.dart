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

import '../../../nav_bar/logic/nav_bar_cubit.dart';
class SignInStateUi extends StatelessWidget {
  const SignInStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const PopScope(
              canPop: false,
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.kPrimaryColor,
                ),
              ),
            ),
          );
        } else if (state is SignInSuccess) {
          CashHelper.setStringSecured(key: Keys.guestMode, value:'');
          context.pop(); // Close loading dialog
          DioFactory.setTokenIntoHeaderAfterLogin(state.signInResponse.token!);
          print(state.signInResponse.token!);
          //NavBarCubit.get(context).changeIndex(0,jumping: false);
          context.pushNamedAndRemoveUntil(
            Routes.navigationBar,
            arguments: 0,
            predicate: (Route<dynamic> route) => false,
          );
        } else if (state is SignInFailure) {
         context.pop(); // Ensure loading dialog is closed
          ShowDialogError.showErrorDialog(context, S.of(context).error, state.error.message!);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
