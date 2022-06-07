import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/constants.dart';
  import 'header.dart';
import 'side_menu.dart';

// ignore: must_be_immutable
class BaseWidget extends GetView {
  Widget child;
  FloatingActionButton? floatingActionButton;

  BaseWidget({
    Key? key,
    required this.child,
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
            if (GetPlatform.isDesktop) const SideMenu(),
            Expanded(
              child: Column(
                children: [
                  const Header(),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(Constants.defaultPadding),
                      children: [
                        Text(
                          Get.currentRoute.split('/').last.tr,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(
                          height: Constants.defaultPadding,
                        ),
                        child,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
