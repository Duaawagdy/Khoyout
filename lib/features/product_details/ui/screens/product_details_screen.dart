import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khouyot/core/functions/snak_bar.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/localization/cubit/localization_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/font_weight.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/features/cart_screen/data/model/cart_reponse_model.dart';
import 'package:khouyot/features/cart_screen/logic/cart_cubit.dart';
import 'package:khouyot/features/product_details/logic/product_details_cubit.dart';

import '../../../../core/routing/routes.dart';
import '../../../../generated/l10n.dart';
import '../../../favourites/logic/fav_cubit.dart';
import '../../../home/ui/screens/home_screen.dart';
import '../../../nav_bar/logic/nav_bar_cubit.dart';
import '../../data/model/reviews_response.dart';
import '../widgets/add_to_cart_state_ui.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id});
  final int id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final productCubit = ProductDetailsCubit.get(context);
    productCubit.getProductDetails(widget.id);
    productCubit.getReviews(widget.id);
    productCubit.getGuestMode();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        bottomNavigationBar:
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is GetProductDetailsLoading ||
                ProductDetailsCubit.get(context).productDetailsModel.data ==
                    null) {
              return SizedBox.shrink();
            } else {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                color: Colors.white,
                height: 128.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).Quantity,
                          style: TextStyles.font18BlackMedium
                              .copyWith(fontSize: 14.sp),
                        ),
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    border:
                                        Border.all(color: Color(0xffD3D6DA))),
                                child: GestureDetector(
                                    onTap: () {
                                      ProductDetailsCubit.get(context)
                                          .updateQuantity('reduce');
                                    },
                                    child: Icon(Icons.remove_rounded))),
                            horizontalSpace(14),
                            Text(
                              ProductDetailsCubit.get(context)
                                  .productQuantity
                                  .toString(),
                              style: TextStyles.font36BlackBold
                                  .copyWith(fontSize: 14.sp),
                            ),
                            horizontalSpace(14),
                            Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    border:
                                        Border.all(color: Color(0xffD3D6DA))),
                                child: GestureDetector(
                                    onTap: () {
                                      ProductDetailsCubit.get(context)
                                          .updateQuantity('add');
                                    },
                                    child: Icon(Icons.add_rounded)))
                          ],
                        )
                      ],
                    ),
                    verticalSpace(14),
                    AppTextButton(
                      buttonText: S.of(context).Addtocart,
                      textStyle: TextStyles.font16BoldWhite,
                      onPressed: (){
                        final cubit = ProductDetailsCubit.get(context);
                        if (cubit.guestMode) {
                          showGuestBottomSheet(context);
                        } else if (cubit.selectedVarientName.isEmpty) {
                          showSnackBar(context: context, text: S.of(context).pleaseSelectColor);
                        } else if (cubit.hasSizes && cubit.selectedSizeName.isEmpty) {
                          showSnackBar(context: context, text: S.of(context).pleaseSelectSize);
                        } else if (cubit.selectedVarientId == -1) {
                          showSnackBar(context: context, text: S.of(context).combinationUnavailable);
                        } else if (cubit.productQuantity == 0) {
                          showSnackBar(context: context, text: S.of(context).pleaseAddQuantity);
                        } else {
                          cubit.addToCart();
                        }

                      },
                      borderRadius: 8.r,
                      backgroundColor: ColorsManager.kPrimaryColor,
                    )
                  ],
                ),
              );
            }
          },
        ),
        backgroundColor: Color(0xffFAFAFA),
        body: SafeArea(
          child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              if (state is GetProductDetailsLoading ||
                  ProductDetailsCubit.get(context).productDetailsModel.data ==
                      null) {
                return Center(
                    child: CircularProgressIndicator(
                  color: ColorsManager.kPrimaryColor,
                ));
              } else {
                return ListView(
                  children: [
                    verticalSpace(20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: Transform.flip(
                                    flipX: LocalizationCubit.get(context)
                                            .locale
                                            .languageCode ==
                                        'ar',
                                    child: Image.asset(AssetsData.back,
                                        height: 24.h, width: 24.w),
                                  )),
                              GestureDetector(
                                onTap: (){
                                  context.pushNamedAndRemoveUntil(Routes.navigationBar,arguments: 2, predicate: (Route<dynamic> route) { return false; } );

                                },
                                child: Container(
                                  width: 36.w,
                                  height: 36.h,
                                  decoration: BoxDecoration(
                                      color: Color(0x80B93C41),
                                      borderRadius: BorderRadius.circular(24.r)),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 17.r,
                                      foregroundColor: Color(0xB93C4180),
                                      child: Stack(
                                        children: [
                                          SvgPicture.asset(
                                            AssetsData.cart,
                                            color: Colors.black,
                                          ),
                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: CircleAvatar(
                                                backgroundColor: Color(0xff6C2326),
                                                radius: 6.r,
                                                child: Text(
                                                  CartCubit.get(context)
                                                      .cartResponse
                                                      .length
                                                      .toString(),
                                                  style: TextStyles
                                                      .font30WhiteSemiBold
                                                      .copyWith(fontSize: 7.sp),
                                                ),
                                              ))
                                        ],
                                      )),
                                ),
                              )
                            ],
                          ),
                          verticalSpace(24),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            builder: (context, state) {
                              return ProductImagesContainer(
                                isFav: ProductDetailsCubit.get(context)
                                    .isTapFav??ProductDetailsCubit.get(context)
                                    .productDetailsModel
                                    .isFavorite,
                                featureImages: ProductDetailsCubit.get(context)
                                    .featuredImages,
                                id: ProductDetailsCubit.get(context)
                                        .productDetailsModel
                                        .data
                                        ?.id ??
                                    0,
                              );
                            },
                          ),
                          verticalSpace(16),
                          ProductDetailsCubit.get(context)
                                      .productDetailsModel
                                      .data
                                      ?.cartQuantity !=
                                  0
                              ? Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        border:
                                            Border.all(color: Color(0xff039623))),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                            "assets/shopping-basket-done.png",
                                            height: 20.h,
                                            width: 20.w),
                                        horizontalSpace(10),
                                        Text(
                                          S.of(context).inyourcart,
                                          style: TextStyles.font16BoldWhite
                                              .copyWith(color: Color(0xff039623)),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                          ProductDetailsCubit.get(context).reviewsResponse == null
                              ? SizedBox.shrink()
                              : ReviewsCount(
                                  total: ProductDetailsCubit.get(context)
                                      .reviewsResponse!
                                      .data
                                      .length,
                                  averageRating: ProductDetailsCubit.get(context)
                                          .reviewsResponse
                                          ?.data
                                          .firstOrNull
                                          ?.rating ??
                                      0,
                                ),
                          verticalSpace(16),
                          Text(
                              LocalizationCubit.get(context).locale.languageCode=='ar'?ProductDetailsCubit.get(context)
                                      .productDetailsModel
                                      .data
                                      ?.name ??
                                  '':ProductDetailsCubit.get(context)
                                  .productDetailsModel
                                  .data
                                  ?.slug ??
                                  '',
                              style: TextStyles.font24BlackBold
                                  .copyWith(fontSize: 20.sp)),
                          verticalSpace(12),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 9.w),
                            child: Row(
                              children: [
                                // ✅ FIX: use discount_price only if it's > 0, otherwise show base_price
                                Text(
                                  '${(ProductDetailsCubit.get(context).productDetailsModel.data?.discountPrice ?? 0) > 0
                                      ? ProductDetailsCubit.get(context).productDetailsModel.data?.discountPrice
                                      : ProductDetailsCubit.get(context).productDetailsModel.data?.basePrice} ',
                                  style: TextStyles.font24BlackBold.copyWith(fontSize: 20.sp),
                                ),
                                Text(
                                  S.of(context).EGP,
                                  style: TextStyles.font16BoldWhite.copyWith(color: Color(0xff922F34)),
                                ),
                                horizontalSpace(4),
                                // ✅ FIX: only show strikethrough base_price when discount actually exists
                                (ProductDetailsCubit.get(context).productDetailsModel.data?.discountPrice ?? 0) > 0
                                    ? Text(
                                  '${ProductDetailsCubit.get(context).productDetailsModel.data?.basePrice} ${S.of(context).EGP}',
                                  style: TextStyles.font12GryBold.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14.sp,
                                  ),
                                )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.r, horizontal: 18.w),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).Colors,
                            style: TextStyles.font24BlackBold
                                .copyWith(fontSize: 16.sp),
                          ),
                          verticalSpace(16),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            builder: (context, state) {
                              return ColorsContainer();
                            },
                          )
                        ],
                      ),
                    ),
                    verticalSpace(24),
                    BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                      builder: (context, state) {
                        if (!ProductDetailsCubit.get(context).hasSizes) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 18.w),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).Size,
                                  style: TextStyles.font24BlackBold.copyWith(fontSize: 16.sp),
                                ),
                                verticalSpace(16),
                                const SizesContainer(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),verticalSpace(24),
                    DescriptionContainer(),
                    verticalSpace(24),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.r, horizontal: 18.w),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).Reviews,
                            style: TextStyles.font24BlackBold
                                .copyWith(fontSize: 16.sp),
                          ),
                          verticalSpace(16),
                          ProductDetailsCubit.get(context).reviewsResponse == null
                              ? SizedBox.shrink()
                              : ReviewsCount(
                                  total: ProductDetailsCubit.get(context)
                                      .reviewsResponse!
                                      .data
                                      .length,
                                  averageRating: ProductDetailsCubit.get(context)
                                          .reviewsResponse
                                          ?.data
                                          .firstOrNull
                                          ?.rating ??
                                      0,
                                ),
                          verticalSpace(16),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            builder: (context, state) {
                              if (state is GetReviewsLoading &&
                                  ProductDetailsCubit.get(context)
                                      .reviewsResponse!
                                      .data
                                      .isEmpty) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: ColorsManager.kPrimaryColor,
                                ));
                              } else if (ProductDetailsCubit.get(context)
                                      .reviewsResponse!
                                      .data
                                      .isEmpty ||
                                  ProductDetailsCubit.get(context)
                                          .reviewsResponse ==
                                      null) {
                                return Center(
                                  child: Text(
                                    S.of(context).noReviewsYet,
                                    style: TextStyles.font16BlackRegular
                                        .copyWith(color: Colors.black),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: ProductDetailsCubit.get(context)
                                        .reviewsResponse
                                        ?.data
                                        .length,
                                    itemBuilder: (context, index) {
                                      return ReviewItem(
                                        review: ProductDetailsCubit.get(context)
                                            .reviewsResponse!
                                            .data[index],
                                      );
                                    });
                              }
                            },
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
class SizesContainer extends StatelessWidget {
  const SizesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final cubit = ProductDetailsCubit.get(context);
        final sizes = cubit.allSizes;
        final available = cubit.availableSizes;

