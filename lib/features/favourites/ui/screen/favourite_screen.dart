import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/font_weight.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/features/favourites/logic/fav_cubit.dart';
import 'package:khouyot/features/favourites/ui/screen/widgets/empty_wishlist_widget.dart';

import '../../../../core/localization/cubit/localization_cubit.dart';
import '../../../../core/theming/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/data/model/product_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
        children: [
          CustomAppBarScreen(
            title: S.of(context).Favorites,
          ),
          verticalSpace(24),
          BlocBuilder<FavCubit, FavState>(
            builder: (context, state) {
              if (state is GetFavsLoading&&FavCubit.get(context).favs.isEmpty) {
                return Center(
                    child: CircularProgressIndicator(
                  color: ColorsManager.kPrimaryColor,
                ));
              } else if(FavCubit.get(context).favs.isEmpty){
                return EmptyWishlist();
              }else {
                return GridView.builder(
                    itemBuilder: (context, index) {
                      return FavouriteItem(
                        storeProduct: FavCubit.get(context).favs[index],
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 24.h,
                        crossAxisSpacing: 15.w,
                        childAspectRatio: 0.645),
                    itemCount: FavCubit.get(context).favs.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics());
              }
            },
          )
        ],
      ),
    );
  }
}

class FavouriteItem extends StatelessWidget {
  const FavouriteItem({
    super.key,
    required this.storeProduct,
  });
  final ProductModel storeProduct;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.productScreen,
                arguments: storeProduct.id);
          },
          child: Container(
            padding: EdgeInsetsDirectional.only(bottom: 10.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Color(0xd000000))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppCachedNetworkImage(
                  image: storeProduct.images.first,
                  height: 126.h,
                  width: 162.w,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r)),
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 9.w, top: 8.h),
                  child: SizedBox(
                      width: 126.w,
                      height: 34.h,
                      child: Text(
                        storeProduct.name ?? '',
                        overflow: TextOverflow.clip,
                        style: TextStyles.font14BlackRegular,
                      )),
                ),
                //verticalSpace(10),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 9.w),
                  child: Row(
                    children: [
                      Text(
                        '${storeProduct.discountPrice ?? storeProduct.basePrice}  ',
                        style: TextStyles.font18BlackMedium
                            .copyWith(fontWeight: FontWeightHelper.bold),
                      ),
                      Text(S.of(context).EGP,
                          style: TextStyles.font16BoldWhite
                              .copyWith(color: Color(0xff922F34))),
                      horizontalSpace(4),
                      storeProduct.discountPrice == null
                          ? SizedBox.shrink()
                          : Text(
                              '${storeProduct.basePrice} ${S.of(context).EGP}',
                              style: TextStyles.font12GryBold.copyWith(
                                  decoration: TextDecoration.lineThrough),
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        verticalSpace(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextButton(
                buttonWidth: 121,
                buttonHeight: 32.h,
                borderRadius: 8.r,
                buttonText: S.of(context).AddToCart,
                textStyle: TextStyles.font16BoldWhite,
                onPressed: () {
                  context.pushNamed(Routes.productScreen,
                      arguments: storeProduct.id);
                }),
            GestureDetector(
              onTap: () {
                FavCubit.get(context).toggleFav(storeProduct.id!);
              },
              child:
                  Image.asset(AssetsData.deleteFav, height: 32.h, width: 34.w),
            )
          ],
        )
      ],
    );
  }
}

class CustomAppBarScreen extends StatelessWidget {
  const CustomAppBarScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Transform.flip(
            flipX: LocalizationCubit.get(context).locale.languageCode == 'ar',
            child: Image.asset(
              AssetsData.back,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.font36BlackBold.copyWith(fontSize: 16.sp),
        ),
        SizedBox(
          height: 24.h,
          width: 24.w,
        ),
      ],
    );
  }
}
