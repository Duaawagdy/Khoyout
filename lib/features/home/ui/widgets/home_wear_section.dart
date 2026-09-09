import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/localization/cubit/localization_cubit.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/features/home/data/model/category_model.dart';

import '../../../../core/routing/routes.dart';
import 'horizental_scroller.dart';

/// ألوان الكروت — الـ API مش بيرجّع لون، فبنلفّ على الباليتة بالترتيب
const _cardPalette = <(Color bg, Color arc)>[
  (Color(0xffFBE9EA), Color(0xff922F34)),
  (Color(0xffEAF7EF), Color(0xff2F7D4F)),
  (Color(0xffFFF4E2), Color(0xffB7791F)),
  (Color(0xffEDEFFB), Color(0xff2B4FA2)),
];

class HomeWearCards extends StatefulWidget {
  const HomeWearCards({super.key, required this.subCategories});

  final List<SubCategory> subCategories;

  @override
  State<HomeWearCards> createState() => _HomeWearCardsState();
}

class _HomeWearCardsState extends State<HomeWearCards> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = LocalizationCubit.get(context).locale.languageCode;

    return Column(
      children: [
        SizedBox(
          height: 320.h,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            separatorBuilder: (_, __) => horizontalSpace(12),
            itemCount: widget.subCategories.length,
            itemBuilder: (context, index) {
              final sub = widget.subCategories[index];
              final palette = _cardPalette[index % _cardPalette.length];

              return _HomeWearCard(
                label: sub.localizedName(locale),
                image: sub.image,
                background: palette.$1,
                arcColor: palette.$2,
                onTap: () => context.pushNamed(
                  Routes.viewCategoryProduct,
                  arguments: {
                    'title': sub.localizedName(locale),
                    'id': sub.categoryId,
                    'sub_category_id': sub.id,
                  },
                ),
              );
            },
          ),
        ),
        verticalSpace(20),
        HorizontalScrollWithIndicator(
          scrollController: _scrollController,
          itemCount: widget.subCategories.length,
        ),
      ],
    );
  }
}

class _HomeWearCard extends StatelessWidget {
  const _HomeWearCard({
    required this.label,
    required this.image,
    required this.background,
    required this.arcColor,
    required this.onTap,
  });

  final String label;
  final String? image;
  final Color background;
  final Color arcColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 265.w,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(16.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // الأقواس الزخرفية جنب الحافة
            PositionedDirectional(
              start: -60.w,
              top: 8.h,
              child: CustomPaint(
                size: Size(120.w, 300.h),
                painter: _ArcsPainter(arcColor),
              ),
            ),

            // صورة الموديل
            PositionedDirectional(
              bottom: 0,
              start: 0,
              end: 0,
              top: 24.h,
              child: image == null || image!.isEmpty
                  ? const SizedBox.shrink()
                  : AppCachedNetworkImage(image: image, fit: BoxFit.contain),
            ),

            // زرار الفتح
            PositionedDirectional(
              top: 14.h,
              end: 14.w,
              child: Container(
                height: 34.r,
                width: 34.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.black87, width: 1.2),
                ),
                child: Icon(Icons.arrow_outward,
                    size: 18.r, color: Colors.black87),
              ),
            ),

            // الاسم
            PositionedDirectional(
              start: 18.w,
              bottom: 22.h,
              child: Text(
                label,
                style: TextStyles.font20BlackMedium.copyWith(fontSize: 24.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArcsPainter extends CustomPainter {
  const _ArcsPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final center = Offset(0, size.height / 2);
    for (final r in [size.height * .48, size.height * .40]) {
      canvas.drawCircle(center + Offset(size.width * .3, 0), r, paint);
    }
  }

  @override
  bool shouldRepaint(_ArcsPainter old) => old.color != color;
}