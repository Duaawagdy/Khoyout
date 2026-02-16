import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvg extends StatelessWidget {
  final String imgPath;
  final Color? color;
  const CustomSvg({super.key, required this.imgPath, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imgPath,
      fit: BoxFit.scaleDown,
      color: color,
    );
  }
}
