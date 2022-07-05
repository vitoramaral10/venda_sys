import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:venda_sys/bindings/auth_bindings.dart';
import 'package:venda_sys/config/custom_theme_data.dart';
import 'package:venda_sys/config/routes.dart';
import 'package:venda_sys/controllers/auth_controller.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return GetMaterialApp(
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en', 'US'),
            debugShowCheckedModeBanner: false,
            getPages: Routes.pages,
            initialBinding: AuthBindings(),
            initialRoute: Routes.initialRoute,
            theme: CustomThemeData.lightTheme,
            title: 'Yellow - Console Emissor',
            defaultTransition: Transition.fadeIn,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('pt', 'BR'),
            ],
          );
        },);
  }
}
