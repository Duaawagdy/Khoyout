import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/styles.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/utils/assets.dart';
import '../../../../generated/l10n.dart';
import '../../logic/nav_bar_cubit.dart';

class NavigationBarApp extends StatefulWidget {
  const NavigationBarApp({super.key, this.index});
  final int? index;

  @override
  State<NavigationBarApp> createState() => _NavigationBarAppState();
}

class _NavigationBarAppState extends State<NavigationBarApp> {
  @override
  void initState() {
    super.initState();
    // ✅ Use initialPage in PageController instead of jumpToPage
    final initialIndex = widget.index ?? 0;
    NavBarCubit.get(context).initIndex(initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        final nav = NavBarCubit.get(context);
        return SafeArea(
          bottom: true,
          child: Scaffold(
            backgroundColor: ColorsManager.mainWhite,
            body: PageView(
              controller: nav.pageController,
              children: nav.screens,
              onPageChanged: (index) {
                nav.changeIndex(index, jumping: false);
              },
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.5.h),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffE3E3E3), width: 2.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavItem(onTap: () => nav.changeIndex(0), title: S.of(context).Home, activeIcon: AssetsData.homeWhite, icon: AssetsData.home, isSelected: nav.selectedIndex == 0),
                  NavItem(onTap: () => nav.changeIndex(1), title: S.of(context).Categories, activeIcon: AssetsData.categoryWhite, icon: AssetsData.category, isSelected: nav.selectedIndex == 1),
                  NavItem(onTap: () => nav.changeIndex(2), title: S.of(context).Cart, activeIcon: AssetsData.cartWhite, icon: AssetsData.cart, isSelected: nav.selectedIndex == 2),
                  NavItem(onTap: () => nav.changeIndex(3), title: S.of(context).Profile, activeIcon: AssetsData.profileWhite, icon: AssetsData.profile, isSelected: nav.selectedIndex == 3),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key, required this.onTap, required this.title, required this.activeIcon, required this.icon, required this.isSelected,

  });


final Function()onTap;
final String title;
final String activeIcon;
final String icon;
final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,

        width: isSelected ? 129.w : 44.w, // 👈 important
        height: 44.h,

        alignment: Alignment.center, // 👈 expand from start
        //padding: EdgeInsets.symmetric(horizontal: 10.w),

        decoration: BoxDecoration(
          color: isSelected
              ? ColorsManager.kPrimaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isSelected ? activeIcon : icon,
              fit: BoxFit.scaleDown,
            ),

            if (isSelected) ...[
              horizontalSpace(6),
              Text(
                title,
                style: TextStyles.font16BoldWhite.copyWith(fontSize: 14.sp),
              ),
            ],
          ],
        ),
      )
      ,
    );
  }
}
