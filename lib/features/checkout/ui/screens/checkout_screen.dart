import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/functions/snak_bar.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/features/add_address/data/model/address_model.dart';
import 'package:khouyot/features/add_address/logic/address_cubit.dart';
import 'package:khouyot/features/cart_screen/logic/cart_cubit.dart';
import 'package:khouyot/features/checkout/logic/checkout_cubit.dart';
import 'package:khouyot/features/favourites/ui/screen/favourite_screen.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/font_weight.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/image_network.dart';
import '../../../../core/widgets/price_display.dart';
import '../../../../generated/l10n.dart';
import '../../../cart_screen/data/model/cart_reponse_model.dart';
import '../../../home/ui/widgets/horizental_scroller.dart';
import '../widgets/checkout_state_ui.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          child: BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
              final cubit = CheckoutCubit.get(context);
              if (cubit.selectedPayment == 'cod') {
                return SlideToOrderWidget();
              } else if(cubit.selectedPayment == 'cc'){
                return GestureDetector(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                        color: Color(0xff441618),
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Text(
                      S.of(context).SelectPayment,
                      textAlign: TextAlign.center,
                      style:
                      TextStyles.font16BoldWhite,
                    ),
                  ),
                );
              }
                else
             {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                      color: Color(0xffA1A8B0),
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Text(
                    S.of(context).SelectPayment,
                    textAlign: TextAlign.center,
                    style:
                        TextStyles.font16BoldWhite.copyWith(color: Colors.black),
                  ),
                );
              }
            },
          ),
        ),
        backgroundColor: Color(0xffFAFAFA),
        body: ListView(
          // padding: EdgeInsets.symmetric(horizontal: 18.w),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                children: [
                  verticalSpace(20),
                  CustomAppBarScreen(
                    title: S.of(context).Checkout,
                  ),
                  verticalSpace(24),
                  SizedBox(
                    height: 155.h,
                    child: ListView.separated(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CheckoutItemContainer(
                              cart: CartCubit.get(context).cartResponse,
                              index: index);
                        },
                        separatorBuilder: (context, index) {
                          return horizontalSpace(18);
                        },
                        itemCount: CartCubit.get(context).cartResponse.length),
                  ),
                  verticalSpace(12),
                  HorizontalScrollWithIndicator(
                    scrollController: _scrollController,
                    itemCount: CartCubit.get(context).cartResponse.length,
                    itemWidth: 324.w,
                  ),
                ],
              ),
            ),
            verticalSpace(24),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).ShippingAddress,
                    style:
                        TextStyles.font16BoldWhite.copyWith(color: Colors.black),
                  ),
                  verticalSpace(16),
                  BlocBuilder<AddressCubit,AddressState>(
        builder: (context, state) {
      if(state is AddressLoading){
        return Center(child: CircularProgressIndicator(color: ColorsManager.kPrimaryColor,),);
      }else if(AddressCubit.get(context).addresses.isEmpty){
        return SizedBox.shrink();
      }
      else {
        return AddressContainer(addressModel: AddressCubit.get(context).addresses[0],);
      }
        },
      ),
                  verticalSpace(16),
                  AddAddressContainer()
                ],
              ),
            ),
            verticalSpace(24),
            BlocBuilder<CheckoutCubit,CheckoutState>(
        builder: (context, state) {
      return Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).paywith,
                    style:
                        TextStyles.font16BoldWhite.copyWith(color: Colors.black),
                  ),
                  verticalSpace(14),
                  BlocBuilder<CheckoutCubit, CheckoutState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PaymentMethod(
                            image: 'assets/credit-card.png',
                            method: S.of(context).CreditCard,
                            onTap: () {
                              CheckoutCubit.get(context)
                                  .selectPaymentMethod('cc');
                            },
                            value: CheckoutCubit.get(context).selectedPayment ==
                                'cc',
                          ),
                          PaymentMethod(
                            image: 'assets/wallet.png',
                            method: S.of(context).CashonDelivery,
                            onTap: () {
                              CheckoutCubit.get(context)
                                  .selectPaymentMethod('cod');
                            },
                            value: CheckoutCubit.get(context).selectedPayment ==
                                'cod',
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
        },
      ),
            verticalSpace(24),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //verticalSpace(24),
                  // Text(
                  //   S.of(context).CouponCode,
                  //   style:
                  //       TextStyles.font16BoldWhite.copyWith(color: Colors.black),
                  // ),
                  // verticalSpace(12),
                  // ApplyCoupon(),
                  // verticalSpace(24),
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
                          S.of(context).OrderSummary,
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
            ),
            verticalSpace(40),
            CheckoutStateUi()
          ],
        ),
      ),
    );
  }
}
class SlideToOrderWidget extends StatefulWidget {
  const SlideToOrderWidget({super.key});

  @override
  State<SlideToOrderWidget> createState() => _SlideToOrderWidgetState();
}

class _SlideToOrderWidgetState extends State<SlideToOrderWidget> {
  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final double sliderWidth = 40.w;
    final double maxDrag = maxWidth - sliderWidth - 40.w;

    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final cubit = CheckoutCubit.get(context);

