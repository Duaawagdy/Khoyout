import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/features/favourites/ui/screen/favourite_screen.dart';
import 'package:khouyot/features/home/data/model/product_model.dart';

import '../../../../core/di/Dependency_inj.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../../favourites/logic/fav_cubit.dart';
import '../../../search/logic/search_cubit.dart';
import '../../../search/ui/screens/filter_sheet.dart';
import '../widgets/home_bar.dart';
import '../widgets/product_card.dart';

class ViewAllProduct extends StatelessWidget{
  const ViewAllProduct({super.key, required this.title, required this.products});
final String title;
final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Color(0xffFAFAFA),body: 
      SafeArea(
        child: ListView(children: [

          Container(
            padding: EdgeInsetsDirectional.only(
                top: 33.h, bottom: 24.h, start: 18.w, end: 18.w),
            decoration: BoxDecoration(
                color: ColorsManager.kPrimaryColor,
                ),
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
          verticalSpace(16),
          BlocBuilder<SearchCubit,SearchState>(
  builder: (context, state) {
    if (state is GetSearchProductsLoading){
      return Center(child: CircularProgressIndicator(color: ColorsManager.kPrimaryColor,),);
    }
    final productscurrent= SearchCubit.get(context).searchProducts.isEmpty?products:SearchCubit.get(context).searchProducts;
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
                  itemCount: productscurrent.length, // This should now be safe
                  itemBuilder: (context, index) {
                    final isFavorite = FavCubit.get(context)
                        .favs
                        .any((e) => e.id == productscurrent[index].id);
                    // Safety check
                    if (index >= productscurrent.length) {
                      return SizedBox.shrink();
                    }
        
                    return ProductCard(
                      itemQuantity: 0,
                      backgroundColor: Colors.white,
        
                      onTap: () {
                        context.pushNamed(Routes.productScreen,
                            arguments: products[index].id);
                      },
                      isFavorite: isFavorite,
                      onFavoriteTap: () {
                        FavCubit.get(context)
                            .toggleFav(products[index].id ?? 0);
                      },
                      storeProduct: productscurrent[index],
                    );
                  },
                );
              },
            ),
          );
  },
)
        ],),
      ),);
  }
  
}