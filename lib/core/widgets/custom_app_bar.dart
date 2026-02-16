import 'package:flutter/material.dart';

import '../theming/styles.dart';

class CustomAppBar extends StatelessWidget {
  final IconData barIcon;
  final String title;
  final VoidCallback onPressed;
  const CustomAppBar({super.key, required this.barIcon, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric( vertical: 10),
      child: Row(
        children: [
            IconButton(onPressed: onPressed, icon:  Icon(barIcon, size: 25,)),
            Text(title, style: TextStyles.font18BlackMedium,),
        ],
      ),
    );
  }
}