import 'package:flutter/material.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// "· recebido" — the word marking a service as already paid for, appended to
/// the line it belongs to rather than replacing anything on the row. The
/// separator is dropped when [precededBy] is empty, so the line never opens
/// with a dangling "·".
///
/// A `TextSpan` and not a widget so it ellipsises together with that line: the
/// situation is the first thing to give way when the client's name is long, and
/// the row's amounts keep their column either way. See README.md.
TextSpan receivedMarkSpan(BuildContext context, {required String precededBy}) {
  // The separator carries no style of its own, so it keeps the line's colour;
  // only the word is green.
  return TextSpan(
    text: precededBy.isEmpty ? null : ' · ',
    children: [
      TextSpan(
        text: KaziLocalizations.current.received.toLowerCase(),
        style: KaziTextStyles.labelSmall.copyWith(
          color: context.colors.success.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
