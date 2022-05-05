import 'package:flutter/material.dart';
import 'package:venda_sys/libraries/constants.dart';

class DashboardButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;

  const DashboardButton({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.defaultPadding * 7,
      width: Constants.defaultPadding * 8,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.defaultPadding),
        ),
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.defaultPadding),
            ),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(Constants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: Constants.defaultIconSize),
                  const SizedBox(height: Constants.defaultPadding / 4),
                  Text(title),
                ],
              ),
            )),
      ),
    );
  }
}
