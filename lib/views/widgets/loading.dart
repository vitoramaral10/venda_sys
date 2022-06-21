import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/themes/light.dart';

class Loading extends GetView {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(appLinkTxtColor),
          ),
          const SizedBox(height: 10),
          Text('loading'.tr),
        ],
      ),
    );
  }
}
