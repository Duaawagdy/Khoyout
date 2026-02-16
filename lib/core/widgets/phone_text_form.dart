// import 'package:e_commerse_app/core/theming/colors.dart';
// import 'package:e_commerse_app/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
//
// class PhoneTextForm extends StatelessWidget {
//   PhoneTextForm({super.key, required this.onChanged, required this.controller});
//   final Function(String) onChanged;
//   final TextEditingController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return IntlPhoneField(
//       keyboardType: TextInputType.phone,
//       decoration: InputDecoration(
//         labelStyle: const TextStyle(overflow: TextOverflow.ellipsis),
//         contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15.r)),
//           borderSide: const BorderSide(color: ColorsManager.grey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15.r)),
//           borderSide: const BorderSide(color: ColorsManager.darkBlue),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15.r)),
//           borderSide: const BorderSide(color: Colors.red),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15.r)),
//           borderSide: const BorderSide(color: Colors.red),
//         ),
//       ),
//       controller: controller,
//       initialCountryCode: 'EG',
//       onChanged: (phone) {
//         onChanged(phone.completeNumber);
//       },
//       validator: (phone) {
//         if (phone == null || phone.number.isEmpty) {
//           return S.of(context).Pleaseenteraphonenumber;
//         }
//         return null; // Return null if the input is valid
//       },
//     );
//   }
// }
