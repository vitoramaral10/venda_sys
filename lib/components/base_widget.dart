import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/login_bloc.dart';
import 'package:venda_sys/libraries/responsive.dart';
import 'package:venda_sys/screens/login_screen.dart';

import 'custom_app_bar.dart';
import 'custom_drawer.dart';

// ignore: must_be_immutable
class BaseWidget extends StatefulWidget {
  final Widget child;
  String currentScreen;
  FloatingActionButton? floatingActionButton;

  BaseWidget(
      {Key? key,
      required this.child,
      required this.currentScreen,
      this.floatingActionButton})
      : super(key: key);

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  bool showDrawer = true;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.getBloc<LoginBloc>().isLoggedIn()
        ? SafeArea(
            top: true,
            child: Scaffold(
              key: _key,
              drawer: const CustomDrawer(),
              body: Row(
                children: [
                  if (Responsive.isDesktop(context))
                    if (showDrawer) const CustomDrawer(),
                  Expanded(
                    child: Column(
                      children: [
                        CustomAppBar(
                          drawerButtonTap: () {
                            if (Responsive.isDesktop(context)) {
                              setState(() {
                                showDrawer = !showDrawer;
                              });
                            } else {
                              _key.currentState!.isDrawerOpen
                                  ? _key.currentState!.openEndDrawer()
                                  : _key.currentState!.openDrawer();
                            }
                          },
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: widget.child),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              floatingActionButton: widget.floatingActionButton,
            ),
          )
        : LoginScreen();
  }
}

// ignore: must_be_immutable