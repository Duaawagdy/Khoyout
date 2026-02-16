import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/features/favourites/ui/screen/favourite_screen.dart';
import 'package:khouyot/features/my_orders/logic/orders_cubit.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/localization/cubit/localization_cubit.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/image_network.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/orders_model.dart';
import '../widgets/add_revwies_state_ui.dart';

class ReviewProductScreen extends StatefulWidget {
  const ReviewProductScreen({super.key, required this.orderItemModel});
  final OrderItemModel orderItemModel;

  @override
  State<ReviewProductScreen> createState() => _ReviewProductScreenState();
}

class _ReviewProductScreenState extends State<ReviewProductScreen> {
  TextEditingController reviewController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    reviewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          color: Colors.white,
          child: AppTextButton(
              buttonText: S.of(context).SubmitReview,
              backgroundColor: ColorsManager.kPrimaryColor,
              borderRadius: 8.r,
              textStyle:
                  TextStyles.font16BoldWhite.copyWith(color: Colors.white),
              onPressed: () {
                OrdersCubit.get(context).setReview(
                    widget.orderItemModel.id,
                    reviewController.text,titleController.text);
              }),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            children: [
              CustomAppBarScreen(
                title: S.of(context).reviewProduct,
              ),
              verticalSpace(49),
              Text(
                S.of(context).ProductInformation,
                style: TextStyles.font18WhiteMedium.copyWith(color: Colors.black),
              ),
              verticalSpace(14),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Color(0x1A000000))),
                child: Row(
                  children: [
                    AppCachedNetworkImage(
                      image: widget.orderItemModel.product.imagesUrls[0],
                      radius: 7.65.r,
                      height: 156.h,
                      width: 162.w,
                    ),
                    horizontalSpace(16),
                    SizedBox(
                      height: 127.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            //  width: 145.w,
                            child: SizedBox(
                              width: 107.w,
                              child: Text(
                                widget.orderItemModel.product.name,
                                style: TextStyles.font14SeconderyBold
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                widget.orderItemModel.price.toString(),
                                style: TextStyles.font20BlackMedium
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                S.of(context).EGP,
                                style: TextStyles.font18BlackMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff922F34)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                S.of(context).Quantity,
                                style: TextStyles.font18BlackMedium
                                    .copyWith(fontSize: 14.sp),
                              ),
                              horizontalSpace(14),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                    color: Color(0xffFFF1DA),
                                    borderRadius: BorderRadius.circular(4.r)),
                                child: Text(
                                    widget.orderItemModel.quantity.toString()),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              verticalSpace(50),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 14.h),
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).Rating,
                        style:
                            TextStyles.font16BoldWhite.copyWith(color: Colors.black)),
                    verticalSpace(8),
                    BlocBuilder<OrdersCubit, OrdersState>(
                      builder: (context, state) {
                        return StarRating();
                      },
                    ),
                  ],
                ),
              ),
              verticalSpace(24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 14.h),
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).Title,
                        style:
                        TextStyles.font16BoldWhite.copyWith(color: Colors.black)),
                    verticalSpace(8),
                    AppTextFormField(
                      hintText: '',
                      maxline: 1,
                      hintStyle:
                          TextStyles.font16BoldWhite.copyWith(color: Colors.black),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      backgroundColor: Colors.transparent,
                      width: 303,
                      controller: titleController,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Color(0xffE5E7EB))),
                    ),
                  ],
                ),
              ),verticalSpace(24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 14.h),
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).WriteYourReview,
                        style:
                        TextStyles.font16BoldWhite.copyWith(color: Colors.black)),
                    verticalSpace(8),
                    AppTextFormField(
                      hintText: '',
                      maxline: 9,
                      hintStyle:
                          TextStyles.font16BoldWhite.copyWith(color: Colors.black),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      backgroundColor: Colors.transparent,
                      width: 303,
                      controller: reviewController,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Color(0xffE5E7EB))),
                    ),
                  ],
                ),
              ),
              AddReviewStateUi()
            ],
          ),
        ),
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.orderItemModel,
  });

  final OrderItemModel orderItemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          border: Border.all(color: ColorsManager.grey),
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppCachedNetworkImage(
            image: orderItemModel.productImage,
            height: 88.h,
            width: 78.w,
            radius: 10.r,
            fit: BoxFit.cover,
          ),
          horizontalSpace(8),
          SizedBox(
            //height: 78.h,
            //width: 248.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 157.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            orderItemModel.product.name ?? '',
                            style: TextStyles.font18WhiteMedium,
                          ),
                          //verticalSpace(10),
                          Text(
                            orderItemModel.price.toString(),
                            style: TextStyles.font15WhiteRegular
                                .copyWith(color: ColorsManager.kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      S.of(context).Quantity,
                      style: TextStyles.font15WhiteRegular
                          .copyWith(color: ColorsManager.grey),
                    ),
                    horizontalSpace(4),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorsManager.grey,
                          borderRadius: BorderRadius.circular(4.r)),
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                      child: Text(orderItemModel.quantity.toString(),
                          style: TextStyles.font30WhiteSemiBold),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  const StarRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) {
          final isSelected = index < OrdersCubit.get(context).rating;

          return GestureDetector(
            onTap: () {
              OrdersCubit.get(context).setRating(index + 1);
            },
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 4.w),
              child: Image.asset(
                'assets/starsold.png' // ⭐ filled
                , // ⭐ empty
                width: 40.w,
                height: 40.h,
                color: isSelected
                    ? ColorsManager.kPrimaryColor
                    : Color(0xffE3E3E3),
              ),
            ),
          );
        },
      ),
    );
  }
}
