import 'package:flutter/material.dart';
import 'package:youapp_flutter/components/bottom_navigation.dart';
import 'package:youapp_flutter/utils.dart';

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem({
    required this.selectedNavigation,
    required this.type,
    Key? key,
    required this.iconName,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final BottomNavigationType type, selectedNavigation;
  final String title;
  final IconData iconName;
  final Function(BottomNavigationType type) onTap;

  bool get selected => type == selectedNavigation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(type),
      child: Column(
        children: [
          Icon(
            iconName,
            color: selected ? Colors.white : FabricColors.button1,
          ),
          Text(
            title,
            style: TextStyle(color: selectedNavigation == type ? Colors.white : FabricColors.button1),
          ),
          if (selected)
            Container(
              width: 10,
              height: 2,
              color: Colors.white,
            )
        ],
      ),
    );
  }
}
