import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/di/Dependency_inj.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/features/favourites/logic/fav_cubit.dart';
import 'package:khouyot/features/home/ui/widgets/product_card.dart';
import 'package:khouyot/features/search/logic/search_cubit.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/utils/assets.dart';
import '../../../../generated/l10n.dart';
import 'filter_sheet.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  top: 33.h, bottom: 24.h, start: 18.w, end: 18.w),
              decoration: BoxDecoration(
                  color: ColorsManager.kPrimaryColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(24.r),
                      bottomLeft: Radius.circular(24.r))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.w, vertical: 9.5.h),
                      child: Image.asset(
                        AssetsData.back,
                        width: 24.w,
                        color: Colors.white,
                        height: 24.w,
                      ),
                    ),
                  ),
                  AppTextFormField(
                    hintText: S.of(context).Whatareyoulookingfor,
                    width: 259.w,
                    onFieldSubmitted: (s) {
                      if (s.trim().isNotEmpty) {
                        SearchCubit.get(context).getSearchProducts(s);
                      }
                    },
                    backgroundColor: Colors.white,
                    borderRadius: 8.r,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xffE5E7EB))),
                    hintStyle: TextStyles.font14DarkGreyRegular
                        .copyWith(fontSize: 12.sp),
                    prefexIcon: Padding(
                      padding:
                          EdgeInsetsDirectional.only(start: 16.w, end: 12.w),
                      child: Image.asset(
                        AssetsData.search,
                        scale: 0.5,
                        width: 16.w,
                        height: 16.h,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      SearchCubit.get(context).getAvailableFilter();
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => BlocProvider.value(
  value: getIt<SearchCubit>(),
  child: FilterBottomSheet(),
),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.5.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Image.asset(
                        AssetsData.filter,
                        width: 24.w,
                        height: 24.w,
                      ),
                    ),
                  )
                ],
              ),
            ),
            verticalSpace(24),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                final search = SearchCubit.get(context).searchProducts;

                if (state is GetSearchProductsLoading) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: CircularProgressIndicator(
                        color: ColorsManager.kPrimaryColor,
                      ),
                    ),
                  );
                } else if (state is GetSearchProductsError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 100.h),
                      child: Text(
                        S.of(context).somethingWentWrong,
                        style: TextStyles.font16BlackRegular,
                      ),
                    ),
                  );
                } else if (search.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64.sp,
                            color: Colors.grey,
                          ),
                          verticalSpace(16),
                          Text(
                            S.of(context).Whatareyoulookingfor,
                            style: TextStyles.font16BlackRegular,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: BlocBuilder<FavCubit, FavState>(
                      builder: (context, state) {
                        return GridView.builder(
                          physics:
                              NeverScrollableScrollPhysics(), // Important for ListView
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 18.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: 0.78,
                          ),
                          shrinkWrap: true,
                          itemCount: search.length, // This should now be safe
                          itemBuilder: (context, index) {
                            final isFavorite = FavCubit.get(context)
                                .favs
                                .any((e) => e.id == search[index].id);
                            // Safety check
                            if (index >= search.length) {
                              return SizedBox.shrink();
                            }

                            return ProductCard(
                              itemQuantity: 0,
                              backgroundColor: Colors.white,

                              onTap: () {
                                context.pushNamed(Routes.productScreen,
                                    arguments: search[index].id);
                              },
                              isFavorite: isFavorite,
                              onFavoriteTap: () {
                                FavCubit.get(context)
                                    .toggleFav(search[index].id ?? 0);
                              },
                              storeProduct: search[index],
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FilterBar extends StatelessWidget {
  const FilterBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).Filter,
                style: TextStyles.font18BlackMedium.copyWith(fontSize: 16.sp),
              ),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Image.asset(
                  AssetsData.squareClose,
                  width: 36.w,
                  height: 36.w,
                ),
              ),
            ],
          ),
          verticalSpace(12),
          Divider(
            color: Color(0xffCCCCCC),
          )
        ],
      ),
    );
  }
}
