import 'package:flutter/material.dart';

abstract class AppSizeConstants {
  //Sizes
  static const tinySpace = 5.0;
  static const smallSpace = 10.0;
  static const mediumSpace = 15.0;
  static const largeSpace = 20.0;
  static const bigSpace = 30.0;
  static const hugeSpace = 40.0;
  static const imenseSpace = 50.0;

  // Vertical space
  static const smallVerticalSpacer = SizedBox(height: smallSpace);
  static const mediumVerticalSpacer = SizedBox(height: mediumSpace);
  static const largeVerticalSpacer = SizedBox(height: largeSpace);
  static const bigVerticalSpacer = SizedBox(height: bigSpace);
  static const hugeVerticalSpacer = SizedBox(height: hugeSpace);
  static const imenseVerticalSpacer = SizedBox(height: imenseSpace);

  // Horizontal space
  static const smallHorizontalSpacer = SizedBox(width: smallSpace);
  static const mediumHorizontalSpacer = SizedBox(width: mediumSpace);
  static const largeHorizontalSpacer = SizedBox(width: largeSpace);
  static const bigHorizontalSpacer = SizedBox(width: bigSpace);
  static const hugeHorizontalSpacer = SizedBox(width: hugeSpace);
  static const imenseHorizontalSpacer = SizedBox(width: imenseSpace);

  static const emptyWidget = SizedBox.shrink();
}
