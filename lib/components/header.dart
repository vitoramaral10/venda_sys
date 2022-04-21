import 'package:flutter/material.dart';

import '../libraries/constants.dart';
import '../libraries/responsive.dart';
import 'profile_card.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  final String title;
  final bool search;

  const Header({
    Key? key,
    required this.title,
    this.search = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isMobile(context))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Container(
                  height: 2,
                  width: 40,
                  color: Constants.primary,
                ),
              ),
            ],
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        const ProfileCard()
      ],
    );
  }
}
