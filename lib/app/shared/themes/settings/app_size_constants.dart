import 'package:flutter/material.dart';

abstract class AppSizeConstants {
  //Sizes
  static const smallSpace = 10.0;
  static const mediumSpace = 20.0;
  static const largeSpace = 30.0;
  static const hugeSpace = 40.0;

  // Vertical space
  static const smallVerticalSpacer = SizedBox(height: smallSpace);
  static const mediumVerticalSpacer = SizedBox(height: mediumSpace);
  static const largeVerticalSpacer = SizedBox(height: largeSpace);
  static const hugeVerticalSpacer = SizedBox(height: hugeSpace);

  // Horizontal space
  static const smallHorizontalSpacer = SizedBox(width: smallSpace);
  static const mediumHorizontalSpacer = SizedBox(width: mediumSpace);
  static const largeHorizontalSpacer = SizedBox(width: largeSpace);
  static const hugeHorizontalSpacer = SizedBox(width: hugeSpace);

  static const emptyWidget = SizedBox.shrink();
}
