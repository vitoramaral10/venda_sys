import 'package:flutter/material.dart';
import 'package:venda_sys/config/constants.dart';

class DrawerExpansionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final List<Widget> children;

  const DrawerExpansionTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.children,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Transform.translate(
        offset: const Offset(-16, 0),
        child: Text(
          title,
          style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.7)),
        ),
      ),
      leading: Icon(
        icon,
        size:Constants.iconSize,
      ),
      textColor: const Color.fromRGBO(0, 0, 0, 0.7),
      iconColor: const Color.fromRGBO(0, 0, 0, 0.7),
      initiallyExpanded: isSelected,
      children: children,
    );
  }
}
