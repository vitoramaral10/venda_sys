import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/login_bloc.dart';
import 'package:venda_sys/screens/home_screen.dart';
import 'package:venda_sys/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.getBloc<LoginBloc>().isLoggedIn()
        ? _buildHome(context)
        : _buildLogin(context);
  }

  _buildHome(BuildContext context) {
    return const HomeScreen();
  }

  _buildLogin(BuildContext context) {
    return LoginScreen();
  }
}
