//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../generated/l10n.dart';
// import '../theming/colors.dart';
// import '../theming/styles.dart';
//
// class AsGuestContainer extends StatelessWidget {
//   const AsGuestContainer({super.key,});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 350.w,
//       height: 150.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: ColorsManager.lighKPrimaryColor),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             S.of(context).AhlanNicetomeetyou,
//             style: TextStyles.font20BlackMedium,
//           ),
//           Text(
//             S.of(context).AhlanNicetomeetyouDes,
//             style: TextStyles.font16DarkerGreyRegular,
//           ),
//           verticalSpace(10),
//           AppTextButton(
//             buttonText: S.of(context).SignInSignUp,
//             textStyle: TextStyles.font16DarkerGreyRegular,
//             onPressed: () {
//               context.pushNamedAndRemoveUntil(
//                 Routes.enteranceScreen,
//                 predicate: (route) => false,
//               );
//             },
//             backgroundColor: ColorsManager.lighKPrimaryColor,
//             buttonWidth: 300,
//             buttonHeight: 44,
//             //verticalPadding: 4.h,
//             borderRadius: 10.r,
//           ),
//         ],
//       ),
//     );
//   }
// }
