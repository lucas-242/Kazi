import 'package:flutter/widgets.dart';
import 'package:kazi/app/core/themes/themes.dart';

abstract class AppSpacings {
  ///8.0px
  static const verticalXs = SizedBox(height: AppInsets.xs);

  ///12.0px
  static const verticalSm = SizedBox(height: AppInsets.sm);

  ///16.0px
  static const verticalMd = SizedBox(height: AppInsets.md);

  ///20.0px
  static const verticalLg = SizedBox(height: AppInsets.lg);

  ///28.0px
  static const verticalXLg = SizedBox(height: AppInsets.xLg);

  ///40.0px
  static const verticalXxLg = SizedBox(height: AppInsets.xxLg);

  ///50.0px
  static const verticalXxxLg = SizedBox(height: AppInsets.xxxLg);

  ///8.0px
  static const horizontalXs = SizedBox(width: AppInsets.xs);

  ///12.0px
  static const horizontalSm = SizedBox(width: AppInsets.sm);

  ///16.0px
  static const horizontalMd = SizedBox(width: AppInsets.md);

  ///20.0px
  static const horizontalLg = SizedBox(width: AppInsets.lg);

  ///28.0px
  static const horizontalXLg = SizedBox(width: AppInsets.xLg);

  ///40.0px
  static const horizontalXxLg = SizedBox(width: AppInsets.xxLg);

  ///50.0px
  static const horizontalXxxLg = SizedBox(width: AppInsets.xxxLg);
}
