import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/features/favourites/logic/fav_cubit.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../generated/l10n.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({
    super.key, this.borderRadius,
  });
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
          top: 33.h, bottom: 24.h, start: 18.w, end: 18.w),
      decoration: BoxDecoration(
          color: ColorsManager.kPrimaryColor,
          borderRadius: borderRadius??BorderRadius.only(
              bottomRight: Radius.circular(24.r),
              bottomLeft: Radius.circular(24.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () {
              context.pushNamed(Routes.searchScreen);
            },
            child: Container(
              width: 289.w,
              padding: EdgeInsetsDirectional.only(
                  start: 16.w, top: 13.5.h, bottom: 13.5.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r)),
              child: SizedBox(
                height: 16.h,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsData.search,
                      width: 16.w,
                      height: 16.h,
                    ),
                    horizontalSpace(12),
                    Text(
                      textAlign: TextAlign.center,
                      S.of(context).Whatareyoulookingfor,
                      style: TextStyles.font14DarkGreyRegular
                          .copyWith(fontSize: 12.sp),
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<FavCubit,FavState>(
  builder: (context, state) {
    return GestureDetector(
            onTap: () {
              context.pushNamed(Routes.wishListScreen);
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Stack(
                children: [
                  Image.asset(
                    AssetsData.favourite,
                    width: 24.w,
                    height: 24.w,
                  ),
                  FavCubit.get(context).favs.isEmpty
                      ? SizedBox.shrink()
                      : Positioned(
                   right: 0,
                        top:
                    1,
                        child: CircleAvatar(
                                            backgroundColor: ColorsManager.kPrimaryColor,
                                            radius: 5.5.r,
                                            child: Center(
                                              child: Text(
                                                                      FavCubit.get(context).favs.length.toString(),
                                                                      style: TextStyles.font30WhiteSemiBold
                                                                          .copyWith(fontSize: 6.29.sp),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                      )
                ],
              ),
            ),
          );
  },
)
        ],
      ),
    );
  }
}
