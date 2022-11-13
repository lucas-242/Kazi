import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_services/shared/themes/themes.dart';

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
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
          border: Border.fromBorderSide(BorderSide(color: Colors.grey[50]!)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(FontAwesomeIcons.google),
            const SizedBox(width: 12),
            Text(
              'Login com Google',
              style: context.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
