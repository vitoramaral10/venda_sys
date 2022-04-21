import 'package:flutter/material.dart';

import '../libraries/constants.dart';
import '../libraries/responsive.dart';
import 'header.dart';
import 'side_menu.dart';

// ignore: must_be_immutable
class BaseWidget extends StatelessWidget {
  Widget child;
  String title;
  FloatingActionButton? floatingActionButton;

  BaseWidget({
    Key? key,
    required this.child,
    required this.title,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(Constants.defaultPadding),
                child: ListView(
                  children: [
                    Header(title: title),
                    const SizedBox(height: Constants.defaultPadding),
                    Container(child: child),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
