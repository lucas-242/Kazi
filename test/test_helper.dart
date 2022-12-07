import 'package:flutter/material.dart';
import 'package:my_services/shared/l10n/generated/l10n.dart';

abstract class TestHelper {
  static Future<void> loadAppLocalizations() async {
    await AppLocalizations.load(const Locale.fromSubtags(languageCode: 'en'));
  }
}
