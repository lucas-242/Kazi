import 'package:flutter/material.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/themes/themes.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback? onTap;
  const SocialLoginButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: context.height * 0.075,
        decoration: BoxDecoration(
          color: context.colorsScheme.primaryContainer,
          borderRadius: BorderRadius.circular(5),
          border: Border.fromBorderSide(BorderSide(color: Colors.grey[50]!)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const FaIcon(FontAwesomeIcons.google),
            const SizedBox(width: 12),
            Text(
              context.appLocalizations.googleSignIn,
              style: context.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
