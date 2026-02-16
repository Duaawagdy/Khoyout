import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/features/categories_screen/logic/categories_cubit.dart';

import '../../../../core/routing/routes.dart';
import '../../../../generated/l10n.dart';
import '../../../favourites/logic/fav_cubit.dart';
import '../../../favourites/ui/screen/favourite_screen.dart';
import '../../../home/ui/widgets/product_card.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({super.key, required this.title, required this.id});
  final String title;
  final int id;
  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoriesCubit.get(context).getCategoryProducts(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: CustomAppBarScreen(title: widget.title),
            ),
            verticalSpace(16),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                if (state is GetCategoriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.kPrimaryColor,
                    ),
                  );
                } else if (CategoriesCubit.get(context).products.isEmpty) {
                  return Center(
                    child: Text(
                      S.of(context).noProductForthisCategory,
                      style: TextStyles.font16BlackRegular.copyWith(color: Colors.black),
                    ),
                  );
                } else {
                  final products = CategoriesCubit.get(context).products;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: BlocBuilder<FavCubit, FavState>(
                      builder: (context, state) {
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          // Important for ListView
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 18.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: 0.78,
                          ),
                          shrinkWrap: true,
                          itemCount: products.length,
                          // This should now be safe
                          itemBuilder: (context, index) {
                            final isFavorite = FavCubit.get(context)
                                .favs
                                .any((e) => e.id == products[index].id);
                            // Safety check
                            if (index >= products.length) {
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
                              storeProduct: products[index],
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
