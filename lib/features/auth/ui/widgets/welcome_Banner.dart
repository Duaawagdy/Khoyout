import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

class WelcomeTextBanner extends StatelessWidget {
  const WelcomeTextBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).WelcometoKhouyot,

            style: TextStyles.font16WhiteRegular.copyWith(fontSize: 20.sp),
          ),
          verticalSpace(8),
          Text(
            S.of(context).Explorethelatestcollection
                ,
            style: TextStyles.font16WhiteRegular.copyWith(fontSize: 12.sp),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
