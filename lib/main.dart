import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:venda_sys/bloc/login_bloc.dart';
import 'package:venda_sys/screens/home_screen.dart';
import 'package:venda_sys/screens/splash_screen.dart';

import 'config/config.dart';
import 'models/usuario.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(boxName, compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 10;
  });
  WidgetsFlutterBinding.ensureInitialized();

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
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FutureBuilder<Usuario>(
                future: BlocProvider.getBloc<LoginBloc>().checkLogged(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final _usuario = snapshot.data;
                    if (_usuario!.email.isEmpty) {
                      return LoginScreen();
                    } else {
                      return const HomeScreen();
                    }
                  } else {
                    return const SplashScreen();
                  }
                },
              );
            } else {
              return const SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
