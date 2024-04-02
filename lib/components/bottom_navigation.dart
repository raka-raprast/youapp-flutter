import 'package:flutter/material.dart';
import 'package:youapp_flutter/components/bottom_navigation_item.dart';
import 'package:youapp_flutter/utils.dart';

enum BottomNavigationType {
  chat,
  profile,
}

class BottomNavigation extends StatelessWidget {
  static const height = 88.0;

  const BottomNavigation({
    Key? key,
    this.selectedNavigation,
    this.onSelect,
    required this.children,
  }) : super(key: key);
  final Function(BuildContext, BottomNavigationType)? onSelect;
  final BottomNavigationType? selectedNavigation;
  final List<BottomNavigationItem> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: FabricColors.background1,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: children.map(
          (e) {
            return InkWell(
              onTap: () => onSelect!(context, e.type),
              child: e,
            );
          },
        ).toList(),
      ),
    );
  }
}
