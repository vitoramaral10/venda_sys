import 'package:flutter/material.dart';

import '../../libraries/responsive.dart';
import '../libraries/constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.only(left: Constants.defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.defaultPadding,
        vertical: Constants.defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Constants.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                //image: imageProfile!,
                image: Constants.imagemProfileDecorator,
                borderRadius: BorderRadius.circular(50),
              )),
          if (!Responsive.isMobile(context))
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding / 2),
              child: Text(
                "Leonardo Jose",
                style: TextStyle(color: Colors.white),
              ),
            ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
