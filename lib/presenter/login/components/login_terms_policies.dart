import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi_design_system/themes/themes.dart';

class LoginTermsPolicies extends StatelessWidget {
  const LoginTermsPolicies({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: AppLocalizations.current.userTermsAlert1,
        style: context.bodyMedium,
        children: [
          TextSpan(
            text: AppLocalizations.current.userTermsAlert2,
            style: context.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: KaziColors.orange,
            ),
          ),
          TextSpan(text: AppLocalizations.current.userTermsAlert3),
          TextSpan(
            text: AppLocalizations.current.userTermsAlert4,
            style: context.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: KaziColors.orange,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.navigateTo(AppPages.privacyPolicy),
          ),
        ],
      ),
    );
  }
}
