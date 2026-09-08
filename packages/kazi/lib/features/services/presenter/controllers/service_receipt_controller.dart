import 'dart:async';

import 'package:kazi/core/services/domain/time_service.dart';
import 'package:kazi/features/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:kazi/features/onboarding/domain/models/checklist_step.dart';
import 'package:kazi/features/onboarding/presenter/controllers/checklist_controller.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/domain/repositories/services_repository.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

part 'service_receipt_controller.g.dart';

/// The single place a payment stamp is written.
///
/// One writer, two readers: the write goes to Firestore once, then both list
/// controllers patch their own copy in memory. Refetching instead would depend
/// on the write echo having landed — `ServicesRepository.get` reads
/// cache-first — so the list could come back showing the state from before the
/// tap. An in-memory patch is deterministic and instant.
///
/// `keepAlive` because the write is awaited: an auto-disposed writer has no
/// listener holding it, so the Ref is gone by the time Firestore answers and
/// every patch below throws.
@Riverpod(keepAlive: true)
class ServiceReceiptController extends _$ServiceReceiptController {
  ServicesRepository get _repository => ref.read(servicesRepositoryProvider);

  TimeService get _timeService => ref.read(timeServiceProvider);

  @override
  void build() {}

  /// Stamps or clears [services], then patches the lists that show them.
  ///
  /// Returns the ids it wrote, so an undo can hand back exactly the same set
  /// rather than re-deriving it from a list that has since moved.
  Future<List<String>> setReceived(
    Iterable<Service> services, {
    required bool received,
  }) => setReceivedByIds(
    services.map((service) => service.id).toList(),
    received: received,
  );

  /// The id-based form, for callers that no longer hold the services — an undo
  /// acts on the set that was written, which by then may have scrolled out of
  /// any list.
  Future<List<String>> setReceivedByIds(
    List<String> ids, {
    required bool received,
  }) async {
    if (ids.isEmpty) return const [];

    final stamp = received ? _timeService.now : null;
    await _repository.setReceivedAt(ids, stamp);

    final stamps = {for (final id in ids) id: stamp};
    ref.read(dashboardControllerProvider.notifier).applyReceipt(stamps);
    ref.read(serviceLandingControllerProvider.notifier).applyReceipt(stamps);

    if (received) {
      // Ticks the home checklist. There is no cheap "has ever received"
      // query, so the step is stamped where it happens; the call is a no-op
      // once it already is.
      unawaited(
        ref
            .read(checklistControllerProvider.notifier)
            .markStep(ChecklistStep.markReceived),
      );
    }

    return ids;
  }
}
