import 'package:flutter/material.dart';
import 'package:youapp_flutter/utils.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key, this.isDisabled = false, required this.label, this.labelStyle, this.padding, this.isExpanded = false, this.margin, required this.onTap});
  final bool isDisabled, isExpanded;
  final String label;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? padding, margin;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return _buildButton();
    }
    return IntrinsicWidth(
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    return GestureDetector(
      onTap: () {
        if (!isDisabled) {
          onTap();
        }
      },
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Container(
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              margin: margin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: isDisabled
                    ? null
                    : [
                        BoxShadow(
                          color: FabricColors.button1.withOpacity(.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ).scale(4),
                        BoxShadow(
                          color: FabricColors.button2.withOpacity(.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ).scale(4),
                      ],
                gradient: const LinearGradient(
                  colors: [
                    FabricColors.button1,
                    FabricColors.button2,
                  ],
                ),
              ),
              child: Center(child: _buildText()),
            ),
            if (isDisabled)
              Container(
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                margin: margin,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black.withOpacity(.2)),
                child: Center(child: _buildText()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      label,
      style: labelStyle ?? TextStyle(fontSize: 20, color: Colors.white.withOpacity(isDisabled ? .3 : 1), fontWeight: FontWeight.w700),
    );
  }
}
