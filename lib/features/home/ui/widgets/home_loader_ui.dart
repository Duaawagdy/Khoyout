import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeLoaderUI extends StatelessWidget {
  const HomeLoaderUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,

      effect: ShimmerEffect(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 339.w,
          height: 170.h,

          child: Container(
            height: 170.h,
          decoration: BoxDecoration(
          color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),

    )),
        )
        ,
        verticalSpace(11),
        Container(
            height: 8.h,
            width: 82.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(11.r),
            ),child: Text('kkhhhhhh',textAlign: TextAlign.center,style: TextStyles.font18BlackRegular.copyWith(fontSize: 4.sp),),)
      ],
    ));
  }
}