        return Container(
          height: 48.h,
          decoration: BoxDecoration(
            color: const Color(0xff441618),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                S.of(context).slideorder,
                style: TextStyles.font16BoldWhite,
              ),

              /// SLIDING BUTTON
              Positioned(
                left: cubit.dragPosition,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    cubit.horizentalDragUpdate(details.delta.dx, maxDrag);
                  },
                  onHorizontalDragEnd: (_) {
                    if (cubit.dragPosition >= maxDrag * 0.9) {
                      // ✅ SLIDE COMPLETED
                      if (AddressCubit.get(context).addresses.isNotEmpty) {
                        cubit.onOrderConfirmed(
                          AddressCubit.get(context).addresses[0],
                        );
                      } else {
                        // Reset position and show error
                        cubit.dragPosition = 0;

                        showSnackBar(
                          context: context,
                          text: S.of(context).pleaseAddAddress,
                        );
                      }
                    } else {
                      // ❌ SLIDE NOT COMPLETED - Reset position
                      cubit.dragPosition = 0;
                      //cubit.emit(DragPositionChanged());
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Image.asset(
                      AssetsData.slideToOrder,
                      width: 40.w,
                      height: 32.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ApplyCoupon extends StatelessWidget {
  const ApplyCoupon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hintText: '',
      backgroundColor: Colors.white,
      hintStyle: TextStyles.font14DarkGreyRegular,
      prefexIcon: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: Image.asset(
          AssetsData.coupon,
          height: 20.h,
          width: 20.w,
        ),
      ),
      suffixIcon: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: ColorsManager.kPrimaryColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            S.of(context).Apply,
            textAlign: TextAlign.center,
            style: TextStyles.font16BoldWhite,
          ),
        ),
      ),
    );
  }
}

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({
    super.key,
    required this.image,
    required this.method,
    required this.value,
    required this.onTap,
  });
  final String image;
  final String method;
  final bool value;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        decoration: BoxDecoration(
            color: value ? Color(0xffF8E8E9) : Colors.white,
            border: Border.all(
              color: value ? Color(0xffB93C41) : Color(0xffCCCCCC),
            ),
            borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              height: 24.sp,
              width: 24.sp,
            ),
            horizontalSpace(10),
            SizedBox(
              width: 66.w,
              child: Text(
                method,
                style: TextStyles.font14BlackRegular,
              ),
            ),
            horizontalSpace(12),
            RoundedCircleCheckbox(value: value, onTap: () {})
          ],
        ),
      ),
    );
  }
}

class RoundedCircleCheckbox extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;

  const RoundedCircleCheckbox({
    super.key,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 20.w,
        height: 20.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: value ? Colors.transparent : Color(0xffE3E3E3),
            width: 1.5.w,
          ),
        ),
        child: Icon(
          Icons.check_circle,
          size: 20.sp,
          color: value ? Color(0xff922F34) : Colors.transparent,
        ),
      ),
    );
  }
}

class AddAddressContainer extends StatelessWidget {
  const AddAddressContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.pushNamed(Routes.addressDetailsScreen);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Color(0xffD3D6DA), width: 0.5.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/add-square.png',
              height: 16.h,
              width: 16.w,
            ),
            horizontalSpace(23),
            Text(
              S.of(context).AddAddress,
              style: TextStyles.font24KprimaryMedium.copyWith(fontSize: 14.sp),
            )
          ],
        ),
      ),
    );
  }
}

class AddressContainer extends StatelessWidget {
  const AddressContainer({
    super.key, required this.addressModel,
  });
final AddressesModel addressModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Color(0xff922F34), width: 0.5.w)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                    color: Color(0xffFFF1DA),
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/safe-delivery.png',
                      height: 20.h,
                      width: 20.w,
                    ),
                    Text('home'),
                  ],
                ),
              ),
              Icon(
                Icons.check_circle,
                color: Color(0xff922F34),
              ),
            ],
          ),
          verticalSpace(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${addressModel.buildingNumber} ${addressModel.street}',
                style: TextStyles.font14BlackRegular.copyWith(fontSize: 12.sp),
              ),
              GestureDetector(
                onTap: (){context.pushNamed(Routes.editAddressScreen,arguments: addressModel);},
                child: Image.asset(
                  'assets/pencil-edit.png',
                  height: 20.h,
                  width: 20.w,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CheckoutItemContainer extends StatelessWidget {
  const CheckoutItemContainer({
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
        width: 339.w,
        padding: EdgeInsets.symmetric(horizontal: 7.r, vertical: 8.h),
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
            horizontalSpace(16),
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
                      ),
                      horizontalSpace(8),
                      Container(
                        width: 22.w,
                        height: 19.h,
                        decoration: BoxDecoration(
                            color: cart[index].variant.colorHex==null?Colors.transparent:Color(int.parse(
                                '0xff${cart[index].variant.colorHex?.replaceAll("#", '')}')),
                            borderRadius: BorderRadius.circular(4.r)),
                      )
                    ],
                  ),
                  PriceDisplay(
                    discountPrice: null,
                    basePrice: cart[index].lineTotalUsd,
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).Quantity,
                        style: TextStyles.font18BlackMedium
                            .copyWith(fontSize: 14.sp),
                      ),
                      horizontalSpace(13),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 2.h),
                        decoration: BoxDecoration(
                            color: Color(0xffFFF1DA),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          cart[index].quantity.toString(),
                          style: TextStyles.font16BoldWhite
                              .copyWith(color: Colors.black),
                        ),
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
