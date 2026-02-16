import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/font_weight.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/add_address/data/model/address_model.dart';
import 'package:khouyot/features/favourites/ui/screen/favourite_screen.dart';
import 'package:khouyot/features/my_orders/logic/orders_cubit.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/image_network.dart';
import '../../../../generated/l10n.dart';
import '../../../checkout/ui/screens/order_details_screen.dart';
import '../../data/model/orders_model.dart';

class TrackYourOrderScreen extends StatefulWidget {
  const TrackYourOrderScreen({super.key, required this.orderItems});
  final MyOrderModel orderItems;

  @override
  State<TrackYourOrderScreen> createState() => _TrackYourOrderScreenState();
}

class _TrackYourOrderScreenState extends State<TrackYourOrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrdersCubit.get(context).getSingleAddress(widget.orderItems.addressId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          children: [
            CustomAppBarScreen(title: S.of(context).trackyourorder),
            verticalSpace(20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Text(
                '${S.of(context).orderid}${widget.orderItems.id}',
                style: TextStyles.font14SeconderyBold
                    .copyWith(color: Color(0xffB93C41)),
                textAlign: TextAlign.center,
              ),
            ),
            verticalSpace(24),
            BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, state) {
                if (state is getAddressLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.kPrimaryColor,
                    ),
                  );
                } else if (OrdersCubit.get(context).addressModel == null) {
                  return SizedBox.shrink();
                } else {
                  final addressModel = OrdersCubit.get(context).addressModel;
                  return DeliveryInfo(addressModel: addressModel);
                }
              },
            ),
            verticalSpace(24),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 24.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).OrderDetails,
                    style: TextStyles.font36BlackBold.copyWith(fontSize: 16.sp),
                  ),
                  verticalSpace(32),
                  OrderDetailsContainer(
                    orderResponse: widget.orderItems.createdAt
                        .toString()
                        .replaceRange(10, null, ''),
                    title: S.of(context).Data,
                  ),
                  verticalSpace(24),
                  OrderDetailsContainer(
                    orderResponse: widget.orderItems.payment == 'cod'
                        ? S.of(context).CashonDelivery
                        : S.of(context).CreditCard,
                    title: S.of(context).PaymentMethod,
                  ),
                  verticalSpace(24),
                  OrderDetailsContainer(
                    orderResponse:
                        "${widget.orderItems.total.toString()} ${S.of(context).EGP}",
                    title: S.of(context).TotalAmount,
                  ),
                ],
              ),
            ),
            verticalSpace(24),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 10.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).ProductInformation,
                    style: TextStyles.font36BlackBold.copyWith(fontSize: 16.sp),
                  ),
                  verticalSpace(24),
                  ListView.separated(
                      separatorBuilder: (context, index) => verticalSpace(16),
                      itemCount: widget.orderItems.orderItems.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return OrdersItemsDetailsContainer(
                          myOrderModel: widget.orderItems.orderItems[index],
                          items: widget.orderItems.orderItems[index].quantity,
                          status: widget.orderItems.status,
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({
    super.key,
    required this.addressModel,
  });

  final AddressesModel? addressModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
            decoration: BoxDecoration(
                color: Color(0xffFFF1DA),
                borderRadius: BorderRadius.circular(6.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AssetsData.safeDelivery,
                  height: 20.h,
                  width: 20.w,
                ),
                Text(
                  S.of(context).DeliveryAddress,
                  style:
                      TextStyles.font24KprimaryMedium.copyWith(fontSize: 14.sp),
                )
              ],
            ),
          ),
          verticalSpace(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(AssetsData.call, height: 18.h, width: 18.w),
                  horizontalSpace(8),
                  Text(
                    addressModel!.phoneNumber,
                    style:
                        TextStyles.font16BlackRegular.copyWith(fontSize: 12.sp),
                  )
                ],
              ),
              verticalSpace(11),
              Row(
                children: [
                  Image.asset(AssetsData.loccation, height: 18.h, width: 18.w),
                  horizontalSpace(8),
                  Text(
                    addressModel?.street ?? "",
                    style:
                        TextStyles.font16BlackRegular.copyWith(fontSize: 12.sp),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class OrdersItemsDetailsContainer extends StatelessWidget {
  const OrdersItemsDetailsContainer({
    super.key,
    required this.myOrderModel,
    required this.status,
    required this.items,
  });
  final OrderItemModel myOrderModel;
  final String status;
  final int items;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Color(0x1A000000))),
          child: Row(
            children: [
              AppCachedNetworkImage(
                image: myOrderModel.product.imagesUrls[0],
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
                          myOrderModel.product.name,
                          style: TextStyles.font14SeconderyBold
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          myOrderModel.price.toString(),
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
                          child: Text(items.toString()),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        verticalSpace(12),
        status
        =="pending"?SizedBox.shrink():GestureDetector(
          onTap: (){
            context.pushNamed(Routes.reviewProduct,arguments: myOrderModel);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 11.5.h,horizontal: 8.w),
            decoration: BoxDecoration(
                color: Color(0xffF8E8E9),
                borderRadius: BorderRadius.circular(16.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).reviewProduct,
                  style: TextStyles.font14KprimaryRegular
                      .copyWith(fontWeight: FontWeightHelper.medium),
                ),
                Icon(Icons.arrow_forward_ios_rounded,size: 14.sp,)
              ],
            ),
          ),
        )
      ],
    );
  }
}
