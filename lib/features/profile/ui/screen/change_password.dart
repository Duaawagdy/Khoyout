import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/features/favourites/ui/screen/favourite_screen.dart';
import 'package:khouyot/features/profile/data/model/change_password_model.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';

import '../../../../generated/l10n.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextButton(
                buttonText: S.of(context).Cancel,
                buttonWidth: 118,
                backgroundColor: Colors.white,
                borderColor: Color(0xffE5E7EB),
                borderRadius: 8.r,
                textStyle: TextStyles.font36BlackBold.copyWith(fontSize: 18.sp),
                onPressed: () {
                  context.pop();
                }),
            AppTextButton(
                buttonText: S.of(context).UPdatePassword,
                buttonWidth: 209,
                borderColor: Color(0xffE5E7EB),
                borderRadius: 8.r,
                textStyle: TextStyles.font16BoldWhite,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ProfileCubit.get(context).ChangePassword(ChangePasswordModel(
                      currentPassword: passwordController.text,
                      newPassword: newPasswordController.text,
                      newPasswordConfirmation: confirmPasswordController.text));
                  }

                })
          ],
        ),
      ),
      backgroundColor: Color(0xffFAFAFA),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.h),
          children: [
            CustomAppBarScreen(title: S.of(context).ChangePassword),
            verticalSpace(26),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).CurrentPassword,
                    style: TextStyles.font16BlackRegular,
                  ),
                  verticalSpace(8),
                  AppTextFormField(
                    hintText: '',
                    borderRadius: 8.r,
                    backgroundColor: Colors.white,
                    controller: passwordController,
                    hintStyle: TextStyles.font16BlackRegular,
                  ),
                  verticalSpace(33),
                  Text(
                    S.of(context).newPassword,
                    style: TextStyles.font16BlackRegular,
                  ),
                  verticalSpace(8),
                  AppTextFormField(
                    hintText: '',
                    borderRadius: 8.r,
                    backgroundColor: Colors.white,
                    controller: newPasswordController,
                    hintStyle: TextStyles.font16BlackRegular,
                    validator: (value) {

                      if (value!.length < 6) {
                        return S.of(context).PasswordTooShort;
                      }
                      return null;
                    },
                  ),
                  verticalSpace(33),
                  Text(
                    S.of(context).ConfirmNewPassword,
                    style: TextStyles.font16BlackRegular,
                  ),
                  verticalSpace(8),
                  AppTextFormField(
                    hintText: '',
                    borderRadius: 8.r,
                    backgroundColor: Colors.white,
                    controller: confirmPasswordController,
                    hintStyle: TextStyles.font16BlackRegular,
                    validator: (value) {
                      if (value != newPasswordController.text) {
                        return S.of(context).PasswordNotMatched;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
