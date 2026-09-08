import 'package:flutter/material.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/core/widgets/tap_probe.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_state.dart';
import 'package:kazi/features/services/presenter/widgets/catalog_item_form.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;
import 'package:kazi_core/kazi_core.dart';

class CatalogItemFormPage extends ConsumerStatefulWidget {
  const CatalogItemFormPage({super.key});

  @override
  ConsumerState<CatalogItemFormPage> createState() =>
      _CatalogItemFormPageState();
}

class _CatalogItemFormPageState extends ConsumerState<CatalogItemFormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(catalogControllerProvider.notifier);
    final state = ref.watch(catalogControllerProvider);

    void onConfirm() {
      if (!(_formKey.currentState?.validate() ?? false)) return;

      if (state.catalogItem.id.isEmpty) {
        controller.addCatalogItem();
      } else {
        controller.updateCatalogItem();
      }
    }

    ref.listen<CatalogState>(catalogControllerProvider, (previous, current) {
      if (previous?.status != current.status) {
        if (current.status == BaseStateStatus.success) {
          KaziNavigator.pop();
          return;
        }
        if (current.status == BaseStateStatus.error &&
            current.callbackMessage.isNotEmpty) {
          KaziSnackbar.show(context, current.callbackMessage);
        }
      }

      final collision = current.archivedCollision;
      if (collision != null && previous?.archivedCollision != collision) {
        showDialog(
          context: context,
          builder: (_) => KaziDialog(
            title: KaziLocalizations.current.restore,
            message: KaziLocalizations.current.catalogItemArchivedRestorePrompt(
              collision.name,
            ),
            confirmText: KaziLocalizations.current.restore,
            onCancel: () {
              KaziNavigator.pop();
              controller.dismissArchivedCollision();
            },
            onConfirm: () {
              KaziNavigator.pop();
              controller.dismissArchivedCollision();
              controller.restoreCatalogItem(collision);
              KaziNavigator.pop();
            },
          ),
        );
      }
    });

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        controller.eraseCatalogItem();
      },
      child: Scaffold(
        appBar: KaziAppBar(
          title: state.catalogItem.id.isEmpty
              ? KaziLocalizations.current.newCatalogItem.capitalize()
              : ('${KaziLocalizations.current.edit} ${state.catalogItem.name}')
                    .capitalize(),
        ),
        body: KaziSafeArea(child: CatalogItemForm(formKey: _formKey)),
        bottomNavigationBar: KaziFormFooter(
          label: KaziLocalizations.current.save,
          onTap: state.nameCollision == null ? onConfirm : null,
          child: (button) =>
              TapProbe(target: 'save_service_type', child: button),
        ),
      ),
    );
  }
}
