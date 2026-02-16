import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/localization/cubit/localization_cubit.dart';
import 'package:khouyot/core/networking/dio_factory.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/profile/data/model/profile_model.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../widgets/profile_container.dart';
import '../widgets/profile_loader_ui.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final cubit = ProfileCubit.get(context);
    cubit.getGuestMode();
    cubit.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 22.h),
        children: [
          Text(
            S.of(context).Profile,
            textAlign: TextAlign.center,
            style: TextStyles.font36BlackBold.copyWith(fontSize: 16.sp),
          ),
          verticalSpace(24),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (ProfileCubit.get(context).guestMode) {
                return GestureDetector(
                  onTap: () {
                    context.pushReplacementNamed(Routes.signUpScreen);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 22.h),
                    decoration: BoxDecoration(

                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Color(0xffF8E8E9),
                          border: Border.all(color: Color(0xffB93C41)),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/user-circle.png',
                            height: 24.h,
                            width: 24.w,
                          ),horizontalSpace(24),
                          Text('signup/Login'),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded,size: 16.sp,),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is GetProfileLoading||ProfileCubit.get(context).profile==null) {

                  return ProfileLoaderUI();


              }else {
                return ProfileContainer(
                  profileModel: ProfileCubit.get(context).profile,
                );
              }

            },
          ),
          verticalSpace(16),
          BlocBuilder<ProfileCubit,ProfileState>(
  builder: (context, state) {
    if (ProfileCubit.get(context).guestMode) {
      return SizedBox.shrink();
    }
    else {
      return Column(
            children: [
              ProfileItem(
                icon: AssetsData.orders,
                title: S.of(context).MyOrders,
                onTap: () {
                  context.pushNamed(Routes.ordersScreen);
                },
              ),
              verticalSpace(8),
              ProfileItem(
                icon: AssetsData.heart,
                title: S.of(context).Favorites,
                onTap: () {
                  context.pushNamed(Routes.wishListScreen);
                },
              ),
              verticalSpace(8),
              ProfileItem(
                icon: AssetsData.address,
                title: S.of(context).MyAddresses,
                onTap: () {
                  context.pushNamed(Routes.myAddressScreen);
                },
              ),
              verticalSpace(16),
            ],
          );
    }
  },
),
          Text(S.of(context).Settings,
              style: TextStyles.font18BlackMedium.copyWith(fontSize: 16.sp)),
          verticalSpace(16),
          BlocBuilder<ProfileCubit,ProfileState>(
  builder: (context, state) {
    if (ProfileCubit.get(context).guestMode) {
      return ProfileItem(
        icon: AssetsData.securityCheck,
        title: S.of(context).PrivacyPolicy,
      );
    } else {
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
            child: Column(
              children: [
                ProfileItem(
                  icon: AssetsData.exchange,
                  title: S.of(context).ChangePassword,
                  onTap: () {
                    context.pushNamed(Routes.changePasswordScreen);
                  },
                ),
                verticalSpace(16),
                ProfileItem(
                  icon: AssetsData.securityCheck,
                  title: S.of(context).PrivacyPolicy,
                  onTap: (){
                    UrlLauncher.launchPolicies();
                  },
                ),
                // verticalSpace(16),
                // ProfileItem(
                //   icon: AssetsData.notification,
                //   title: S.of(context).Notifications,
                // ),
              ],
            ),
          );
  }},
),
          verticalSpace(16),
          Text(S.of(context).Language,
              style: TextStyles.font18BlackMedium.copyWith(fontSize: 16.sp)),
          verticalSpace(16),
          ProfileItem(
            icon: AssetsData.tablerWorld,
            title: S.of(context).language,
            onTap: () {
              LocalizationCubit.get(context).toggleLanguage();

            },
          ),
          verticalSpace(8),
          BlocBuilder<ProfileCubit,ProfileState>(
  builder: (context, state) {
    if (ProfileCubit.get(context).guestMode) {
      return SizedBox.shrink();
    } else {
      return ProfileItem(
            icon: AssetsData.logout,
            title: S.of(context).Logout,
            onTap: () {
              context.pushNamedAndRemoveUntil(Routes.signUpScreen,
                  predicate: (_) => false);
              CashHelper.clear();
              DioFactory.removeTokenIntoHeaderAfterLogout();
            },
          );
    }
  },
)
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });
  final String icon;
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 22.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  icon,
                  height: 20.h,
                  width: 20.w,
                  fit: BoxFit.scaleDown,
                ),
                horizontalSpace(8),
                Text(title, style: TextStyles.font16BlackRegular),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class UrlLauncher {
  static Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Opens in external browser
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchPolicies() async {
    await launchURL('https://dashboard.khoyoutscarfstores.com/policies');
  }
}