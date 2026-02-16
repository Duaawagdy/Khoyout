import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/features/auth/data/models/sign_up_model.dart';
import 'package:khouyot/features/auth/ui/widgets/signup_state_ui.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/font_weight.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../generated/l10n.dart';
import '../../logic/auth_cubit.dart';
import 'auth_input.dart';

class SignUpColumn extends StatefulWidget {
  const SignUpColumn({
    super.key,
  });

  @override
  State<SignUpColumn> createState() => _SignUpColumnState();
}

class _SignUpColumnState extends State<SignUpColumn> {
  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthInput(
          title: S.of(context).name,
          hintText: S.of(context).Enteryourname,
          prefixIcon: AssetsData.userIcon,
          controller: nameController,
        ),
        verticalSpace(12),
        AuthInput(
          title: S.of(context).Email,
          hintText: S.of(context).EnteryourEmail,
          prefixIcon: AssetsData.email,
          controller: emailController,
        ),
        verticalSpace(12),
        AuthInput(
          title: S.of(context).Password,
          obscureText: AuthCubit.get(context).showPassword,
          hintText: S.of(context).Enteryourpassword,
          prefixIcon: AssetsData.lockIcon,
          controller: passwordController,
          onTap: (){AuthCubit.get(context).changePasswordVisibility();},
          lastIcon: Icon(AuthCubit.get(context).showPassword?Icons.visibility_off_outlined:Icons.visibility_outlined,color: Colors.black,),
        ),
        verticalSpace(12),
        AppTextButton(
          buttonText: S.of(context).SignUp,
          textStyle: TextStyles.font18WhiteMedium
              .copyWith(fontWeight: FontWeightHelper.bold),
          onPressed: () {
            print("name is ${nameController}");
AuthCubit.get(context).signUp(SignUpModel(name: nameController.text, email: emailController.text, password: passwordController.text));
          },
          buttonWidth: 339,
          buttonHeight: 48.h,
          backgroundColor: ColorsManager.kPrimaryColor,
          borderRadius: 8.r,
        ),
    verticalSpace(126),
        SignUpStateUi()
      ],
    );
  }
}
