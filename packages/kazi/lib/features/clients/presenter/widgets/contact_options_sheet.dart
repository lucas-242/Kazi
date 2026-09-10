import 'package:flutter/material.dart';
import 'package:kazi/core/widgets/option_tile.dart';
import 'package:kazi_core/kazi_core.dart';

/// Digits (and a leading `+`) out of a saved phone number.
///
/// [KaziFieldInput] applies no mask to the phone field, so a saved number can
/// carry spaces, dashes or parentheses — none of which `tel:`, wa.me or t.me
/// accept.
String _digitsOf(String phone) => phone.replaceAll(RegExp(r'[^\d+]'), '');

/// Opens [url] and says so when nothing on the device could — a phone with no
/// calling app, a browserless device hitting the web fallback.
Future<void> _launch(BuildContext context, WidgetRef ref, String url) async {
  final launched = await ref.read(kaziUrlLauncherServiceProvider).launch(url);
  if (!launched && context.mounted) {
    KaziSnackbar.show(context, KaziLocalizations.current.errorToOpenApp);
  }
}

/// Hands [email] to whatever mail app the device has set as default, ready to
/// send.
Future<void> openEmail(BuildContext context, WidgetRef ref, String email) =>
    _launch(context, ref, 'mailto:$email');

/// The phone row's three ways out — the dialer, or a chat opened by number on
/// WhatsApp or Telegram — offered as a choice because a saved number says
/// nothing about which of the three this person actually answers on.
Future<void> openContactOptions(
  BuildContext context,
  WidgetRef ref,
  String phone,
) {
  return KaziNavigator.showBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (_) => _ContactOptionsSheet(phone: phone),
  );
}

class _ContactOptionsSheet extends ConsumerWidget {
  const _ContactOptionsSheet({required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = KaziLocalizations.current;
    final digits = _digitsOf(phone);
    // wa.me takes the plain international number — the "+" dropped here for
    // WhatsApp has to come back for Telegram, which only resolves a chat by
    // number in full E.164 form.
    final formatted = digits.replaceFirst('+', '');

    Future<void> open(String url) async {
      KaziNavigator.pop();
      await _launch(context, ref, url);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        KaziInsets.lg,
        KaziInsets.zero,
        KaziInsets.lg,
        KaziInsets.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.contactOptionsTitle, style: KaziTextStyles.titleMedium),
          KaziSpacings.verticalMd,
          OptionTile(
            mark: OptionMark.none,
            leading: const Icon(Icons.call_outlined),
            label: l10n.call,
            onTap: () => open('tel:$digits'),
          ),
          OptionTile(
            mark: OptionMark.none,
            leading: const Icon(KaziIcons.whatsapp, color: Color(0xFF25D366)),
            label: l10n.whatsapp,
            onTap: () => open('https://wa.me/$formatted'),
          ),
          OptionTile(
            mark: OptionMark.none,
            leading: const Icon(KaziIcons.telegram, color: Color(0xFF24A1DE)),
            label: l10n.telegram,
            onTap: () => open('https://t.me/+$formatted'),
          ),
        ],
      ),
    );
  }
}
