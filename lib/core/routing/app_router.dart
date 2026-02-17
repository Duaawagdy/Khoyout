import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/di/Dependency_inj.dart';
import 'package:khouyot/features/add_address/logic/address_cubit.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/features/cart_screen/logic/cart_cubit.dart';
import 'package:khouyot/features/categories_screen/logic/categories_cubit.dart';
import 'package:khouyot/features/checkout/data/model/order_response.dart';
import 'package:khouyot/features/checkout/logic/checkout_cubit.dart';
import 'package:khouyot/features/favourites/logic/fav_cubit.dart';
import 'package:khouyot/features/forget_password/data/model/reset_password_request.dart';
import 'package:khouyot/features/forget_password/logic/forget_password_cubit.dart';
import 'package:khouyot/features/my_orders/data/model/orders_model.dart';
import 'package:khouyot/features/my_orders/logic/orders_cubit.dart';
import 'package:khouyot/features/nav_bar/logic/nav_bar_cubit.dart';
import 'package:khouyot/features/nav_bar/ui/screen/nav_bar_screen.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/features/search/logic/search_cubit.dart';
import 'package:khouyot/features/add_address/data/model/address_model.dart';

import '../../features/add_address/ui/screen/address_details.dart';
import '../../features/add_address/ui/screen/edit_address_screen.dart';
import '../../features/add_address/ui/screen/myaddress_screen.dart';
import '../../features/auth/ui/screen/sign_up_screen.dart';
import '../../features/auth/ui/screen/verify_otp_screen.dart';
import '../../features/cart_screen/ui/cart_screen_ui.dart';
import '../../features/categories_screen/ui/screen/category_products.dart';
import '../../features/checkout/ui/screens/checkout_screen.dart';
import '../../features/checkout/ui/screens/order_details_screen.dart';
import '../../features/favourites/ui/screen/favourite_screen.dart';
import '../../features/forget_password/ui/forget_password_screen.dart';
import '../../features/forget_password/ui/reset_password_screen.dart';
import '../../features/forget_password/ui/verify_code_reset_password.dart';
import '../../features/home/data/model/product_model.dart';
import '../../features/home/ui/screens/view_all_product_screen.dart';
import '../../features/my_orders/ui/screen/my_order_details.dart';
import '../../features/my_orders/ui/screen/my_order_screen.dart';
import '../../features/my_orders/ui/screen/review_product.dart';
import '../../features/product_details/logic/product_details_cubit.dart';
import '../../features/profile/ui/screen/change_password.dart';
import '../../features/profile/ui/screen/edit_profile_screen.dart';
import '../../features/product_details/ui/screens/product_details_screen.dart';
import '../../features/profile/data/model/profile_model.dart';
import '../../features/search/ui/screens/text_field_search_screen.dart';
import '../../features/splash/ui/splash_screen.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )

    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: SignUpScreen(),
          ),
        );
      case Routes.verifyCode:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: VerifySignUpScreen(),
          ),
        );
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgetPasswordCubit>(),
            child: ForgetPasswordScreen(),
          ),
        );
      case Routes.verifyEmailCode:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgetPasswordCubit>(),
            child: VerifyResetPasswordScreen(
              email: settings.arguments as String,
            ),
          ),
        );
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgetPasswordCubit>(),
            child: ResetPasswordScreen(
              email: (settings.arguments as Map<String, dynamic>)['email']
                  as String,
              resetKey: (settings.arguments
                  as Map<String, dynamic>)['reset_key'] as String,
            ),
          ),
        );
      case Routes.navigationBar:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<NavBarCubit>(),
            child: NavigationBarApp(index: settings.arguments as int,),
          ),
        );
      case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<SearchCubit>(),
              ),
              BlocProvider.value(value: getIt<FavCubit>()..getFav()),
            ],
            child: SearchTextField(),
          ),
        );
      case Routes.viewAllProduct:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<FavCubit>()..getFav()),
              BlocProvider.value(value: getIt<SearchCubit>()),
            ],
            child: ViewAllProduct(
              title: args['title'] as String,
              products: args['products'] as List<ProductModel>,
            ),
          ),
        );
      case Routes.viewCategoryProduct:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<FavCubit>()..getFav()),
              BlocProvider.value(value: getIt<CategoriesCubit>())
            ],
            child: CategoryProducts(
              title: args['title'] as String,
              id: args['id'] as int,
            ),
          ),
        );
      case Routes.wishListScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<FavCubit>()..getFav(),
            child: FavouriteScreen(),
          ),
        );
      case Routes.productScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<ProductDetailsCubit>(),
              ),
              BlocProvider.value(
                value: getIt<CartCubit>(),
              ),
              BlocProvider.value(
                value: getIt<FavCubit>(),
              ), BlocProvider.value(
                value: getIt<NavBarCubit>(),
              ),
            ],
            child: ProductDetailsScreen(
              id: settings.arguments as int,
            ),
          ),
        );
      case Routes.editAccountInfoScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<ProfileCubit>(),
            child: EditProfileScreen(
              profileModel: settings.arguments as ProfileModel,
            ),
          ),
        );
      case Routes.addressDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<AddressCubit>(),
            child: AddressDetailsScreen(),
          ),
        );
      case Routes.editAddressScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<AddressCubit>(),
            child: EditAddressScreen(
              addressModel: settings.arguments as AddressesModel,
            ),
          ),
        );
      case Routes.myAddressScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<AddressCubit>()..getAddress(),
            child: MyAddressScreen(),
          ),
        );
      case Routes.changePasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<ProfileCubit>(),
            child: ChangePasswordScreen(),
          ),
        );
      case Routes.checkOutScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<CartCubit>(),
              ),
              BlocProvider.value(
                value: getIt<CheckoutCubit>(),
              ),
              BlocProvider.value(
                value: getIt<AddressCubit>()..getAddress(),
              ),
            ],
            child: CheckoutScreen(),
          ),
        );

      case Routes.trackOrdertScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<CheckoutCubit>(),
            child: OrderDetailsScreen(
              orderResponse: settings.arguments as OrderResponse,
            ),
          ),
        );case Routes.cartScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<CartCubit>()..getCartItems(),
            child: CartScreen(),
          ),
        );
      case Routes.ordersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<OrdersCubit>()..getOrders(),
            child: MyOrders(),
          ),
        );
      case Routes.myOrdertDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<OrdersCubit>(),
            child: TrackYourOrderScreen(
              orderItems: settings.arguments as MyOrderModel,
            ),
          ),
        );
      case Routes.reviewProduct:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<OrdersCubit>(),
            child: ReviewProductScreen(
              orderItemModel: settings.arguments as OrderItemModel,
            ),
          ),
        );
    }

    return null;
  }
}
