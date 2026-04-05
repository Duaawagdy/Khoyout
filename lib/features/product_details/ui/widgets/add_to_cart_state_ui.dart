import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/networking/dio_factory.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/font_weight.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/core/widgets/show_dialog_error.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/features/nav_bar/logic/nav_bar_cubit.dart';
import 'package:khouyot/features/product_details/data/model/add_to_cart_response.dart';
import 'package:khouyot/features/product_details/logic/product_details_cubit.dart';
import 'package:khouyot/generated/l10n.dart';

import '../../../cart_screen/ui/cart_screen_ui.dart';
import '../../../categories_screen/ui/screen/categories_screen.dart';

class AddToCartStateUi extends StatelessWidget {
  const AddToCartStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        if (state is AddToCartLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          );
        } else if (state is AddToCartSuccess) {
          context.pop();
          _showSuccessBottomSheet(context, state.cartResponse);
        } else if (state is AddToCartError) {
          context.pop(); // Close loading dialog
          ShowDialogError.showErrorDialog(
              context, S.of(context).error, S.of(context).somethingWentWrong);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showSuccessBottomSheet(BuildContext context, AddCartResponse message) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xffFAFAFA),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      builder: (context) {
        return SafeArea(
          bottom: true,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              FreeDeleveryProgress(currentAmount: 90,),
              verticalSpace(20),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(
                        start: 10.w, top: 4.h, bottom: 9.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Row(
                      children: [
                        AppCachedNetworkImage(
                          image: message.product.image,
                          height: 116.h,
                          width: 97.w,
                          radius: 5.25.r,
                        ),
                        horizontalSpace(11),
                        SizedBox(
                          height: 109.h,
                          width: 187.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).AddToYourCart,
                                style: TextStyles.font36BlackBold
                                    .copyWith(fontSize: 18.sp),
                              ),
                              Text(
                                message.product.name,
                                style: TextStyles.font14BlackRegular
                                    .copyWith(fontSize: 12.sp),
                              ),
                              Text(
                                message.unitPriceEgp.toString(),
                                style: TextStyles.font24BlackBold
                                    .copyWith(fontSize: 18.sp),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      AssetsData.cartAdded,
                      height: 34.h,
                      width: 34.w,
                    ),
                  )
                ],
              ),
              verticalSpace(44),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextButton(
                      buttonText: S.of(context).ViewOtherProducts,
                      buttonWidth: 202,
                      borderRadius: 8.r,
                      buttonHeight: 43.h,
          borderColor: Color(0xffE5E7EB),
                      backgroundColor: Colors.white,
                      textStyle: TextStyles.font16BoldWhite
                          .copyWith(color: Colors.black),
                      onPressed: () {
                        context.pushNamedAndRemoveUntil(Routes.navigationBar,arguments: 0, predicate: (Route<dynamic> route) { return false; } );

                      })  ,
                  AppTextButton(
                      buttonText: S.of(context).Viewcart,
                      buttonWidth: 121,
                      borderRadius: 8.r,
                      buttonHeight: 43.h,

                      backgroundColor: ColorsManager.kPrimaryColor,
                      textStyle: TextStyles.font16BoldWhite
                          .copyWith(color: Colors.white),
                      onPressed: () {
                        context.pushNamedAndRemoveUntil(Routes.navigationBar,arguments: 2, predicate: (Route<dynamic> route) { return false; } );
                        NavBarCubit.get(context).changeIndex(2);
                      })
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
