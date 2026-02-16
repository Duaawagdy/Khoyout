import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/di/Dependency_inj.dart';
import 'package:khouyot/features/cart_screen/logic/cart_cubit.dart';
import 'package:khouyot/features/categories_screen/logic/categories_cubit.dart';
import 'package:khouyot/features/favourites/logic/fav_cubit.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:meta/meta.dart';

import '../../cart_screen/ui/cart_screen_ui.dart';
import '../../categories_screen/ui/screen/categories_screen.dart';
import '../../home/ui/screens/home_screen.dart';
import '../../profile/ui/screen/profile_screen.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());

  static NavBarCubit get(context) => BlocProvider.of(context);
  PageController pageController = PageController();

  int selectedIndex = 0;
  final screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<HomeCubit>(),
        ),
        BlocProvider.value(
          value: getIt<FavCubit>()
            ..getFav(),
        ),
      ],
      child: HomeScreen(),
    ),
    BlocProvider.value(
      value: getIt<CategoriesCubit>()
        ..getCategories(),
      child: CategoriesScreen(),
    ),
    BlocProvider.value(
      value: getIt<CartCubit>()..getCartItems(),
      child: CartScreen(),
    ),
    BlocProvider.value(
      value: getIt<ProfileCubit>(),
      child: ProfileScreen(),
    )
  ];

  void changeIndex(int newIndex, {bool jumping = true}) {
    selectedIndex = newIndex;
    if (jumping) {
      pageController.jumpToPage(newIndex); // Navigate to the specified page
    }
    emit(ChangeIndex());
  }
}
