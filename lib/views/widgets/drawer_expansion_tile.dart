import 'package:flutter/material.dart';

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
        child: Text(title),
      ),
      leading: Icon(icon),
      initiallyExpanded: isSelected,
      children: children,
    );
  }
}
