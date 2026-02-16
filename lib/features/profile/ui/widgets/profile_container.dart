import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../data/model/profile_model.dart';

class ProfileContainer extends StatelessWidget {
   ProfileContainer({
    super.key,
     this.profileModel,
  });
   ProfileModel ?profileModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.pushNamed(Routes.editAccountInfoScreen,arguments: profileModel);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 22.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/dummy-profile.png',
                  height: 60.h,
                  width: 60.w,
                ),
                horizontalSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profileModel?.name ?? '',
                        style: TextStyles.font18BlackMedium),
                    Text(profileModel?.email ?? "",
                        style: TextStyles.font18BlackRegular
                            .copyWith(fontSize: 12.sp)),
                  ],
                ),
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
