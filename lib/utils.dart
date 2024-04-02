import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class FabricColors {
  static const Color background1 = Color(0xFF1F4247);
  static const Color background2 = Color(0xFF0D1D23);
  static const Color background3 = Color(0xFF09141A);
  static const Color button1 = Color(0xFF62CDCB);
  static const Color button2 = Color(0xFF4599DB);
  static const Color golden1 = Color(0xFF94783E); //#94783E
  static const Color golden2 = Color(0xFFF3EDA6); //#F3EDA6
  static const Color golden3 = Color(0xFFF8FAE5); //#F8FAE5
  static const Color golden4 = Color(0xFFFFE2BE); //#FFE2BE
  static const Color golden5 = Color(0xFFD5BE88); //#D5BE88
  static const Color golden6 = Color(0xFFF8FAE5); //#F8FAE5
  static const Color golden7 = Color(0xFFD5BE88); //#D5BE88
  static const Color container1 = Color(0xFF162329); //#162329
  static const Color container2 = Color(0xFF0E191F); //#0E191F
  static const Color outline1 = Color(0xFFD9D9D9); //#D9D9D9
  static const Color blueish1 = Color(0xFFABFFFD); //#ABFFFD
  static const Color blueish2 = Color(0xFF4599DB); //#4599DB
  static const Color blueish3 = Color(0xFFAADAFF); //#AADAFF
}

class Sizes {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static double keyboard(BuildContext context) => MediaQuery.of(context).viewInsets.bottom;
}

class ImageUtils {
  static Future<CroppedFile?> cropImage(File file) {
    return ImageCropper().cropImage(
      compressQuality: 15,
      aspectRatio: const CropAspectRatio(ratioX: 5, ratioY: 3),
      cropStyle: CropStyle.rectangle,
      sourcePath: file.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          toolbarColor: FabricColors.button2,
          toolbarWidgetColor: FabricColors.button2,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Photo',
          rectX: 3,
          rectY: 3,
          aspectRatioLockEnabled: true,
        ),
      ],
    );
  }
}
