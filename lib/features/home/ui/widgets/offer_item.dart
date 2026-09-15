import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/features/home/data/model/offers_model.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../generated/l10n.dart';

class OffersHeroItem extends StatelessWidget {
  const OffersHeroItem({
    super.key, required this.offer,
  });
final Offer offer;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsetsDirectional.only(top: 24.h, start: 9.w, bottom: 16.h),
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      width: 339.w,
      height: 170.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: const DecorationImage(
          image: AssetImage("assets/Rectangle.png"),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: SizedBox(
        width: 217.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              offer.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.font16WhiteRegular.copyWith(fontSize: 20.sp),
            ),
            verticalSpace(4),
            SizedBox(
              width: 209.w,
              child: Text(
                offer.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyles.font16WhiteRegular.copyWith(fontSize: 12.sp),
              ),
            ),
            //const Spacer(),
            AppTextButton(
              buttonText: S.of(context).shopNow,
              buttonHeight: 33.h,
              borderRadius: 8.r,
              buttonWidth: 98,
              textStyle: TextStyles.font16BoldWhite.copyWith(fontSize: 14.sp),
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
