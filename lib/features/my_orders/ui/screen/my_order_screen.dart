import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/font_weight.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/features/favourites/ui/screen/favourite_screen.dart';
import 'package:khouyot/features/my_orders/data/model/orders_model.dart';
import 'package:khouyot/features/my_orders/logic/orders_cubit.dart';

import '../../../../generated/l10n.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          children: [
            verticalSpace(22),
            CustomAppBarScreen(title: S.of(context).MyOrders),
            verticalSpace(22),
            BlocBuilder<OrdersCubit,OrdersState>(
        builder: (context, state) {
      final cubit= OrdersCubit.get(context);
      return SizedBox(
              height: 37.h,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => horizontalSpace(8),
                  shrinkWrap: true,
                  itemCount: cubit.status.length,
                  itemBuilder: (context, index) {

                    return GestureDetector(
                        onTap:(){
                          cubit.selectStatus(index);

                        },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 23.w, vertical: 8.h),
                        decoration: BoxDecoration(
                            color: cubit.selectedIndex==index?Color(0xffF8E8E9):Colors.transparent,
                            border: Border.all(
                              color: cubit.selectedIndex==index?Color(0xff6C2326):Color(0xffE5E7EB),
                            ),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Text(
                          OrdersCubit.get(context).status[index],
                          style: TextStyles.font12GryBold
                              .copyWith(fontWeight: FontWeightHelper.medium),
                        ),
                      ),
                    );
                  }),
            );
        },
      ),
            BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, state) {
                if (state is OrdersLoading) {
                  return Padding(
                    padding: EdgeInsets.only(top: 18.0.h),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return ListView.separated(
                    separatorBuilder: (context, index) => verticalSpace(16),
                    itemCount:
                        OrdersCubit.get(context).filterdProduct.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          context.pushNamed(Routes.myOrdertDetailsScreen,arguments: OrdersCubit.get(context).filterdProduct[index]);
                        },
                        child: OrdersItemContainer(
                          myOrderModel:
                          OrdersCubit.get(context)
                              .filterdProduct[index]
                              .orderItems[0],
                          items: OrdersCubit.get(context).filterdProduct[index].orderItems.length,
                          status: OrdersCubit.get(context).filterdProduct[index].status,
                        ),
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}

class OrdersItemContainer extends StatelessWidget {
  const OrdersItemContainer({
    super.key,
    required this.myOrderModel, required this.status, required this.items,
  });
  final OrderItemModel myOrderModel;
  final String status;
  final int items;
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                height: 156.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 22.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffE5E7EB),
                          ),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Text(
                        '${S.of(context).orderid} ${myOrderModel.id}',
                        style: TextStyles.font12GryBold
                            .copyWith(color: Color(0xff4D4D4D)),
                      ),
                    ),
                    SizedBox(
                      //  width: 145.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 107.w,
                            child: Text(
                              myOrderModel.product.name,
                              style: TextStyles.font14SeconderyBold
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded,
                              color: Color(0xff757575), size: 15.sp)
                        ],
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
                          S.of(context).Items,
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
                          child: Text( items.toString()),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 12.h,
          left: 12.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: Color(OrdersCubit.get(context).color)),
                borderRadius: BorderRadius.circular(8.r)),
            child: Text(
              status,
              style: TextStyles.font12WhiteMedium
                  .copyWith(color: Color(OrdersCubit.get(context).color)),
            ),
          ),
        )
      ],
    );
  }
}
