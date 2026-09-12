// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_landing_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServiceLandingController)
const serviceLandingControllerProvider = ServiceLandingControllerProvider._();

final class ServiceLandingControllerProvider
    extends $NotifierProvider<ServiceLandingController, ServiceLandingState> {
  const ServiceLandingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceLandingControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceLandingControllerHash();

  @$internal
  @override
  ServiceLandingController create() => ServiceLandingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServiceLandingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServiceLandingState>(value),
    );
  }
}

String _$serviceLandingControllerHash() =>
    r'eab8473118ff66f905cea4c9607a59896f8eccc5';

abstract class _$ServiceLandingController
    extends $Notifier<ServiceLandingState> {
  ServiceLandingState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ServiceLandingState, ServiceLandingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ServiceLandingState, ServiceLandingState>,
              ServiceLandingState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
