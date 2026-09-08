import 'package:flutter/material.dart';
import 'package:kazi/features/onboarding/domain/models/onboarding_hint.dart';
import 'package:kazi/features/onboarding/presenter/widgets/hint_anchor.dart';
import 'package:kazi/features/services/domain/models/service_view.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// The List / Summary switch. Both sides answer the same question over the
/// same filtered services; see README.md.
///
/// A segmented control rather than two chips: these are the two faces of the
/// tab, not two filters, and the row of chips right below is what filters.
class ServiceViewSwitch extends ConsumerWidget {
  const ServiceViewSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(
      serviceLandingControllerProvider.select((state) => state.view),
    );
    final controller = ref.read(serviceLandingControllerProvider.notifier);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(KaziInsets.xxs),
      decoration: BoxDecoration(
        color: context.colors.surfaceMuted,
        borderRadius: KaziRadii.smBorder,
      ),
      child: Row(
        children: [
          Expanded(
            child: _Segment(
              label: KaziLocalizations.current.list,
              isSelected: view == ServiceView.list,
              onTap: () => controller.onChangeView(ServiceView.list),
            ),
          ),
          Expanded(
            child: HintAnchor(
              hint: OnboardingHint.summary,
              radius: KaziRadii.xs,
              // Pointless while the summary is open, or with nothing in it.
              enabled: view != ServiceView.summary,
              child: _Segment(
                label: KaziLocalizations.current.summary,
                isSelected: view == ServiceView.summary,
                onTap: () => controller.onChangeView(ServiceView.summary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      button: true,
      selected: isSelected,
      child: Material(
        color: isSelected ? colors.card : Colors.transparent,
        borderRadius: KaziRadii.xsBorder,
        child: InkWell(
          onTap: onTap,
          borderRadius: KaziRadii.xsBorder,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: KaziInsets.xs),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: KaziTextStyles.labelMedium.copyWith(
                color: isSelected ? colors.text : colors.textMuted,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
