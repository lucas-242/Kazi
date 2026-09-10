import 'package:kazi/core/services/data/ads/creation_ad_coordinator.dart';

class FakeCreationAdCoordinator implements CreationAdCoordinator {
  /// How many creations were reported, and whether each one was allowed to
  /// surface an ad right away — service-form quick-adds pass `false`.
  final List<bool> actions = [];

  int prepareCount = 0;

  int get creationActions => actions.length;

  @override
  void prepare() => prepareCount++;

  @override
  Future<void> onCreationAction({bool canShowNow = true}) async =>
      actions.add(canShowNow);
}
