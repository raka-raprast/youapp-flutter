import 'package:flutter/material.dart';
import 'package:youapp_flutter/components/fabric_text.dart';

class FabricChip extends StatelessWidget {
  const FabricChip({
    super.key,
    required this.label,
    this.onDeleted,
    this.index,
    this.backgroundColor,
    this.borderRadius,
    this.fontWeight,
  });

  final String label;
  final ValueChanged<int>? onDeleted;
  final int? index;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onDeleted != null && index != null) {
          onDeleted!(index!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.only(top: 9),
        decoration: BoxDecoration(color: backgroundColor ?? Colors.white.withOpacity(.2), borderRadius: borderRadius ?? BorderRadius.circular(3)),
        child: IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FabricText(
                label,
                style: InterTextStyle.body1(context, fontWeight: fontWeight),
              ),
              if (onDeleted != null) ...[
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
