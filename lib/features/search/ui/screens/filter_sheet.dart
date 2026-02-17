// Size Chip Widget
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/filter_model.dart';
import '../../logic/search_cubit.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool showStockStatus = false;
  bool showCategories = false;
  bool showColors = false;
  bool showCollections = false;
  bool showRatings = false;
  bool showPriceRange = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFAFAFA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      child: SafeArea(
        bottom: true,
        child: Column(
          children: [
            verticalSpace(12),
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).Filter,
                        style: TextStyles.font16BlackRegular.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          AssetsData.squareClose,
                          width: 36.w,
                          height: 36.w,

                        ),
                      ),
                    ],
                  ),
                  Divider(height: 1, color: Color(0xffE5E7EB)),
                ],
              ),
            ),


            // Content
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  final cubit = SearchCubit.get(context);
                  final filters = cubit.filterModel;

                  if (state is GetAvailableFilterLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.kPrimaryColor,
                      ),
                    );
                  }

                  if (filters == null) {
                    return Center(
                      child: Text('No filters available'),
                    );
                  }

                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    children: [
                      verticalSpace(16),

                      // Size Section
                      if (filters.sizes.isNotEmpty) ...[
                        Text(
                          'Size',
                          style: TextStyles.font14BlackRegular.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        verticalSpace(12),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: filters.sizes.map((size) {
                            return SizeChip(
                              size: size,
                              onTap: () => cubit.toggleSize(size),
                            );
                          }).toList(),
                        ),
                        verticalSpace(16),
                      ],

                      // Stock Status Section
                      // FilterExpandableSection(
                      //   title: 'Stock status',
                      //   isExpanded: showStockStatus,
                      //   onTap: () {
                      //     setState(() {
                      //       showStockStatus = !showStockStatus;
                      //     });
                      //   },
                      //   child: Column(
                      //     children: [
                      //       verticalSpace(8),
                      //       StockStatusOption(
                      //         title: 'Availability (${filters.stock.inStockVariants})',
                      //         value: cubit.filterInStock,
                      //         onChanged: (value) {
                      //           cubit.toggleInStock();
                      //         },
                      //       ),
                      //       StockStatusOption(
                      //         title: 'On sale (18)',
                      //         value: cubit.filterOnSale,
                      //         onChanged: (value) {
                      //           cubit.toggleOnSale();
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // verticalSpace(8),

                      // Categories Section
                      FilterExpandableSection(
                        title: S.of(context).Categories,
                        isExpanded: showCategories,
                        onTap: () {
                          setState(() {
                            showCategories = !showCategories;
                          });
                        },
                        child: Column(
                          children: filters.categories.map((category) {
                            return CategoryOption(
                              category: category,
                              isSelected: cubit.selectedCategoryIds.contains(category.id),
                              onTap: () => cubit.toggleCategory(category.id),
                            );
                          }).toList(),
                        ),
                      ),
                      verticalSpace(8),

                      // Colors Section
                      FilterExpandableSection(
                        title: S.of(context).Colors,
                        isExpanded: showColors,
                        onTap: () {
                          setState(() {
                            showColors = !showColors;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: Wrap(
                            spacing: 12.w,
                            runSpacing: 12.h,
                            children: filters.colors.map((color) {
                              return ColorOption(
                                color: color,
                                onTap: () => cubit.toggleColor(color),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      verticalSpace(8),

                      // Collections Section
                      // FilterExpandableSection(
                      //   title: 'Collections',
                      //   isExpanded: showCollections,
                      //   onTap: () {
                      //     setState(() {
                      //       showCollections = !showCollections;
                      //     });
                      //   },
                      //   child: Container(),
                      // ),
                      // verticalSpace(8),

                      // Ratings Section
                      // FilterExpandableSection(
                      //   title: 'Ratings',
                      //   isExpanded: showRatings,
                      //   onTap: () {
                      //     setState(() {
                      //       showRatings = !showRatings;
                      //     });
                      //   },
                      //   child: Container(),
                      // ),
                      // verticalSpace(8),

                      // Price Range Section
                      FilterExpandableSection(
                        title: S.of(context).PriceRange,
                        isExpanded: showPriceRange,
                        onTap: () {
                          setState(() {
                            showPriceRange = !showPriceRange;
                          });
                        },
                        child: PriceRangeSlider(
                          min: filters.price.min,
                          max: filters.price.max,
                          currentMin: cubit.minPrice,
                          currentMax: cubit.maxPrice,
                          onChanged: (min, max) {
                            cubit.updatePriceRange(min, max);
                          },
                        ),
                      ),
                      verticalSpace(100),
                    ],
                  );
                },
              ),
            ),

            // Bottom Buttons
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Reset Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        SearchCubit.get(context).clearFilters();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xff441618)),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Reset',
                          textAlign: TextAlign.center,
                          style: TextStyles.font16BoldWhite.copyWith(
                            color: Color(0xff441618),
                          ),
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(12),
                  // Apply Button
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        SearchCubit.get(context).applyFilters();
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: Color(0xff441618),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: BlocBuilder<SearchCubit, SearchState>(
                          builder: (context, state) {
                            final itemCount = SearchCubit.get(context).filteredProductsCount;
                            return Text(
                              'Apply • $itemCount items',
                              textAlign: TextAlign.center,
                              style: TextStyles.font16BoldWhite,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SizeChip extends StatelessWidget {
  final SizeFilter size;
  final VoidCallback onTap;

  const SizeChip({
    super.key,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: size.isSelected ? Color(0xff441618) : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: size.isSelected ? Color(0xff441618) : Color(0xffE5E7EB),
          ),
        ),
        child: Text(
          size.name,
          style: TextStyles.font14BlackRegular.copyWith(
            color: size.isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// Expandable Section Widget
class FilterExpandableSection extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final Widget child;

  const FilterExpandableSection({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Color(0xffE5E7EB)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyles.font14BlackRegular.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            Divider(height: 1, color: Color(0xffE5E7EB)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: child,
            ),
          ],
        ],
      ),
    );
  }
}

// Stock Status Option
class StockStatusOption extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const StockStatusOption({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.font14BlackRegular,
            ),
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: value ? Color(0xff441618) : Colors.white,
                border: Border.all(
                  color: value ? Color(0xff441618) : Color(0xffE5E7EB),
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: value
                  ? Icon(
                Icons.check,
                color: Colors.white,
                size: 16.sp,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// Category Option
class CategoryOption extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryOption({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              width: 16.w,
              height: 16.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Color(0xff441618) : Color(0xffE5E7EB),
                  width: isSelected ? 5.w : 1.w,
                ),
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: Text(
                category.name,
                style: TextStyles.font14BlackRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Color Option
class ColorOption extends StatelessWidget {
  final ColorFilter color;
  final VoidCallback onTap;

  const ColorOption({
    super.key,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: color.color,
          shape: BoxShape.circle,
          border: Border.all(
            color: color.isSelected ? Color(0xff441618) : Colors.transparent,
            width: 3.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: color.isSelected
            ? Center(
          child: Icon(
            Icons.check,
            color: color.color.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white,
            size: 20.sp,
          ),
        )
            : null,
      ),
    );
  }
}

// Price Range Slider
class PriceRangeSlider extends StatefulWidget {
  final double min;
  final double max;
  final double currentMin;
  final double currentMax;
  final Function(double, double) onChanged;

  const PriceRangeSlider({
    super.key,
    required this.min,
    required this.max,
    required this.currentMin,
    required this.currentMax,
    required this.onChanged,
  });

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(widget.currentMin, widget.currentMax);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${S.of(context).EGP}${_currentRangeValues.start.toInt()}',
              style: TextStyles.font14BlackRegular.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${S.of(context).EGP}${_currentRangeValues.end.toInt()}',
              style: TextStyles.font14BlackRegular.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        RangeSlider(
          values: _currentRangeValues,
          min: widget.min,
          max: widget.max,
          activeColor: Color(0xff441618),
          inactiveColor: Color(0xffE5E7EB),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
            widget.onChanged(values.start, values.end);
          },
        ),
      ],
    );
  }
}