        return SizedBox(
          height: 44.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: sizes.length,
            separatorBuilder: (_, __) => horizontalSpace(12),
            itemBuilder: (context, index) {
              final size = sizes[index];
              final isAvailable = available.contains(size);
              final isSelected = cubit.selectedSizeName == size;

              return GestureDetector(
                onTap: isAvailable ? () => cubit.selectSize(size) : null,
                child: Container(
                  constraints: BoxConstraints(minWidth: 54.w),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xff6C2326) : Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xff6C2326)
                          : isAvailable
                          ? const Color(0x33000000)
                          : const Color(0x14000000),
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    size,
                    style: TextStyles.font16BlackRegular.copyWith(
                      color: isSelected
                          ? Colors.white
                          : isAvailable
                          ? Colors.black
                          : const Color(0x40000000),
                      fontWeight: isSelected
                          ? FontWeightHelper.semiBold
                          : FontWeightHelper.regular,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.review,
  });
  final Review review;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Color(0x1A000000))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/dummy-profile.png',
                height: 60.h,
                width: 60.w,
              ),
              horizontalSpace(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    review.user?.name ?? '',
                    style: TextStyles.font14BlackRegular
                        .copyWith(fontWeight: FontWeightHelper.medium),
                  ),
                  Text(
                    review.updatedAt.replaceRange(10, null, ''),
                    style: TextStyles.font14BlackRegular
                        .copyWith(color: Color(0xff515966)),
                  )
                ],
              ),
              Spacer(),
              StarsDisplay(
                starCount: review.rating ?? 0,
              )
            ],
          ),
          verticalSpace(8),
          Text(review.message,
              style: TextStyles.font16BlackRegular.copyWith(fontSize: 12.sp)),
        ],
      ),
    );
  }
}

