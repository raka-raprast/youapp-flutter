// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youapp_flutter/components/fabric_text.dart';
import 'package:youapp_flutter/components/shadermask.dart';

class FabricTextField extends StatelessWidget {
  const FabricTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.hintStyle,
      this.obscureText = false,
      this.isObscurable = false,
      this.onObscureTap,
      this.style,
      this.onChanged,
      this.backgroundColor,
      this.outlineColor,
      this.textAlign = TextAlign.start,
      this.readOnly = false,
      this.isDropdown = false,
      this.onTap,
      this.keyboardType,
      this.inputFormatters,
      this.suffixWidget,
      this.padding,
      this.margin,
      this.height,
      this.focusNode});
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintStyle, style;
  final bool obscureText, isObscurable, readOnly, isDropdown;
  final Function()? onObscureTap, onTap;
  final Function(String text)? onChanged;
  final Color? backgroundColor, outlineColor;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidget;
  final EdgeInsetsGeometry? padding, margin;
  final double? height;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white.withOpacity(.2),
          borderRadius: BorderRadius.circular(9),
          border: outlineColor != null ? Border.all(color: outlineColor!) : null,
        ),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 15),
        margin: margin,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: focusNode,
                cursorWidth: 1.0,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                onTap: onTap,
                readOnly: readOnly,
                onChanged: onChanged,
                controller: controller,
                obscureText: obscureText,
                style: style ?? InterTextStyle.body1(context),
                textAlign: textAlign,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: hintStyle,
                ),
              ),
            ),
            if (suffixWidget != null) suffixWidget!,
            if (isObscurable)
              GestureDetector(
                onTap: onObscureTap,
                child: GoldenShaderMask(
                  child: Icon(obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
                ),
              ),
            if (isDropdown)
              GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.white,
                      )),
                ),
              )
          ],
        ));
  }
}
