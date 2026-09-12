// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Decides which onboarding treatment the signed-in account gets.
///
/// Resolved lazily rather than in `bootstrap.dart`, and that placement is
/// deliberate: `KaziAppStartup` awaits this **after** confirming
/// authentication, so the uid is guaranteed to be there. Resolved during the
/// bootstrap it would race Firebase Auth restoring the session, and a null uid
/// would quietly classify a signed-in user as [OnboardingSegment.done] —
/// permanently, since nothing would ever ask again.

@ProviderFor(OnboardingController)
const onboardingControllerProvider = OnboardingControllerProvider._();

/// Decides which onboarding treatment the signed-in account gets.
///
/// Resolved lazily rather than in `bootstrap.dart`, and that placement is
/// deliberate: `KaziAppStartup` awaits this **after** confirming
/// authentication, so the uid is guaranteed to be there. Resolved during the
/// bootstrap it would race Firebase Auth restoring the session, and a null uid
/// would quietly classify a signed-in user as [OnboardingSegment.done] —
/// permanently, since nothing would ever ask again.
final class OnboardingControllerProvider
    extends $AsyncNotifierProvider<OnboardingController, OnboardingSegment> {
  /// Decides which onboarding treatment the signed-in account gets.
  ///
  /// Resolved lazily rather than in `bootstrap.dart`, and that placement is
  /// deliberate: `KaziAppStartup` awaits this **after** confirming
  /// authentication, so the uid is guaranteed to be there. Resolved during the
  /// bootstrap it would race Firebase Auth restoring the session, and a null uid
  /// would quietly classify a signed-in user as [OnboardingSegment.done] —
  /// permanently, since nothing would ever ask again.
  const OnboardingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingControllerHash();

  @$internal
  @override
  OnboardingController create() => OnboardingController();
}

String _$onboardingControllerHash() =>
    r'29afeb0566bb32e226e7c28d103f546082a01448';

/// Decides which onboarding treatment the signed-in account gets.
///
/// Resolved lazily rather than in `bootstrap.dart`, and that placement is
/// deliberate: `KaziAppStartup` awaits this **after** confirming
/// authentication, so the uid is guaranteed to be there. Resolved during the
/// bootstrap it would race Firebase Auth restoring the session, and a null uid
/// would quietly classify a signed-in user as [OnboardingSegment.done] —
/// permanently, since nothing would ever ask again.

abstract class _$OnboardingController
    extends $AsyncNotifier<OnboardingSegment> {
  FutureOr<OnboardingSegment> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<OnboardingSegment>, OnboardingSegment>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OnboardingSegment>, OnboardingSegment>,
              AsyncValue<OnboardingSegment>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