class StarsDisplay extends StatelessWidget {
  const StarsDisplay({
    super.key,
    required this.starCount,
  });
  final int starCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          starCount,
          (index) => Image.asset(
                AssetsData.star,
                height: 16.h,
                width: 16.w,
              )),
    );
  }
}

class ReviewsCount extends StatelessWidget {
  const ReviewsCount({
    super.key,
    required this.total,
    required this.averageRating,
  });
  final int total;
  final int averageRating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(AssetsData.star, height: 24.h, width: 24.w),
        horizontalSpace(6.5),
        Text(
          averageRating.toString(),
          style: TextStyles.font14SeconderyBold.copyWith(color: Colors.black),
        ),
        horizontalSpace(6.5),
        Text(
          '(${total.toString()})',
          style: TextStyles.font14DarkGreyRegular,
        ),
      ],
    );
  }
}

class DescriptionContainer extends StatelessWidget {
  const DescriptionContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 18.w),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).description,
            style: TextStyles.font24BlackBold.copyWith(fontSize: 16.sp),
          ),
          verticalSpace(16),
          Text(
            LocalizationCubit.get(context).locale.languageCode=='en'?ProductDetailsCubit.get(context)
                .productDetailsModel
                .data!
                .description
                .replaceAll(RegExp(r'<[^>]*>'), ''):ProductDetailsCubit.get(context)
                .productDetailsModel
                .data!
                .descriptionAr!
                .replaceAll(RegExp(r'<[^>]*>'), ''),
            style:
                TextStyles.font14DarkGreyRegular.copyWith(color: Colors.black),
          ),
          AddToCartStateUi()
        ],
      ),
    );
  }
}

