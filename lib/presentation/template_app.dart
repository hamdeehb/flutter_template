import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/flavors/flavor.dart';
import 'package:flutter_template/flavors/flavor_config.dart';
import 'package:flutter_template/navigation/base/app_router.dart';
import 'package:flutter_template/presentation/base/theme/template_app_theme_data.dart';
import 'package:flutter_template/presentation/base/widgets/snackbar/snackbar.dart';
import 'package:flutter_template/presentation/base/widgets/theme/theme_listener.dart';
import 'package:flutter_template/presentation/entity/screen/screen.dart';
import 'package:get_it/get_it.dart';

class TemplateApp extends StatelessWidget {
  TemplateApp({Key? key}) : super(key: key);

  final AppRouter _appRouter = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    const enableDevicePreview =
        String.fromEnvironment("enableDevicePreview") == "true";
    final useDevicePreview = enableDevicePreview &&
        kDebugMode &&
        FlavorConfig.instance.flavor == Flavor.dev;

    return ProviderScope(
      child: ThemeListener(
        builder: (themeMode) => MaterialApp.router(
          useInheritedMediaQuery: useDevicePreview,
          theme: material3LightTheme,
          darkTheme: material3DarkTheme,
          themeMode: themeMode,
          routerDelegate: _appRouter.delegate(
            initialRoutes: [HomeRoute(homeScreen: const HomeScreen())],
          ),
          routeInformationParser: _appRouter.defaultRouteParser(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      ),
    );
  }
}
