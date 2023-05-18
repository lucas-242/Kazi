import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';

abstract class TestHelper {
  static Future<void> loadAppLocalizations() async {
    await AppLocalizations.load(const Locale.fromSubtags(languageCode: 'en'));
  }
}
