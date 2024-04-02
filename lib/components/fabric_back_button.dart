import 'package:flutter/material.dart';
import 'package:youapp_flutter/components/fabric_text.dart';

class FabricBackButton extends StatelessWidget {
  const FabricBackButton({super.key, required this.onBackTap, this.iconOnly = false});
  final Function() onBackTap;
  final bool iconOnly;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBackTap,
      child: Row(
        children: [
          const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          if (!iconOnly)
            FabricText(
              "Back",
              style: InterTextStyle.button(context, fontWeight: FontWeight.bold),
            )
        ],
      ),
    );
  }
}
