import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/features/add_address/data/model/add_address_model.dart';
import 'package:khouyot/features/add_address/logic/address_cubit.dart';
import 'package:khouyot/features/favourites/ui/screen/favourite_screen.dart';

import '../../../../generated/l10n.dart';
import '../../../auth/ui/widgets/signup_state_ui.dart';
import '../widgets/add_address_state_ui.dart';

class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({super.key});

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityCon = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController buildingCon = TextEditingController();
  TextEditingController appController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addressController.dispose();

    areaController.dispose();
    cityCon.dispose();
    phoneController.dispose();
    buildingCon.dispose();
    appController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
        child: AppTextButton(
            buttonText: S.of(context).SaveAddress,
            textStyle: TextStyles.font16BoldWhite,
            onPressed: () {
              AddressCubit.get(context).addAddress(AddAddressModel(
                  street: addressController.text,
                  city: cityCon.text,
                  country: 'egypt',
                  buildingNumber: buildingCon.text,
                  apartmentNumber: appController.text,
                  phoneNumber: phoneController.text,
                  isDefault: 0));
            }),
      ),
      backgroundColor: Color(0xffFAFAFA),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
        children: [
          CustomAppBarScreen(title: S.of(context).AddAddress),
          verticalSpace(28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 165.w,
                  child: AddressDetailsWidget(
                      title: S.of(context).city, controller: cityCon)),
              SizedBox(
                  width: 165.w,
                  child: AddressDetailsWidget(
                      title: S.of(context).country, controller: areaController)),
            ],
          ),
          verticalSpace(24),
          AddressDetailsWidget(
            title: S.of(context).street,
            controller: addressController,
          ),


          verticalSpace(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 165.w,
                  child: AddressDetailsWidget(
                      title: S.of(context).buildingNumber, controller: buildingCon)),
              SizedBox(
                  width: 165.w,
                  child: AddressDetailsWidget(
                      title: S.of(context).ApartamentNumber, controller: appController)),
            ],
          ),

          verticalSpace(24),
          AddressDetailsWidget(
            title: S.of(context).phone,
            controller: phoneController,
            prefixIcon: Padding(
              padding: EdgeInsetsDirectional.only(start: 10.w),
              child: Text('+20', style: TextStyles.font16BlackRegular),
            ),
          ),
          AddAddressStateUi(),
        ],
      ),
    );
  }
}

class AddressDetailsWidget extends StatelessWidget {
  const AddressDetailsWidget({
    super.key,
    required this.title,
    required this.controller,
    this.prefixIcon,
  });
  final String title;
  final TextEditingController controller;
  final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.font16BlackRegular,
          ),
          verticalSpace(8),
          AppTextFormField(
            hintText: '',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 16.5.h,
            ),
            prefexIcon: prefixIcon,
            backgroundColor: Colors.white,
            hintStyle: TextStyles.font16BlackRegular,
            controller: controller,
            borderRadius: 8.r,
          )
        ],
      ),
    );
  }
}
