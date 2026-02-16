
import 'package:get_it/get_it.dart';
import 'package:khouyot/features/add_address/data/repo/address_repo.dart';
import 'package:khouyot/features/add_address/logic/address_cubit.dart';
import 'package:khouyot/features/cart_screen/data/repo/cart_repo.dart';
import 'package:khouyot/features/cart_screen/logic/cart_cubit.dart';
import 'package:khouyot/features/categories_screen/data/repo/categories_repo.dart';
import 'package:khouyot/features/categories_screen/logic/categories_cubit.dart';
import 'package:khouyot/features/checkout/data/repo/checkout_repo.dart';
import 'package:khouyot/features/checkout/logic/checkout_cubit.dart';
import 'package:khouyot/features/favourites/data/repo/fav_repo.dart';
import 'package:khouyot/features/favourites/logic/fav_cubit.dart';
import 'package:khouyot/features/forget_password/data/repo/forget_password_repo.dart';
import 'package:khouyot/features/forget_password/logic/forget_password_cubit.dart';
import 'package:khouyot/features/home/data/repo/home_repo.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';
import 'package:khouyot/features/my_orders/data/repo/Orders_repo.dart';
import 'package:khouyot/features/my_orders/logic/orders_cubit.dart';
import 'package:khouyot/features/nav_bar/logic/nav_bar_cubit.dart';
import 'package:khouyot/features/profile/data/repo/profile_repo.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/features/search/data/repo/search_repo.dart';
import 'package:khouyot/features/search/logic/search_cubit.dart';

import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/logic/auth_cubit.dart';
import '../../features/product_details/data/repo/product_details_repo.dart';
import '../../features/product_details/logic/product_details_cubit.dart';
import '../networking/dio_factory.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final dio = DioFactory.getDio();

  // ========================
  // Repositories (long-lived)
  // ========================
  getIt.registerFactory<AuthRepo>(() => AuthRepo(dio));
  getIt.registerFactory<HomeRepo>(() => HomeRepo(dio));
  getIt.registerLazySingleton<ForgetPasswordRepo>(
        () => ForgetPasswordRepo(dio),
  );
  getIt.registerFactory<NavBarCubit>(
        () => NavBarCubit(),
  );
  // ========================
  // Cubits (short-lived UI state)
  // ========================
  getIt.registerFactory<AuthCubit>(
        () => AuthCubit(getIt<AuthRepo>()),
  );

  getIt.registerFactory<ForgetPasswordCubit>(
        () => ForgetPasswordCubit(getIt<ForgetPasswordRepo>()),
  );
  getIt.registerFactory<FavRepo>(
        () => FavRepo(dio),
  );
  getIt.registerLazySingleton<HomeCubit>(
        () => HomeCubit(getIt()),
  );getIt.registerLazySingleton<FavCubit>(
        () => FavCubit(getIt()),
  );
  getIt.registerLazySingleton<ProductDetailsCubit>(
        () => ProductDetailsCubit(getIt()),
  );
  getIt.registerFactory<ProductDetailsRepo>(
        () => ProductDetailsRepo(dio: dio),
  );
  getIt.registerLazySingleton<CategoriesCubit>(
        () => CategoriesCubit(getIt()),
  );
  getIt.registerFactory<CategoriesRepo>(
        () => CategoriesRepo(dio: dio),
  );
  getIt.registerLazySingleton<ProfileCubit>(
        () => ProfileCubit(getIt()),
  );
  getIt.registerFactory<ProfileRepo>(
        () => ProfileRepo( dio),
  );  getIt.registerLazySingleton<CartCubit>(
        () => CartCubit(getIt()),
  );
  getIt.registerFactory<CartRepo>(
        () => CartRepo(dio:  dio),
  );
  getIt.registerLazySingleton<AddressCubit>(
        () => AddressCubit(getIt()),
  );
  getIt.registerFactory<AddressRepo>(
        () => AddressRepo(  dio),
  );
  getIt.registerLazySingleton<CheckoutCubit>(
        () => CheckoutCubit(getIt()),
  );
  getIt.registerFactory<CheckoutRepo>(
        () => CheckoutRepo( dio),
  );
  getIt.registerLazySingleton<OrdersCubit>(
        () => OrdersCubit(getIt()),
  );
  getIt.registerFactory<OrdersRepo>(
        () => OrdersRepo( dio),
  );
  getIt.registerLazySingleton<SearchCubit>(
        () => SearchCubit(getIt()),
  );
  getIt.registerFactory<SearchRepo>(
        () => SearchRepo( dio),
  );
}

