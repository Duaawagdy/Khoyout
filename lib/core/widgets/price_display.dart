import 'package:flutter/material.dart';

import '../../features/home/data/model/product_model.dart';
import '../../generated/l10n.dart';
import '../helpers/spacing.dart';
import '../theming/font_weight.dart';
import '../theming/styles.dart';

class PriceDisplay extends StatelessWidget {
  const PriceDisplay({
    super.key, required this.discountPrice, required this.basePrice,

  });

  final num ?discountPrice;
  final num basePrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${discountPrice??basePrice}  ',
          style: TextStyles.font18BlackMedium
              .copyWith(
              fontWeight:
              FontWeightHelper.bold),
        ),
        Text(S.of(context).EGP,
            style: TextStyles.font16BoldWhite
                .copyWith(
                color: Color(0xff922F34))),
        horizontalSpace(4),
        discountPrice==null?SizedBox.shrink():Text(
          '$basePrice ${S.of(context).EGP}',style: TextStyles.font12GryBold.copyWith(decoration: TextDecoration.lineThrough),)
      ],
    );
  }
}
