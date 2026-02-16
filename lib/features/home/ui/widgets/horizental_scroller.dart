import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/cubit/localization_cubit.dart';
import '../../../../core/theming/colors.dart';

class HorizontalScrollWithIndicator extends StatefulWidget {
  const HorizontalScrollWithIndicator({
    super.key,
    required this.scrollController,
    required this.itemCount,
    this.itemWidth = 162.0,
    this.indicatorWidth = 25.0,
    this.trackWidth = 82.0,
    this.trackColor = const Color(0xffFFF7EB),
    this.indicatorColor,
  });

  final ScrollController scrollController;
  final int itemCount;
  final double itemWidth;
  final double indicatorWidth;
  final double trackWidth;
  final Color trackColor;
  final Color? indicatorColor;

  @override
  State<HorizontalScrollWithIndicator> createState() =>
      _HorizontalScrollWithIndicatorState();
}

class _HorizontalScrollWithIndicatorState
    extends State<HorizontalScrollWithIndicator> {
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;

    setState(() {
      _scrollPosition = widget.scrollController.offset;
    });
  }

  /// Calculate scroll percentage (0.0 to 1.0)
  double _calculateScrollPercent() {
    final screenWidth = MediaQuery.of(context).size.width;
    final totalScrollWidth = _calculateTotalScrollWidth(screenWidth);

    if (totalScrollWidth <= 0) return 0.0;

    return (_scrollPosition / totalScrollWidth).clamp(0.0, 1.0);
  }

  /// Calculate total scrollable width
  double _calculateTotalScrollWidth(double screenWidth) {
    final totalContentWidth = widget.itemWidth.w * (widget.itemCount + 1);
    return totalContentWidth - screenWidth;
  }

  /// Calculate indicator position based on scroll
  double _calculateIndicatorPosition() {
    final scrollPercent = _calculateScrollPercent();
    final availableTrackSpace = widget.trackWidth.w - widget.indicatorWidth.w;

    return scrollPercent * availableTrackSpace;
  }

  /// Determine if RTL (Right-to-Left) layout
  bool _isRTL() {
    return LocalizationCubit.get(context).locale.languageCode == 'ar';
  }

  /// Determine track width based on item count
  double _getTrackWidth() {

    return widget.itemCount < 2 ? 40.w : widget.trackWidth.w;
  }

  @override
  Widget build(BuildContext context) {
    // Hide indicator if not needed
    if (widget.itemCount <= 1) {
      return const SizedBox.shrink();
    }

    final indicatorPosition = _calculateIndicatorPosition();
    final trackWidth = _getTrackWidth();

    return Transform.flip(
      flipX: _isRTL(),
      child: Container(
        width: trackWidth,
        height: 15.h,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: widget.trackColor,
          borderRadius: BorderRadius.circular(36.r),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              left: indicatorPosition,
              child: Container(
                width: widget.indicatorWidth.w,
                height: 7.h,
                decoration: BoxDecoration(
                  color: widget.indicatorColor ?? ColorsManager.kPrimaryColor,
                  borderRadius: BorderRadius.circular(36.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}