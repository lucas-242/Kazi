// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bootstrap.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Everything the router needs before it can choose a screen, run while the
/// branded splash is on screen and awaited against its minimum duration.
///
/// Nothing here throws: every step is individually fail-open, because the only
/// outcome worse than a stale feature flag is a user stuck on the splash. The
/// order below is not arbitrary — see README.md.

@ProviderFor(appBootstrap)
const appBootstrapProvider = AppBootstrapProvider._();

/// Everything the router needs before it can choose a screen, run while the
/// branded splash is on screen and awaited against its minimum duration.
///
/// Nothing here throws: every step is individually fail-open, because the only
/// outcome worse than a stale feature flag is a user stuck on the splash. The
/// order below is not arbitrary — see README.md.

final class AppBootstrapProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// Everything the router needs before it can choose a screen, run while the
  /// branded splash is on screen and awaited against its minimum duration.
  ///
  /// Nothing here throws: every step is individually fail-open, because the only
  /// outcome worse than a stale feature flag is a user stuck on the splash. The
  /// order below is not arbitrary — see README.md.
  const AppBootstrapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appBootstrapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appBootstrapHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return appBootstrap(ref);
  }
}

String _$appBootstrapHash() => r'b7e16889d25abcec1ea76821833826d8c29d6439';

/// Carries a change made in Menu › Privacy down to the SDKs. The composite
/// already gates every event this app sends, but not what the SDKs send on
/// their own — `session_start`, `$app_opened`, a replay already in progress.

@ProviderFor(analyticsConsentSync)
const analyticsConsentSyncProvider = AnalyticsConsentSyncProvider._();

/// Carries a change made in Menu › Privacy down to the SDKs. The composite
/// already gates every event this app sends, but not what the SDKs send on
/// their own — `session_start`, `$app_opened`, a replay already in progress.

final class AnalyticsConsentSyncProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Carries a change made in Menu › Privacy down to the SDKs. The composite
  /// already gates every event this app sends, but not what the SDKs send on
  /// their own — `session_start`, `$app_opened`, a replay already in progress.
  const AnalyticsConsentSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsConsentSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsConsentSyncHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return analyticsConsentSync(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$analyticsConsentSyncHash() =>
    r'48732ffe04cec13328aa219ab6b04ebcb0dbcecd';
