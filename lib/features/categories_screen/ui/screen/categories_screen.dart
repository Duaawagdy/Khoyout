import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/features/categories_screen/logic/categories_cubit.dart';
import 'package:khouyot/features/home/data/model/category_model.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/localization/cubit/localization_cubit.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/utils/assets.dart';
import '../../../../generated/l10n.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 22.h),
        children: [
          Text(
            S.of(context).Categories,
            textAlign: TextAlign.center,
            style: TextStyles.font36BlackBold.copyWith(fontSize: 16.sp),
          ),
          verticalSpace(14),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is GetCategoriesLoading) {
                return Center(
                  child: CircularProgressIndicator(color: ColorsManager.kPrimaryColor,),
                );
              } else {
                final categories = CategoriesCubit.get(context).categories;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 columns
                    crossAxisSpacing: 18.w,
                    mainAxisSpacing: 28.h,
                    childAspectRatio: 0.8, // Make items taller
                  ),
                  itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        context.pushNamed(Routes.viewCategoryProduct,
                            arguments: {
                              "title":  LocalizationCubit.get(context).locale.languageCode=='ar'?categories[index].name ?? '':categories[index].slug??"",

                              "id": categories[index].id
                            });
                      },
                      child: CategoryItem(
                        category: categories[index],
                      )),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
  });
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 102.w,
      height: 123.h,
      padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xA000000),
            spreadRadius: 0,
            blurRadius: 10.r,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ColorsManager.kPrimaryColor, Color(0xffAA373C)],
              ),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Center(
                child: AppCachedNetworkImage(
              image: category.image,
              width: 58.w,
              radius: 30.r,
              height: 58.h,
            )),
          ),
          verticalSpace(8),
          Text(
            LocalizationCubit.get(context).locale.languageCode=='ar'?category.name ?? '':category.slug??"",
            textAlign: TextAlign.center,
            style: TextStyles.font14BlackRegular,
          )
        ],
      ),
    );
  }
}
