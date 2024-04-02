import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({super.key, required this.svg, this.color, this.size});
  final String svg;
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svg,
      colorFilter: ColorFilter.mode(
        color ?? Colors.white,
        BlendMode.srcIn,
      ),
      width: size,
    );
  }
}
