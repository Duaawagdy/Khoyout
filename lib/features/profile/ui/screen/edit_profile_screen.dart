import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/features/favourites/ui/screen/favourite_screen.dart';
import 'package:khouyot/features/profile/data/model/profile_model.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';

import '../../../../generated/l10n.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.profileModel});
  final ProfileModel profileModel;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
              color: Colors.white,
              child: state is UpdateProfileLoading
                  ? Container(
                height: 43.h,
                     // padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                          color: ColorsManager.kPrimaryColor,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : AppTextButton(
                      buttonWidth: 339,
                      buttonText: S.of(context).save,
                      textStyle: TextStyles.font16BoldWhite,
                      onPressed: () {
                        ProfileCubit.get(context)
                            .updateProfile(nameController.text);
                      }),
            );
          },
        ),
        backgroundColor: Color(0xffFAFAFA),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(18),
              CustomAppBarScreen(title: S.of(context).Profile),
              verticalSpace(18),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.white,
                ),
                child: CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    )),
              ),
              verticalSpace(40),
              Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    S.of(context).Email,
                    style: TextStyles.font16WhiteRegular
                        .copyWith(color: Color(0xff666666)),
                  )),
              verticalSpace(14),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 17.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r)),
                child: Text(widget.profileModel.email ?? '',
                    style:
                        TextStyles.font18BlackMedium.copyWith(fontSize: 16.sp)),
              ),
              verticalSpace(47),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).Name,
                      style: TextStyles.font16DarkerGreyRegular
                          .copyWith(color: Color(0xff666666)),
                    ),
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return AppTextFormField(
                          hintText: widget.profileModel.name ?? '',
                          backgroundColor: Colors.white,
                          borderRadius: 8.r,
                          controller: nameController,
                          readOnly: ProfileCubit.get(context).editMode,
                          hintStyle: TextStyles.font16BlackRegular,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                ProfileCubit.get(context).editToggle();
                              },
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: 12.0.h),
                                child: Image.asset(
                                  AssetsData.editIcon,
                                  height: 22.h,
                                  width: 22.w,
                                  scale: 0.7,
                                ),
                              )),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
