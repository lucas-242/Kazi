import 'package:flutter/material.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get appLocalizations => AppLocalizations.of(this);
}
