import 'package:flutter/material.dart';

class FabricText extends StatelessWidget {
  const FabricText(
    this.data, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });
  final String data;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: style ??
          const TextStyle(
            color: Colors.white,
          ),
    );
  }
}

class InterTextStyle {
  static TextStyle title(BuildContext context, {Color? color, FontWeight? fontWeight, TextDecoration? decoration, Color? decorationColor}) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: 30,
          color: color ?? Colors.white,
          fontWeight: fontWeight ?? FontWeight.bold,
          decoration: decoration,
          decorationColor: decorationColor ?? Colors.white,
        );
  }

  static TextStyle subtitle(BuildContext context, {Color? color, FontWeight? fontWeight, TextDecoration? decoration, Color? decorationColor}) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: 24,
          color: color ?? Colors.white,
          fontWeight: fontWeight ?? FontWeight.bold,
          decoration: decoration,
          decorationColor: decorationColor ?? Colors.white,
        );
  }

  static TextStyle time(BuildContext context, {Color? color, FontWeight? fontWeight, TextDecoration? decoration, Color? decorationColor}) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: 10,
          color: color ?? Colors.white,
          fontWeight: fontWeight ?? FontWeight.w500,
          decoration: decoration,
          decorationColor: decorationColor ?? color ?? Colors.white,
        );
  }

  static TextStyle body1(BuildContext context, {Color? color, FontWeight? fontWeight, TextDecoration? decoration, Color? decorationColor}) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: 14,
          color: color ?? Colors.white,
          fontWeight: fontWeight ?? FontWeight.w500,
          decoration: decoration,
          decorationColor: decorationColor ?? color ?? Colors.white,
        );
  }

  static TextStyle body2(BuildContext context, {Color? color, FontWeight? fontWeight, TextDecoration? decoration, Color? decorationColor}) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: 16,
          color: color ?? Colors.white,
          fontWeight: fontWeight ?? FontWeight.w500,
          decoration: decoration,
          decorationColor: decorationColor ?? color ?? Colors.white,
        );
  }

  static TextStyle button(BuildContext context, {Color? color, FontWeight? fontWeight, TextDecoration? decoration, Color? decorationColor}) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: 18,
          color: color ?? Colors.white,
          fontWeight: fontWeight ?? FontWeight.w500,
          decoration: decoration,
          decorationColor: decorationColor ?? color ?? Colors.white,
        );
  }
}
