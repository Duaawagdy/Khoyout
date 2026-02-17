import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';

import '../../../../../generated/l10n.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(49),
        Image.asset(
          AssetsData.emptyWishlist,
          height: 200.h,
          width: 200.w,
        ),
        verticalSpace(40),
        Text(S.of(context).Yourfavoriteslistisempty,
            style: TextStyles.font16BlackRegular
                .copyWith(fontWeight: FontWeight.bold)),
    verticalSpace(12),
        SizedBox(
          width: 262.w,
          child: Text(
            S.of(context).StartexploringKhyout,
            style: TextStyles.font18BlackMedium.copyWith(fontSize: 12.sp),
            textAlign: TextAlign.center,
          ),
        ),
        verticalSpace(60),
        AppTextButton(

            buttonHeight: 32.h,
            borderRadius: 8.r,
            buttonText: S.of(context).BrowseProducts,
            textStyle: TextStyles.font16BoldWhite,
            onPressed: () {
context.pushNamedAndRemoveUntil(Routes.navigationBar,arguments: 0, predicate: (Route<dynamic> route) { return false; },  );
            }),      ],
    );
  }
}
