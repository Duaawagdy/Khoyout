import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/features/cart_screen/ui/cart_screen_ui.dart';
import 'package:khouyot/features/checkout/data/model/order_response.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/font_weight.dart';
import '../../../../core/widgets/image_network.dart';
import '../../../../core/widgets/price_display.dart';
import '../../../../generated/l10n.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderResponse orderResponse;

  const OrderDetailsScreen({super.key, required this.orderResponse});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: ListView(
          children: [
            verticalSpace(22),
            Text(
              S.of(context).OrderDetails,
              textAlign: TextAlign.center,
              style: TextStyles.font16BoldWhite.copyWith(color: Colors.black),
            ),
            verticalSpace(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Color(0xff922F34),
                  size: 23.sp,
                ),
                horizontalSpace(13),
                Text(
                  S.of(context).Yourorderhasbeenplacedsuccessfully,
                  textAlign: TextAlign.center,
                  style: TextStyles.font18BlackMedium.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            verticalSpace(20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.w),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xffE5E7EB),
                  ),
                  borderRadius: BorderRadius.circular(8.r)),
              child: Text(
                '${S.of(context).orderid}${orderResponse.order.id}',
                style: TextStyles.font14SeconderyBold
                    .copyWith(color: Color(0xffB93C41)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).Status,
                    style: TextStyles.font18BlackMedium.copyWith(fontSize: 14.sp),
                  ),
                  verticalSpace(11),
                  Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 16.r,
                        backgroundColor: Color(0xffF8E8E9),
                        child: Image.asset(
                          AssetsData.package,
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                      horizontalSpace(10),
                      Text(
                        orderResponse.order.status,
                        style: TextStyles.font14BlackRegular
                            .copyWith(fontWeight: FontWeightHelper.bold),
                      ),
                      verticalSpace(9),
                    ],
                  ),
                  verticalSpace(20),
                  OrderStatusBar(status: orderResponse.order.status),
                ],
              ),
            ),
            ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
                shrinkWrap: true,
                physics: PageScrollPhysics(),
                itemCount:orderResponse.order.items.length,
                separatorBuilder: (context, index) => verticalSpace(12),
              itemBuilder: (context,index) {
                return CartProductContainer(cart: orderResponse.order.items, index: index);
              }
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                children: [
                  //verticalSpace(12),
                  OrderDetailsContainer(
                    orderResponse:
                        orderResponse.order.createdAt.replaceRange(10, null, ''),
                    title: S.of(context).Data,
                  ),
                  verticalSpace(24),
                  // OrderDetailsContainer(
                  //   orderResponse:
                  //       orderResponse.order.updatedAt?.replaceRange(10, null, ''),
                  //   title: S.of(context).Deliverydate,
                  // ),
                  //verticalSpace(24),
                  OrderDetailsContainer(
                    orderResponse: orderResponse.paymentMethod == 'cod'
                        ? S.of(context).CashonDelivery
                        : S.of(context).CreditCard,
                    title: S.of(context).PaymentMethod,
                  ),
                  verticalSpace(24),
                  OrderDetailsContainer(
                    orderResponse:
                        "${orderResponse.order.total.toString()} ${S.of(context).EGP}",
                    title: S.of(context).TotalAmount,
                  ),
                  //verticalSpace(24),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0.w,vertical: 24.h),
              child: AppTextButton(
                  buttonText: S.of(context).BackToHome,
                  textStyle:
                      TextStyles.font16BoldWhite.copyWith(color: Colors.black),
                  backgroundColor: Colors.white,
                  borderColor: Color(0xffE5E7EB),
                  onPressed: () {
                    context.pushNamedAndRemoveUntil(Routes.navigationBar,arguments: 0, predicate: (Route<dynamic> route) { return false; });
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class OrderDetailsContainer extends StatelessWidget {
  const OrderDetailsContainer({
    super.key,
    required this.orderResponse,
    required this.title,
  });

  final String orderResponse;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.h),
      decoration: BoxDecoration(
          color: Color(0xffF6F6F6), borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.font14BlackRegular,
              ),
              verticalSpace(8),
              Text(
                orderResponse,
                style: TextStyles.font14SeconderyBold
                    .copyWith(color: Color(0xff666666)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class OrderStatusBar extends StatelessWidget {
  const OrderStatusBar({super.key, required this.status});

  final String status;

  static const _steps = ['pending', 'processing', 'shipped', 'delivered'];
  static const _active = Color(0xff922F34);
  static const _inactive = Color(0xffE0E0E0);
  static const _cancelled = Color(0xffB0B0B0);

  int get _currentStep {
    final s = status.toLowerCase().trim();
    if (s == 'cancelled' || s == 'canceled') return -1;
    final i = _steps.indexOf(s);
    return i == -1 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    final current = _currentStep;
    final isCancelled = current == -1;

    return Row(
      children: List.generate(_steps.length, (index) {
        final reached = !isCancelled && index <= current;

        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              end: index == _steps.length - 1 ? 0 : 8.w,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 4.h,
              decoration: BoxDecoration(
                color: isCancelled
                    ? _cancelled
                    : reached
                    ? _active
                    : _inactive,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
        );
      }),
    );
  }
}
class CartProductContainer extends StatelessWidget {
  const CartProductContainer({
    super.key,
    required this.cart,
    required this.index,
  });

  final List<OrderItem> cart;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.productScreen,
            arguments: cart[index].product?.id);
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
              image: cart[index].product?.image,
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
                    cart[index].product!.name,
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
                            color: cart[index].variant==null?Colors.transparent:Color(int.parse(
                                '0xff${cart[index].variant.colorHex?.replaceAll("#", '')}')),
                            borderRadius: BorderRadius.circular(4.r)),)
                    ],
                  ),
                  PriceDisplay(
                    discountPrice: null,
                    basePrice: cart[index].price,
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
                        child: Text( cart[index].quantity.toString()),
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