import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../bindings/auth_bindings.dart';
import '../config/routes.dart';
import '../config/themes/light.dart';
import '../controllers/auth_controller.dart';
import '../libraries/i18n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return GetMaterialApp(
            translations: I18N(),
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en', 'US'),
            debugShowCheckedModeBanner: false,
            getPages: Routes.pages,
            initialBinding: AuthBindings(),
            initialRoute: Routes.initialRoute,
            theme: lightTheme,
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
        });
  }
}
