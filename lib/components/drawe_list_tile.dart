import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String route;
  final Function()? onTap;

  const DrawerListTile(
      {Key? key,
      // For selecting those three line once press "Command+D"
      required this.title,
      this.icon,
      required this.route,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: ModalRoute.of(context)?.settings.name == route,
      selectedTileColor: const Color(0xFFff5a5a),
      onTap: onTap ??
          () {
            Navigator.pushNamed(context, route);
          },
      horizontalTitleGap: 0.0,
      leading: icon != null
          ? Icon(
              icon,
              color: Colors.white,
            )
          : null,
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
