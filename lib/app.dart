import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shuttla/constants/providers.dart';
import 'package:shuttla/ui/themes/app_theme_light.dart';

import 'constants/route_names.dart';

class Shuttla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: AppProviders.providers,
        child: MultiBlocProvider(
          providers: AppProviders.blocProviders,
          child: MaterialApp(
            debugShowCheckedModeBanner: kDebugMode,
            title: 'Shuttla',
            theme: appThemeLight,
            routes: RouteNames.routes,
            initialRoute: RouteNames.splashScreen,
            onGenerateRoute: RouteNames.generateRoute,
            navigatorKey: Get.key,
          ),
        )
    );
  }
}