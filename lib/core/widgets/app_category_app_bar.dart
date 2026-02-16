//
// import 'package:flutter/material.dart';
//
// import '../helpers/spacing.dart';
// import '../theming/colors.dart';
// import '../theming/styles.dart';
// import '../utils/assets.dart';
// import 'custom_svg.dart';
//
// class CategoryAppBar extends StatelessWidget {
//   const CategoryAppBar(
//       {super.key,
//       required this.title,
//       this.width,
//       this.content,
//       this.btn1,
//       this.btn2,
//       this.onTap1,
//       this.onTap2,
//       this.onTap3});
//   final String title;
//   final double? width;
//   final Widget? content;
//   final Widget? btn1;
//   final Widget? btn2;
//   final void Function()? onTap1;
//   final void Function()? onTap2;
//   final void Function()? onTap3;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         InkWell(
//             onTap: onTap1 ?? () {},
//             child: content ??
//                 const CustomSvg(
//                   imgPath: AssetsData.notification,
//                 )),
//         horizontalSpace(width ?? 90),
//         Text(
//           title,
//           style: TextStyles.font16BlackRegular,
//         ),
//         const Spacer(),
//         InkWell(
//             onTap: onTap2 ?? () {},
//             child: btn1 ??
//                 const CustomSvg(
//                   imgPath: AssetsData.search,
//                   color: ColorsManager.kPrimaryColor,
//                 )),
//         horizontalSpace(15),
//         InkWell(
//             onTap: onTap3 ?? () {},
//             child: btn2 ??
//                 const CustomSvg(
//                   imgPath: AssetsData.favriote,
//                 )),
//       ],
//     );
//   }
// }
