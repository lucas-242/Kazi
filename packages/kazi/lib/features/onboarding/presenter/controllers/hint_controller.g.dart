// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hint_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Decides whether a contextual hint may appear, and remembers that it did.
///
/// Three rules, all from experience with hints that outstay their welcome:
/// they wait for the opening's interruptions to be over, **only one is up at a
/// time**, and "Got it" means never again.

@ProviderFor(HintController)
const hintControllerProvider = HintControllerProvider._();

/// Decides whether a contextual hint may appear, and remembers that it did.
///
/// Three rules, all from experience with hints that outstay their welcome:
/// they wait for the opening's interruptions to be over, **only one is up at a
/// time**, and "Got it" means never again.
final class HintControllerProvider
    extends $NotifierProvider<HintController, void> {
  /// Decides whether a contextual hint may appear, and remembers that it did.
  ///
  /// Three rules, all from experience with hints that outstay their welcome:
  /// they wait for the opening's interruptions to be over, **only one is up at a
  /// time**, and "Got it" means never again.
  const HintControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hintControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hintControllerHash();

  @$internal
  @override
  HintController create() => HintController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$hintControllerHash() => r'23dfbd36a550ad6e868e689819f1f2e8335099e8';

/// Decides whether a contextual hint may appear, and remembers that it did.
///
/// Three rules, all from experience with hints that outstay their welcome:
/// they wait for the opening's interruptions to be over, **only one is up at a
/// time**, and "Got it" means never again.

abstract class _$HintController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
