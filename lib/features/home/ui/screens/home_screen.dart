import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/font_weight.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/features/favourites/logic/fav_cubit.dart';
import 'package:khouyot/features/home/data/model/category_model.dart';
import 'package:khouyot/features/home/data/model/offers_model.dart';
import 'package:khouyot/features/home/data/model/product_model.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';
import 'package:khouyot/features/home/ui/widgets/home_loader_ui.dart';
import 'package:khouyot/features/nav_bar/logic/nav_bar_cubit.dart';

import '../../../../core/routing/routes.dart';
import '../../../../generated/l10n.dart';
import '../widgets/best_seller_products.dart';
import '../widgets/featured_products.dart';
import '../widgets/home_banner_offers.dart';
import '../widgets/home_bar.dart';
import '../widgets/horizental_scroller.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();

    _homeCubit = HomeCubit.get(context);

    // Load all data
    _homeCubit.getGuestMode();
    _homeCubit.getOffers();
    _homeCubit.getCategories();
    _homeCubit.getProducts();
    _homeCubit.getBestSellerProducts();
    _homeCubit.getFeaturedProducts();
  }

  Future<void> _onRefresh() async {
    // ✅ FIXED: Reuse cached cubit reference
    await Future.wait([
      _homeCubit.getOffers(),
      _homeCubit.getCategories(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: ColorsManager.kPrimaryColor,
      backgroundColor: Colors.white,
      onRefresh: _onRefresh,
      child: Scaffold(
        backgroundColor: ColorsManager.mainWhite,
        body: ListView(
          children: [
            HomeBar(),
            verticalSpace(16),

            // ✅ FIXED: Use BlocSelector for targeted rebuilds
            _OffersSection(),

            verticalSpace(12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                children: [
                  ViewAll(title: S.of(context).Categories,onTapView: (){
                    NavBarCubit.get(context).changeIndex(2);
                  },),
                  verticalSpace(23),

                  // ✅ FIXED: Use BlocSelector
                  _CategoriesSection(),

                  verticalSpace(36),
                ],
              ),
            ),

            // ✅ FIXED: Use BlocSelector
            _GuestModeBannerSection(),

            // ✅ FIXED: Simplified nested BlocBuilders
            _ProductsSection(),

            verticalSpace(36),
            _FeaturedProductsSection(),

            verticalSpace(36),
            _BestSellerProductsSection(),
          ],
        ),
      ),
    );
  }
}

// ✅ OPTIMIZATION: Separate widgets with BlocSelector for targeted rebuilds

class _OffersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(

      builder: (context,state) {
        final offers = context.read<HomeCubit>().offers;
        if (offers.isEmpty&& state is GetOffersLoading) {
          return Center(child: HomeLoaderUI());
        }
        else if (offers.isEmpty) {
          return SizedBox.shrink();
        }

          return HomeBanner(offers: offers);

      },
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, List<Category>>(
      selector: (state) => context.read<HomeCubit>().categories,
      builder: (context, categories) {
        if (categories.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsManager.kPrimaryColor,
            ),
          );
        }
        return Categories(categories: categories);
      },
    );
  }
}

class _GuestModeBannerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, bool>(
      selector: (state) => context.read<HomeCubit>().guestMode,
      builder: (context, guestMode) {
        if (!guestMode) return SizedBox.shrink();
        return GuestModeBanner();
      },
    );
  }
}

class _ProductsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
      current is GetProductsLoading || current is GetProductsSuccess,
      builder: (context, homeState) {
        final products = context.read<HomeCubit>().products;

        if (products.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsManager.kPrimaryColor,
            ),
          );
        }

        return BlocSelector<FavCubit, FavState, List<ProductModel>>(
          selector: (state) => context.read<FavCubit>().favs,
          builder: (context, favs) {
            return Products(
              products: products,
              favs: favs,
            );
          },
        );
      },
    );
  }
}

class _FeaturedProductsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
      current is GetFeaturedProductsLoading ||
          current is GetFeaturedProductsSuccess,
      builder: (context, homeState) {
        final featuredProducts = context.read<HomeCubit>().featuredProducts;

        if (featuredProducts.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsManager.kPrimaryColor,
            ),
          );
        }

        return BlocSelector<FavCubit, FavState, List<ProductModel>>(
          selector: (state) => context.read<FavCubit>().favs,
          builder: (context, favs) {
            return FeaturedProducts(
              products: featuredProducts,
              favs: favs,
            );
          },
        );
      },
    );
  }
}

class _BestSellerProductsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
      current is GetBestProductsLoading || current is GetBestProductsSuccess,
      builder: (context, homeState) {
        final bestSellerProducts = context.read<HomeCubit>().bestSellerProducts;

        if (bestSellerProducts.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsManager.kPrimaryColor,
            ),
          );
        }

        return BlocSelector<FavCubit, FavState, List<ProductModel>>(
          selector: (state) => context.read<FavCubit>().favs,
          builder: (context, favs) {
            return BestSellerProducts(
              products: bestSellerProducts,
              favs: favs,
            );
          },
        );
      },
    );
  }
}

// ===== REST OF THE WIDGETS (NO CHANGES) =====

