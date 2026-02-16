import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/add_address/data/model/address_model.dart';
import 'package:khouyot/features/add_address/logic/address_cubit.dart';
import 'package:khouyot/features/favourites/ui/screen/favourite_screen.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

class MyAddressScreen extends StatelessWidget {
  const MyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
        children: [
          CustomAppBarScreen(title: S.of(context).MyAddresses),
          verticalSpace(22),
          AddAddress(),
          verticalSpace(16),
          BlocBuilder<AddressCubit,AddressState>(
  builder: (context, state) {
    if(state is AddressLoading) {
      return Center(child: CircularProgressIndicator(color: Color(0xff922F34),));
    }
    else {
      return ListView.separated(
        shrinkWrap: true,

        separatorBuilder: (context,index) => verticalSpace(16),
        itemCount: AddressCubit.get(context).addresses.length,
        itemBuilder: (context,index) {
          return AddressContainer(addressModel:AddressCubit.get(context).addresses[index] ,);
        }
      );
    }
  },
)
        ],
      ),
    );
  }
  // Implementation of MyAddressScreen
}

class AddressContainer extends StatelessWidget {
  const AddressContainer({
    super.key, required this.addressModel,
  });
final AddressesModel addressModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        AddressCubit.get(context).setDefaultAddress(addressModel.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.r),border: Border.all(color: addressModel.isDefault==0?Color(0xffCFCECE):Color(0xffB93C41), width: 0.5.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(AssetsData.call, height: 18.h, width: 18.w),
          horizontalSpace(8),
                    Text(
                      addressModel.phoneNumber,
                      style: TextStyles.font16BlackRegular
                          .copyWith(fontSize: 12.sp),
                    )
                  ],
                ),verticalSpace(11),Row(
                  children: [
                    Image.asset(AssetsData.loccation, height: 18.h, width: 18.w),
                    horizontalSpace(8),

                    Text(
                      addressModel.street,
                      style: TextStyles.font16BlackRegular
                          .copyWith(fontSize: 12.sp),
                    )
                  ],
                )
              ],
            ),
            Column(children: [
              addressModel.isDefault==0?Icon(Icons.circle_outlined,size: 20.r,color: Color(0xffE3E3E3),):Icon(Icons.check_circle, color: Color(0xffB93C41), size: 20.r),
          verticalSpace(11),
      GestureDetector(onTap:(){context.pushNamed(Routes.editAddressScreen,arguments: addressModel);},child: Image.asset(AssetsData.pencilEdit, height: 18.h, width: 18.w)),
            ],)
          ],
        ),
      ),
    );
  }
}

class AddAddress extends StatelessWidget {
  const AddAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.addressDetailsScreen);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
            color: Color(0xffF8E8E9),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Color(0xffB93C41), width: 0.5.w)),
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
