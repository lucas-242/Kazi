import 'package:flutter/material.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';

class LeaveBottomSheet extends StatelessWidget {
  const LeaveBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.17,
      child: Padding(
        padding: const EdgeInsets.all(AppInsets.lg),
        child: Column(
          children: [
            Text(AppLocalizations.current.leaveApp, style: context.titleMedium),
            AppSpacings.verticalLg,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PillButton(
                  onTap: () => context.closeModal(false),
                  width: 75,
                  child: Text(AppLocalizations.current.back),
                ),
                AppSpacings.horizontalXLg,
                PillButton(
                  onTap: () {
                    context.closeModal(true);
                    context.navigateBack();
                  },
                  backgroundColor: context.colorsScheme.error,
                  width: 75,
                  child: Text(AppLocalizations.current.exit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
