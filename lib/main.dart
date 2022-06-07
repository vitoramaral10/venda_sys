import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:venda_sys/bindings/auth_binding.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/auth_controller.dart';
import 'package:venda_sys/libraries/i18n.dart';

import 'config/routes.dart';
import 'config/themes/light.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(Constants.boxName,
      compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 10;
  });
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const VendaSysApp());
}

class VendaSysApp extends StatelessWidget {
  const VendaSysApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VendaSys',
      getPages: Routes.pages,
      translations: I18n(),
      theme: lightTheme,
      initialRoute: Routes.initial,
      defaultTransition: Transition.fadeIn,
      initialBinding: AuthBindings(),
    );
  }
}
