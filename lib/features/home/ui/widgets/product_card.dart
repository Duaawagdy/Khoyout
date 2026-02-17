import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/features/home/data/model/product_model.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/localization/cubit/localization_cubit.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/font_weight.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../generated/l10n.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.itemQuantity,
    required this.onTap,
    required this.isFavorite,
    this.onFavoriteTap,
    this.addItem,
    this.decrementItem,
    required this.storeProduct,
    this.backgroundColor,
  });

  final ProductModel storeProduct;
  final int itemQuantity;
  final Function() onTap;
  final Color? backgroundColor;
  final bool isFavorite;
  final Function()? onFavoriteTap;
  final Function()? addItem;
  final Function()? decrementItem;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final presentationPrice =
        ((1 - (widget.storeProduct.discountPrice ?? 0) / (widget.storeProduct.basePrice))) * 100;

    // Check if product has multiple images
    final hasMultipleImages = widget.storeProduct.images.length > 1;
    final isArabic = LocalizationCubit.get(context).locale.languageCode == 'ar';

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            height: 208.h,
            decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.transparent,
                border: Border.all(color: Color(0xd000000)),
                borderRadius: BorderRadius.circular(8.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image Slider Container
                SizedBox(
                  width: 162.w,
                  height: 126.h,
                  child: Stack(
                    children: [
                      // PageView for images
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.r),
                          topLeft: Radius.circular(8.r),
                        ),
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemCount: widget.storeProduct.images.length,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: widget.storeProduct.images[index],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: ColorsManager.kPrimaryColor,
                                ),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                  size: 40.sp,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Favorite button
                      Positioned(
                        top: 7.h,
                        right: isArabic?null:6.w,
                        left: isArabic?6.w:null,
                        child: GestureDetector(
                          onTap: widget.onFavoriteTap,
                          child: CircleAvatar(
                            maxRadius: 15.r,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              height: 18.h,
                              width: 18.w,
                              widget.isFavorite
                                  ? AssetsData.favouriteRed
                                  : AssetsData.favourite,
                            ),
                          ),
                        ),
                      ),

                      // Page indicators
                      if (hasMultipleImages)
                        Positioned(
                          bottom: 8.h,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  widget.storeProduct.images.length,
                                      (index) => AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: _currentPage == index ? 16.w : 6.w,
                                    height: 6.h,
                                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.r),
                                      color: _currentPage == index
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Product name
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 9.w),
                  child: SizedBox(
                      width: 126.w,
                      height: 34.h,
                      child: Text(
                        isArabic?widget.storeProduct.name ?? '':widget.storeProduct.slug??'',
                        overflow: TextOverflow.clip,
                        style: TextStyles.font14BlackRegular,
                      )),
                ),

                // Price section
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 9.w),
                  child: Row(
                    children: [
                      Text(
                        '${widget.storeProduct.discountPrice ?? widget.storeProduct.basePrice}  ',
                        style: TextStyles.font18BlackMedium
                            .copyWith(fontWeight: FontWeightHelper.bold),
                      ),
                      Text(S.of(context).EGP,
                          style: TextStyles.font16BoldWhite
                              .copyWith(color: Color(0xff922F34))),
                      horizontalSpace(4),
                      widget.storeProduct.discountPrice == null
                          ? SizedBox.shrink()
                          : Text(
                        '${widget.storeProduct.basePrice} ${S.of(context).EGP}',
                        style: TextStyles.font12GryBold.copyWith(
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // Discount badge
          presentationPrice < 100
              ? Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
            decoration: BoxDecoration(
                color: ColorsManager.kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: isArabic ? Radius.zero : Radius.circular(8.r),
                  bottomRight: isArabic ? Radius.zero : Radius.circular(8.r),
                  bottomLeft: isArabic ? Radius.circular(8.r) : Radius.zero,
                  topRight: isArabic ? Radius.circular(8.r) : Radius.zero,
                )),
            child: Text(
              '${presentationPrice.toStringAsFixed(0)}% ${S.of(context).off}',
              style:
              TextStyles.font16WhiteRegular.copyWith(fontSize: 12.sp),
            ),
          )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}