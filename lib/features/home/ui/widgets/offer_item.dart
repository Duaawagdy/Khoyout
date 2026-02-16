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
    return Container(
      padding: EdgeInsetsDirectional.only(top: 31.h, start: 9.w),
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      width: 339.w,
      height: 170.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
              image: AssetImage(
                "assets/Rectangle.png",
              ),
              fit: BoxFit.fitWidth)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            offer.title,
            style: TextStyles.font16WhiteRegular.copyWith(fontSize: 20.sp),
          ),
          verticalSpace(4),
          SizedBox(
            width: 209.w,
            child: Text(
              softWrap: true,
             offer.description,
              style: TextStyles.font16WhiteRegular.copyWith(fontSize: 12.sp),
            ),
          ),
          verticalSpace(8),
          AppTextButton(
              buttonText: S.of(context).shopNow,
              buttonHeight: 33.h,
              borderRadius: 8.r,
              buttonWidth: 98,
              textStyle: TextStyles.font16BoldWhite.copyWith(fontSize: 14.sp),
              onPressed: () {})
        ],
      ),
    );
  }
}
