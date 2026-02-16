import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/features/home/data/model/product_model.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../generated/l10n.dart';
import '../../../favourites/logic/fav_cubit.dart';
import '../../logic/home_cubit.dart';
import '../screens/home_screen.dart';
import 'featured_product_card.dart';
import 'horizental_scroller.dart';

class FeaturedProducts extends StatefulWidget {
  const FeaturedProducts({
    super.key, required this.products, required this.favs,
  });
final List<ProductModel> products;
final List<ProductModel> favs;
  @override
  State<FeaturedProducts> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      decoration: BoxDecoration(
          color: ColorsManager.kPrimaryColor,
          image: DecorationImage(
            alignment: Alignment.topRight,
            image: AssetImage('assets/featured-frame.png'),
          )),
      child: Column(
        children: [
          verticalSpace(12),
          ViewAll(
            title: S.of(context).FeaturedProducts,
            textcolor: Colors.white,
            onTapView: (){
              context.pushNamed(
                Routes.viewAllProduct,
                arguments: {
                  'title': S.of(context).FeaturedProducts,
                  'products': widget.products,
                },
              );
            },
          ),
          verticalSpace(20),
          SizedBox(
            height: 208.h,
            child: ListView.separated(
              controller: _scrollController,
              separatorBuilder: (context, index) {
                return horizontalSpace(15);
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return FeaturedProductCard(
                  itemQuantity: widget.products[index].cartQuantity,
                  onTap: () {
                    context.pushNamed(Routes.productScreen, arguments: widget.products[index].id);

                  },
                  addItem: () {
                    if(HomeCubit.get(context).guestMode==true){
                      showGuestBottomSheet(context);
                    }
                    else {
                      HomeCubit.get(context).addFeatureItem(index);
                    }
                  },
                  isFavorite: widget.products[index].isFavorite
                  // widget.favs.any(
                  //       (e) => e.id == widget.products[index].id,
                  // )
                  ,
                  decrementItem: () {
                    HomeCubit.get(context).removeFeatureItem(index);
                  },
                  onFavoriteTap: () {
                    if(HomeCubit.get(context).guestMode==true){
                      showGuestBottomSheet(context);
                    }
                    else {
                      FavCubit.get(context)
                        .toggleFav(widget.products[index].id??0);
                    }
                  },
                  storeProduct: widget.products[index],
                );
              },
              itemCount: widget.products.length,
            ),
          ),
          verticalSpace(20),
          HorizontalScrollWithIndicator(
            scrollController: _scrollController,
            itemCount: widget.products.length,
          ),
          verticalSpace(20)
        ],
      ),
    );
  }
}
