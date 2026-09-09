import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/networking/dio_factory.dart';
import 'package:khouyot/core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../khouyot_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateToNextScreen();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.forward();
  }

  Future<void> _navigateToNextScreen() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      final String token = await CashHelper.getStringSecured(key: Keys.token);
      final context = NavigationService.navigatorKey.currentContext;
print(token);
      if (context == null) return;

      if (token.isEmpty) {
        context.pushReplacementNamed(Routes.signUpScreen);
      } else {
        DioFactory.setTokenIntoHeaderAfterLogin(token);
        context.pushReplacementNamed(Routes.navigationBar,arguments: 0);
      }
    } catch (e, stackTrace) {
      debugPrint('Splash screen error: $e');
      debugPrint('Stack trace: $stackTrace');

      final context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        context.pushReplacementNamed(Routes.signUpScreen);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.kPrimaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 53.w),
                  child: Image.asset(
                    'assets/logo.png',
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported,
                        size: 100.sp,
                        color: Colors.white.withOpacity(0.5),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}