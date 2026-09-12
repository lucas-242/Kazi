// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServiceFormController)
const serviceFormControllerProvider = ServiceFormControllerFamily._();

final class ServiceFormControllerProvider
    extends $AsyncNotifierProvider<ServiceFormController, ServiceFormState> {
  const ServiceFormControllerProvider._({
    required ServiceFormControllerFamily super.from,
    required Service? super.argument,
  }) : super(
         retry: null,
         name: r'serviceFormControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$serviceFormControllerHash();

  @override
  String toString() {
    return r'serviceFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ServiceFormController create() => ServiceFormController();

  @override
  bool operator ==(Object other) {
    return other is ServiceFormControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$serviceFormControllerHash() =>
    r'2387e673cb2e3b71d62cb54c4011b25ff9fb0bab';

final class ServiceFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ServiceFormController,
          AsyncValue<ServiceFormState>,
          ServiceFormState,
          FutureOr<ServiceFormState>,
          Service?
        > {
  const ServiceFormControllerFamily._()
    : super(
        retry: null,
        name: r'serviceFormControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ServiceFormControllerProvider call({Service? service}) =>
      ServiceFormControllerProvider._(argument: service, from: this);

  @override
  String toString() => r'serviceFormControllerProvider';
}

abstract class _$ServiceFormController
    extends $AsyncNotifier<ServiceFormState> {
  late final _$args = ref.$arg as Service?;
  Service? get service => _$args;

  FutureOr<ServiceFormState> build({Service? service});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(service: _$args);
    final ref =
        this.ref as $Ref<AsyncValue<ServiceFormState>, ServiceFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ServiceFormState>, ServiceFormState>,
              AsyncValue<ServiceFormState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
