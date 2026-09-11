import 'package:flutter/material.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// The shell the quick-add sheets share: a title, the fields, and one button
/// that creates the thing and hands it back to the form that asked for it.
///
/// The label is "Criar e usar" and not "Salvar" because the created record
/// comes back selected. A sheet that closes and leaves the person hunting for
/// what they just made would not have been a shortcut.
class QuickAddSheet extends StatelessWidget {
  const QuickAddSheet({
    super.key,
    required this.title,
    required this.formKey,
    required this.children,
    required this.onConfirm,
    this.confirmLabel,
    this.isSaving = false,
  });

  final String title;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final VoidCallback onConfirm;

  /// Defaults to "Criar e usar". A sheet that has stopped being about creating
  /// something — the namesake the user chose to reuse instead — says so.
  final String? confirmLabel;

  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    return _ClearOfKeyboard(
      // The padding changes on every frame of the keyboard animation; the
      // boundary keeps the fields from being repainted along with it.
      child: RepaintBoundary(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: KaziTextStyles.titleMedium),
              KaziSpacings.verticalMd,
              ...children,
              KaziSpacings.verticalLg,
              KaziElevatedButton.label(
                onTap: isSaving ? null : onConfirm,
                width: double.infinity,
                label: isSaving
                    ? KaziLocalizations.current.saving
                    : confirmLabel ?? KaziLocalizations.current.createAndUse,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Scrolls [child] with room for the keyboard. A widget of its own so that a
/// keyboard frame rebuilds only this, and never the form it was handed.
class _ClearOfKeyboard extends StatelessWidget {
  const _ClearOfKeyboard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: KaziInsets.lg,
        right: KaziInsets.lg,
        bottom: KaziInsets.lg + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: child,
    );
  }
}
