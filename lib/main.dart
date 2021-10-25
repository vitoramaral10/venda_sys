import 'dart:developer';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:venda_sys/bloc/login_bloc.dart';
import 'package:venda_sys/screens/home_screen.dart';
import 'package:venda_sys/screens/splash_screen.dart';

import 'config/config.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(boxName, compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 10;
  });
  WidgetsFlutterBinding.ensureInitialized();

  runApp(VendaSysApp());
}

class VendaSysApp extends StatefulWidget {
  @override
  _VendaSysAppState createState() => _VendaSysAppState();
}

class _VendaSysAppState extends State<VendaSysApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: blocs,
      dependencies: [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VendaSys',
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                color: Colors.red,
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return BlocProvider.getBloc<LoginBloc>().checkLogged() ? HomeScreen() : LoginScreen();
            } else if (snapshot.connectionState != ConnectionState.done) {
              return SplashScreen();
            } else {
              return SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
