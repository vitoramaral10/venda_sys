import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

import 'config/config.dart';
import 'config/routes.dart';
import 'libraries/constants.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(boxName, compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 10;
  });
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  runApp(const VendaSysApp());
}

class VendaSysApp extends StatefulWidget {
  const VendaSysApp({Key? key}) : super(key: key);

  @override
  _VendaSysAppState createState() => _VendaSysAppState();
}

class _VendaSysAppState extends State<VendaSysApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: blocs,
      dependencies: const [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VendaSys',
        routes: Routes.list,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Constants.background,
            canvasColor: Constants.secondary,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Constants.primary,
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Constants.primary,
            ),
            inputDecorationTheme: InputDecorationTheme(
              floatingLabelStyle: const TextStyle(
                color: Constants.primary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Constants.defaultPadding),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Constants.defaultPadding),
                borderSide: const BorderSide(
                  color: Constants.primary,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Constants.defaultPadding),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
            )),
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const SplashScreen();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