class GuestModeBanner extends StatelessWidget {
  const GuestModeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        verticalSpace(24),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 12.h),
          width: 339.w,
          height: 67.h,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/guest-frame.png'))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 201.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).Createyouraccount,
                      style: TextStyles.font12GryBold
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      S.of(context).Signuptoenjoysmoother,
                      style: TextStyles.font30WhiteSemiBold
                          .copyWith(fontSize: 8.sp),
                    )
                  ],
                ),
              ),
              Image.asset(
                AssetsData.guestImage,
                height: 32.h,
                width: 32.w,
              )
            ],
          ),
        ),
        verticalSpace(24),
      ],
    );
  }
}

class Products extends StatefulWidget {
  const Products({
    super.key,
    required this.products,
    required this.favs,
  });

  final List<ProductModel> products;
  final List<ProductModel> favs;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      color: Colors.white,
      child: Column(
        children: [
          verticalSpace(12),
          ViewAll(title: S.of(context).Products,haveAll:true,onTapView: (){
            context.pushNamed(
              Routes.viewAllProduct,
              arguments: {
                'title': S.of(context).Products,
                'products': widget.products,
              },
            );
          }),
          verticalSpace(20),
          SizedBox(
            height: 208.h,
            child: ListView.separated(
              controller: _scrollController,
              separatorBuilder: (context, index) => horizontalSpace(15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final product = widget.products[index];
                final isFavorite = widget.favs.any((e) => e.id == product.id);

                return ProductCard(
                  itemQuantity: product.cartQuantity,
                  onTap: () {
                    context.pushNamed(
                      Routes.productScreen,
                      arguments: product.id,
                    );
                  },
                  onFavoriteTap: () {
                    final homeCubit = context.read<HomeCubit>();
                    if (homeCubit.guestMode) {
                      showGuestBottomSheet(context);
                    } else {
                      context.read<FavCubit>().toggleFav(product.id ?? 0);
                    }
                  },
                  addItem: () {
                    final homeCubit = context.read<HomeCubit>();
                    if (homeCubit.guestMode) {
                      showGuestBottomSheet(context);
                    } else {
                      homeCubit.addItem(index);
                    }
                  },
                  isFavorite: isFavorite,
                  decrementItem: () {
                    context.read<HomeCubit>().removeItem(index);
                  },
                  storeProduct: product,
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
          verticalSpace(12)
        ],
      ),
    );
  }
}

void showGuestBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Color(0xffFAFAFA),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
    ),
    builder: (context) {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: Image.asset(
                'assets/close-square.png',
                height: 34.h,
                width: 34.w,
              ),
            ),
          ),
          Image.asset(
            'assets/Signup-cuate.png',
            height: 231.h,
            width: 231.w,
          ),
          verticalSpace(28),
          Text(
            S.of(context).logintoyouraccount,
            textAlign: TextAlign.center,
            style: TextStyles.font20BlackMedium.copyWith(
              fontWeight: FontWeightHelper.semiBold,
            ),
          ),
          verticalSpace(8),
          Text(
            S.of(context).Signintotrackyourorders,
            textAlign: TextAlign.center,
            style: TextStyles.font14BlackRegular,
          ),
          verticalSpace(35),
          AppTextButton(
            buttonText: S.of(context).CreateAccount,
            buttonWidth: 202,
            borderRadius: 8.r,
            buttonHeight: 43.h,
            borderColor: Color(0xffE5E7EB),
            backgroundColor: Colors.white,
            textStyle: TextStyles.font16BoldWhite.copyWith(
              color: Colors.black,
            ),
            onPressed: () {
              context.pop();
              context.pushNamedAndRemoveUntil(Routes.signUpScreen, predicate: (Route<dynamic> route) { return false; });

            },
          ),
          verticalSpace(14),
          AppTextButton(
            buttonText: S.of(context).Login,
            buttonWidth: 121,
            borderRadius: 8.r,
            buttonHeight: 43.h,
            backgroundColor: ColorsManager.kPrimaryColor,
            textStyle: TextStyles.font16BoldWhite.copyWith(
              color: Colors.white,
            ),
            onPressed: () {
              context.pushNamedAndRemoveUntil(Routes.signUpScreen, predicate: (Route<dynamic> route) { return false; });
            },
          )
        ],
      );
    },
  );
}

class ViewAll extends StatelessWidget {
  const ViewAll({
    super.key,
    required this.title,
    this.textcolor, required this.onTapView,this.haveAll
  });

  final String title;
  final Color? textcolor;
  final bool? haveAll;
final Function() onTapView;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.font16BlackRegular.copyWith(
            fontWeight: FontWeightHelper.bold,
            color: textcolor ?? Colors.black,
          ),
        ),
        haveAll==null?SizedBox.shrink():GestureDetector(
          onTap: onTapView,
          child: SizedBox(
            height: 18.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.of(context).ViewAll,
                  style: TextStyles.font14BlackRegular.copyWith(color: textcolor ?? Colors.black,),
                ),
                horizontalSpace(5),
                Image.asset(
                  AssetsData.viewAll,
                  height: 18.h,
                  width: 18.w,
                  color: textcolor ?? Colors.black,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 113.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => horizontalSpace(12),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              context.pushNamed(Routes.viewCategoryProduct,
                  arguments: {
                    "title": categories[index].name,
                    "id": categories[index].id
                  });
            },
            child: SizedBox(
              width: 76.w,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 38.r,
                    child: AppCachedNetworkImage(
                      image: category.image,
                      width: 60.w,
                      height: 52.h,
                    ),
                  ),
                  verticalSpace(8),
                  Text(
                    category.name ?? '',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font14BlackRegular,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}