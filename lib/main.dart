import 'package:flutter/material.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/di/Dependency_inj.dart';

import 'core/routing/app_router.dart';
import 'khouyot_app.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  await setupGetIt();

  runApp(Khoyout(appRouter: AppRouter()));
}


