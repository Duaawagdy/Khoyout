import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/features/add_address/data/model/address_model.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../generated/l10n.dart';
import '../../../favourites/ui/screen/favourite_screen.dart';
import '../../data/model/add_address_model.dart';
import '../../logic/address_cubit.dart';
import '../widgets/add_address_state_ui.dart';
import 'address_details.dart';

class EditAddressScreen extends StatefulWidget{
  const EditAddressScreen({super.key, required this.addressModel});
  final AddressesModel addressModel;

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    addressController.text=widget.addressModel.street;
    areaController.text=widget.addressModel.country;
    cityCon.text=widget.addressModel.city;
    buildingCon.text=widget.addressModel.buildingNumber;
    appController.text=widget.addressModel.apartmentNumber??'';
    phoneController.text=widget.addressModel.phoneNumber;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
          child: AppTextButton(
              buttonText: S.of(context).SaveAddress,
              textStyle: TextStyles.font16BoldWhite,
              onPressed: () {
                AddressCubit.get(context).editAddress(AddAddressModel(
                    street: addressController.text,
                    city: cityCon.text,
                    country: 'egypt',
                    buildingNumber: buildingCon.text,
                    apartmentNumber: appController.text,
                    phoneNumber: phoneController.text,
                    isDefault: 0),widget.addressModel.id);
              }
              ),
        ),
        backgroundColor: Color(0xffFAFAFA),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
          children: [
            CustomAppBarScreen(title: S.of(context).editAddress),
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
            PhoneFieldWidget(
              title: S.of(context).phone,
              controller: phoneController,
              onAddPressed: () {
                // إضافة رقم تاني
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).MustnotBeEmpty;
                }
                if (value.length < 10) {
                  return S.of(context).invalidPhone;
                }
                return null;
              },
            ),
            AddAddressStateUi(),
          ],
        ),
      ),
    );
  }
}