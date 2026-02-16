import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/font_weight.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/core/widgets/price_display.dart';
import 'package:khouyot/features/cart_screen/data/model/cart_reponse_model.dart';
import 'package:khouyot/features/cart_screen/logic/cart_cubit.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/utils/assets.dart';
import '../../../../generated/l10n.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    CartCubit.get(context).getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoadingState) {
          return Scaffold(
            backgroundColor: Color(0xffFAFAFA),
            body: Center(
              child: CircularProgressIndicator(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          );
        } else if (CartCubit.get(context).cartResponse.isEmpty) {
          return Scaffold(
            backgroundColor: Color(0xffFAFAFA),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 22.h),
              children: [
                CartHeader(
                  cartItems: CartCubit.get(context).cartResponse.length,
                ),
                verticalSpace(24),
                FreeDeleveryProgress(
                  currentAmount: 0,
                ),
                Image.asset(
                  AssetsData.emptyCart,
                  height: 200.h,
                  width: 200.w,
                ),
                verticalSpace(24),
                Text(
                  S.of(context).Noitemsinyourcartyet,
                  textAlign: TextAlign.center,
                  style: TextStyles.font18BlackMedium.copyWith(fontSize: 16.sp),
                ),
                verticalSpace(12),
                Text(
                  S.of(context).Pickyourfavorites,
                  textAlign: TextAlign.center,
                  style: TextStyles.font18BlackMedium.copyWith(fontSize: 12.sp),
                ),
                verticalSpace(24),
                AppTextButton(
                    buttonText: S.of(context).BrowseProducts,
                    textStyle: TextStyles.font16BoldWhite,
                    onPressed: () {})
              ],
            ),
          );
        } else {
          return Scaffold(
            bottomNavigationBar: CartCubit.get(context).cartResponse.isEmpty
                ? SizedBox.shrink()
                : Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        top: 10.h, bottom: 12.h, right: 18.w, left: 18.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextButton(
                            buttonWidth: 118,
                            buttonHeight: 43.h,
                            buttonText:
                                "${CartCubit.get(context).cartResponse.length} ${S.of(context).Items}",
                            backgroundColor: Colors.white,
                            borderColor: Color(0xffE5E7EB),
                            textStyle: TextStyles.font14BlackRegular,
                            onPressed: () {}),
                        AppTextButton(
                            buttonWidth: 205,
                            buttonHeight: 43.h,
                            buttonText: S.of(context).Checkout,
                            textStyle: TextStyles.font16BoldWhite,
                            onPressed: () {
                              context.pushNamed(Routes.checkOutScreen);
                            })
                      ],
                    ),
                  ),
            backgroundColor: Color(0xffFAFAFA),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 22.h),
              children: [
                CartHeader(
                  cartItems: CartCubit.get(context).cartResponse.length,
                ),
                verticalSpace(24),
                FreeDeleveryProgress(
                  currentAmount: CartCubit.get(context).subtotal,
                ),
                verticalSpace(24),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    final cart = CartCubit.get(context).cartResponse;
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: PageScrollPhysics(),
                        itemCount: cart.length,
                        separatorBuilder: (context, index) => verticalSpace(12),
                        itemBuilder: (context, index) {
                          return CartItemContainer(cart: cart, index: index);
                        });
                  },
                ),
                verticalSpace(24),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xA000000), // Shadow color
                          blurRadius: 10.r,
                          offset: Offset(0, -8.h), // Shadow position
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).paymentsummary,
                        style: TextStyles.font16BlackRegular
                            .copyWith(fontWeight: FontWeightHelper.medium),
                      ),
                      verticalSpace(13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).Subtotal,
                            style: TextStyles.font14BlackRegular
                                .copyWith(fontWeight: FontWeightHelper.medium),
                          ),
                          Text(
                            CartCubit.get(context).subtotal.toString(),
                            style: TextStyles.font14SeconderyBold
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                      // verticalSpace(13),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       S.of(context).Discount,
                      //       style: TextStyles.font14BlackRegular
                      //           .copyWith(fontWeight: FontWeightHelper.medium),
                      //     ),
                      //     Text(
                      //       '200',
                      //       style: TextStyles.font14SeconderyBold
                      //           .copyWith(color: Colors.black),
                      //     ),
                      //   ],
                      // ),
                      verticalSpace(13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).ShippingFee,
                            style: TextStyles.font14BlackRegular
                                .copyWith(fontWeight: FontWeightHelper.medium),
                          ),
                          Text(
                            CartCubit.get(context).seppingFee.toString(),
                            style: TextStyles.font14SeconderyBold
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                      verticalSpace(13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).Total,
                            style: TextStyles.font14BlackRegular
                                .copyWith(fontWeight: FontWeightHelper.medium),
                          ),
                          Text(
                            CartCubit.get(context).totalusd.toString(),
                            style: TextStyles.font14SeconderyBold
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

class CartItemContainer extends StatelessWidget {
  const CartItemContainer({
    super.key,
    required this.cart,
    required this.index,
  });

  final List<CartItem> cart;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.productScreen,
            arguments: cart[index].product.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0x1A000000)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppCachedNetworkImage(
              image: cart[index].product.image,
              width: 162.w,
              height: 139.h,
              radius: 7.6.r,
            ),
            SizedBox(
              width: 145.w,
              height: 116.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cart[index].product.name,
                    style: TextStyles.font24BlackBold.copyWith(fontSize: 16.sp),
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).Color,
                        style: TextStyles.font14BlackRegular
                            .copyWith(fontWeight: FontWeightHelper.medium),
                      ),horizontalSpace(8),
                      Container( width: 22.w,
                        height: 19.h,
                        decoration: BoxDecoration(
                            color: cart[index].variant.colorHex==null?Colors.transparent:Color(int.parse(
                                '0xff${cart[index].variant.colorHex?.replaceAll("#", '')}')),
                            borderRadius: BorderRadius.circular(4.r)),)
                    ],
                  ),
                  PriceDisplay(
                    discountPrice: null,
                    basePrice: cart[index].lineTotalUsd,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Color(0xffFAFAFA),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  CartCubit.get(context).addToCart(
                                      cart[index].variant.id,
                                      cart[index].quantity + 1,
                                      index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                          BorderRadius.circular(3.33.r)),
                                  child: Icon(
                                    Icons.add_rounded,
                                    color: Colors.white,
                                  ),
                                )),
                            horizontalSpace(14),
                            Text(
                              '${cart[index].quantity}',
                              style: TextStyles.font18BlackMedium
                                  .copyWith(fontSize: 16.sp),
                            ),
                            horizontalSpace(14),
                            GestureDetector(
                                onTap: () {
                                  if (cart[index].quantity > 1) {
                                    CartCubit.get(context).addToCart(
                                        cart[index].variant.id,
                                        cart[index].quantity - 1,
                                        index);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(3.33.r)),
                                  child: Icon(
                                    Icons.remove_rounded,
                                    color: ColorsManager.kPrimaryColor,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          CartCubit.get(context).deleteCartItem(cart[index].id);
                        },
                        child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Color(0xffFAFAFA),
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(color: Color(0xffD3D6DA))),
                            child: Image.asset(AssetsData.delete,
                                height: 16.h, width: 16.w)),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CartHeader extends StatelessWidget {
  const CartHeader({
    super.key,
    required this.cartItems,
  });
  final int cartItems;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).Cart,
          style: TextStyles.font36BlackBold.copyWith(fontSize: 16.sp),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          decoration: BoxDecoration(
              color: Color(0xffFFF1DA),
              borderRadius: BorderRadius.circular(4.r)),
          child: Row(
            children: [
              Text(
                cartItems.toString(),
                style: TextStyles.font36BlackBold.copyWith(fontSize: 16.sp),
              ),horizontalSpace(4),
              Text(
                S.of(context).Products,
                style: TextStyles.font14BlackRegular,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class FreeDeleveryProgress extends StatelessWidget {
  FreeDeleveryProgress({
    super.key,
    required this.currentAmount,
  });
  final int currentAmount;

  @override
  Widget build(BuildContext context) {
    final double progress = (currentAmount / 850) * 100;
    return Container(
      padding: EdgeInsets.all(1), // 👈 border thickness
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7A1E1E),
            Color(0xffFAFAFA),
            Color(0xffFAFAFA),
            Color(0xffFAFAFA),
            Color(0xffFAFAFA),
            Color(0xFF7A1E1E),
          ],
        ),
        // border color
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              AssetsData.shopBike,
              height: 40.h,
              width: 40.w,
            ),
            horizontalSpace(8),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add 850 EGP to cart and get free shipping!  ",
                      style: TextStyles.font18BlackMedium
                          .copyWith(fontSize: 12.sp),
                    ),
                    progress >= 100
                        ? Icon(
                            Icons.check_circle,
                            color: Color(0xff922F34),
                            size: 18.sp,
                          )
                        : Text(
                            ' ${progress.toStringAsFixed(0)}%',
                            style: TextStyles.font12GryBold
                                .copyWith(color: Color(0xff922F34)),
                          )
                  ],
                ),
                verticalSpace(10),
                SizedBox(
                  width: 250.w,
                  child: LinearProgressIndicator(
                    value: currentAmount / 850,
                    backgroundColor: Colors.black12,
                    borderRadius: BorderRadius.circular(4.r),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff922F34)),
                    minHeight: 6.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
