import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/features/auth/data/models/sign_in_model.dart';
import 'package:khouyot/features/auth/ui/widgets/sign_in_state_ui.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/font_weight.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../generated/l10n.dart';
import '../../logic/auth_cubit.dart';
import 'auth_input.dart';

class LoginColumn extends StatefulWidget {
  const LoginColumn({
    super.key,
  });

  @override
  State<LoginColumn> createState() => _LoginColumnState();
}

class _LoginColumnState extends State<LoginColumn> {
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
mainAxisSize: MainAxisSize.max,
      children: [
        AuthInput(
          title: S.of(context).Email,
          controller: emailController,
          hintText: S.of(context).EnteryourEmail,
          prefixIcon: AssetsData.email,
        ),
        verticalSpace(12),
        AuthInput(
          title: S.of(context).Password,
          hintText: S.of(context).Enteryourpassword,
          controller: passwordController,
          obscureText: AuthCubit.get(context).showPassword,
          prefixIcon: AssetsData.lockIcon,
          lastIcon: Icon(AuthCubit.get(context).showPassword?Icons.visibility_off_outlined:Icons.visibility_outlined,color: Colors.black,),
          onTap: (){AuthCubit.get(context).changePasswordVisibility();},
        ),
        verticalSpace(8),
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: GestureDetector(
            onTap: (){
              context.pushNamed(Routes.forgotPasswordScreen);
            },
            child: Text(
              S.of(context).ForgotPassword,
              style: TextStyles.font14BlackRegular
                  .copyWith(color: ColorsManager.kPrimaryColor,decoration: TextDecoration.underline),
            ),
          ),
        ),
        verticalSpace(12),
        Center(
          child: AppTextButton(
            buttonText: S.of(context).Login,
            textStyle: TextStyles.font18WhiteMedium
                .copyWith(fontWeight: FontWeightHelper.bold),
            onPressed: () {
              AuthCubit.get(context).signIn(SignInModel(email: emailController.text, password: passwordController.text));
            },
            buttonWidth: 339,
            buttonHeight: 48.h,
            backgroundColor: ColorsManager.kPrimaryColor,
            borderRadius: 8.r,
          ),
        ),
   verticalSpace(200),
        SignInStateUi()
      ],
    );
  }
}
