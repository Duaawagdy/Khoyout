import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/features/home/data/model/offers_model.dart';
import 'package:khouyot/features/home/ui/widgets/offer_item.dart';

import '../../../../core/theming/colors.dart';

class HomeBanner extends StatefulWidget {
   HomeBanner({super.key, required this.offers});
final List<Offer> offers;
  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final PageController _controller = PageController();
  int currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 190.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.offers.length,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemBuilder: (context, index) {
              return OffersHeroItem(offer: widget.offers[index],);
            },
          ),
        ),

        SizedBox(height: 12.h),

        /// Indicator
        BannerIndicator(
          count: widget.offers.length,
          currentIndex: currentIndex,
        ),
      ],
    );
  }
}
class BannerIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const BannerIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 4.h),
      decoration: BoxDecoration(color: Color(0xffFFF7EB),borderRadius: BorderRadius.circular(36.r)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          count,
              (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: currentIndex == index ? 24.w : 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? Color(0xff6C2326)
                  : Colors.white,
              borderRadius: BorderRadius.circular(11.r),
            ),
          ),
        ),
      ),
    );
  }
}
