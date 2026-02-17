import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/localization/cubit/localization_cubit.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/features/home/data/model/product_model.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/font_weight.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../generated/l10n.dart';

class FeaturedProductCard extends StatefulWidget {
  const FeaturedProductCard({
    super.key,
    required this.itemQuantity,
    required this.onTap,
    required this.isFavorite,
    this.onFavoriteTap,
    this.addItem,
    this.decrementItem,
    required this.storeProduct,
  });

  final ProductModel storeProduct;
  final int itemQuantity;
  final Function() onTap;
  final bool isFavorite;
  final Function()? onFavoriteTap;
  final Function()? addItem;
  final Function()? decrementItem;

  @override
  State<FeaturedProductCard> createState() => _FeaturedProductCardState();
}

class _FeaturedProductCardState extends State<FeaturedProductCard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                color: Colors.white,
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
                          topLeft: Radius.circular(8.r),
                          topRight: Radius.circular(8.r),
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
                            return AppCachedNetworkImage(
                              image: widget.storeProduct.images[index],
                              width: 162.w,
                              height: 126.h,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.r),
                                topRight: Radius.circular(8.r),
                              ),
                              fit: BoxFit.cover,
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
                              widget.isFavorite
                                  ? AssetsData.favouriteRed
                                  : AssetsData.favourite,
                              height: 18.h,
                              width: 18.w,
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

          // Featured badge (RTL support)
          Transform.flip(
            flipX: isArabic,
            child: Image.asset(
              AssetsData.fProduct,
              height: 53.h,
              width: 95.w,
            ),
          ),
        ],
      ),
    );
  }
}