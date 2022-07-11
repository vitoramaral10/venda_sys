import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:translations_loader/translations_loader.dart';
import 'package:venda_sys/bindings/auth_bindings.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/config/custom_theme_data.dart';
import 'package:venda_sys/config/routes.dart';
import 'package:venda_sys/controllers/auth_controller.dart';
import 'package:venda_sys/services/localization_service.dart';

void main() async {
  log(
    'Running in ${const String.fromEnvironment('flavor')} flavor',
    name: 'main',
  );
  await Hive.initFlutter();
  await Hive.openBox(
    Constants.boxName,
    compactionStrategy: (entries, deletedEntries) {
      var other = 10;

      return deletedEntries > other;
    },
  );

  Get.put(AuthController());
  runApp(
    GetMaterialApp(
      smartManagement: SmartManagement.onlyBuilder,
      enableLog: false,
      translations: LocalizationService(
        await TranslationsLoader.loadTranslations("assets/locale"),
      ),
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
    ),
  );
}