class ColorsContainer extends StatelessWidget {
  const ColorsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return horizontalSpace(12);
          },
          scrollDirection: Axis.horizontal,
          itemCount: ProductDetailsCubit.get(context)
              .productDetailsModel
              .data!
              .colors
              .length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                ProductDetailsCubit.get(context).selectColor(
                    ProductDetailsCubit.get(context)
                            .productDetailsModel
                            .data!
                            .colors[index]
                            .name ??
                        '',
                    ProductDetailsCubit.get(context)
                        .productDetailsModel
                        .data!
                        .variants);
              },
              child: Container(
                //    margin: EdgeInsetsDirectional.only(end: 12.w),
                width: 42.w,
                height: 36.h,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: ProductDetailsCubit.get(context)
                                    .selectedVarientName ==
                                ProductDetailsCubit.get(context)
                                    .productDetailsModel
                                    .data
                                    ?.colors[index]
                                    .name
                            ? 1.w
                            : 0.5.w,
                        color: ProductDetailsCubit.get(context)
                                    .selectedVarientName ==
                                ProductDetailsCubit.get(context)
                                    .productDetailsModel
                                    .data
                                    ?.colors[index]
                                    .name
                            ? Color(0xff922F34)
                            : Color(0x80000000)),
                    color: Color(int.parse(
                        '0xff${ProductDetailsCubit.get(context).productDetailsModel.data?.colors[index].hex?.replaceAll("#", '')}')),
                    borderRadius: BorderRadius.circular(4.r)),
                child: Center(
                    child:
                        ProductDetailsCubit.get(context).selectedVarientName ==
                                ProductDetailsCubit.get(context)
                                    .productDetailsModel
                                    .data
                                    ?.colors[index]
                                    .name
                            ? Image.asset(
                                AssetsData.tick,
                                width: 20.w,
                                height: 20.h,
                              )
                            : SizedBox.shrink()),
              ),
            );
          }),
    );
  }
}

class ProductImagesContainer extends StatelessWidget {
  ProductImagesContainer(
      {super.key, required this.isFav, this.featureImages, required this.id});
  bool isFav;
  String? featureImages;
  int id;
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        AppCachedNetworkImage(
          image: featureImages ??
              ProductDetailsCubit.get(context)
                  .productDetailsModel
                  .data
                  ?.firstImage,
          width: 339.w,
          fit: BoxFit.fill,
          height: 291.h,
        ),
        SizedBox(
          height: 314.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(start: 18.w, top: 7.h),
                child: GestureDetector(
                  onTap: () {
                    FavCubit.get(context).toggleFav(id);

ProductDetailsCubit.get(context).tapFav(isFav);
                  },
                  child: CircleAvatar(
                    maxRadius: 15.r,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      height: 18.h,
                      width: 18.w,
                      isFav ? AssetsData.favouriteRed : AssetsData.favourite,
                    ),
                  ),
                ),
              ),
              Container(
                height: 79.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 7.5.w, vertical: 7.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r)),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: ProductDetailsCubit.get(context)
                        .productDetailsModel
                        .data
                        ?.images
                        .length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: Color(0xFF922F34)),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: AppCachedNetworkImage(
                          image: ProductDetailsCubit.get(context)
                              .productDetailsModel
                              .data
                              ?.images[index],
                          radius: 8.r,
                          width: 63.w,
                          height: 72.h,
                        ),
                      );
                    }),
              )
            ],
          ),
        )
      ],
    );
  }
}
