
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/localization/cubit/localization_cubit.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'generated/l10n.dart';

class Khoyout extends StatelessWidget {
  const Khoyout({super.key,required this.appRouter });
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocalizationCubit()),
      //  BlocProvider(create: (_) => NavBarCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: BlocBuilder<LocalizationCubit, LocalizationState>(
          builder: (context, localizationState) {


            return  MaterialApp(
              locale: LocalizationCubit.get(context).locale,
              navigatorKey: NavigationService.navigatorKey,
              initialRoute: Routes.splashScreen,
              onGenerateRoute: appRouter.generateRoute,
              supportedLocales: S.delegate.supportedLocales,
              localizationsDelegates:   const[
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
            );

          },
        ),
      ),
    );
  }
}
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}