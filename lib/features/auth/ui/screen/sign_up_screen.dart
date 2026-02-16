import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import '../widgets/auth_switch_container.dart';
import '../widgets/guest_language_bar.dart';
import '../widgets/login_column.dart';
import '../widgets/sign_up_column.dart';
import '../widgets/welcome_Banner.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              child: ListView(
                shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              GuestModeLanguageBar(),
              verticalSpace(36),
              WelcomeTextBanner(),
              verticalSpace(24),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return AuthSwitchContainer(
                    onSwitch: () {
                      AuthCubit.get(context).changeAuthMode();
                    },
                    isLogin: AuthCubit.get(context).isLogin,
                  );
                },
              ),
              verticalSpace(24),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return AuthContainer();
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}

class AuthContainer extends StatelessWidget {
  const AuthContainer({
    super.key,
  });

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
       // height: double.maxFinite,
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(top: 16.h, left: 18.w, right: 18.w),
        decoration: BoxDecoration(
          color: Color(0xffFAFAFA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: AuthCubit.get(context).isLogin
            ? LoginColumn()
            : SignUpColumn(),
      ),
    );
  }
}


