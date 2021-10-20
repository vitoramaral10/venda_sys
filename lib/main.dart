import 'dart:developer';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/produtos_bloc.dart';
import 'package:venda_sys/screens/home_screen.dart';

void main() {
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
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          log(snapshot.error.toString());
          return Container(
            color: Colors.red,
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return BlocProvider(
            blocs: [
              Bloc((i) => ProdutosBloc()),
            ],
            dependencies: [],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'VendaSys',
              home: HomeScreen(),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}
