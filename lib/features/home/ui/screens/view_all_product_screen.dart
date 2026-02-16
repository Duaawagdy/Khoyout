import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/features/favourites/ui/screen/favourite_screen.dart';
import 'package:khouyot/features/home/data/model/product_model.dart';

import '../../../../core/routing/routes.dart';
import '../../../favourites/logic/fav_cubit.dart';
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

          HomeBar(borderRadius: BorderRadius.all(Radius.zero),),
          verticalSpace(16),
          Padding(
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
                  itemCount: products.length, // This should now be safe
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
          )
        ],),
      ),);
  }
  
}