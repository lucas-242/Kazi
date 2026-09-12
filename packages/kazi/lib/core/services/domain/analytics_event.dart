/// Every event the app emits, grouped by the stage of the journey it measures.
///
/// Names and parameters are snake_case and under 40 characters, which is what
/// Firebase accepts. [isKey] routes an event to both sinks; everything else
/// goes to PostHog only.
///
/// **No event carries a monetary amount, a name, an e-mail or free text** —
/// only shape: bucketed counts, ISO codes, enum names and booleans.
/// `AnalyticsScrubber` enforces it rather than trusting it.
///
/// See `core/services/data/analytics/README.md` for the architecture.
enum AnalyticsEvent {
  // Auth

  /// `provider`
  loginStarted('login_started'),

  /// `provider`, `is_new_user`
  loginCompleted('login_completed', isKey: true),

  /// `provider`, `reason` — the error code, never the message.
  loginFailed('login_failed'),

  logout('logout'),

  // Onboarding / setup

  setupStarted('setup_started'),

  /// `step`
  setupStepViewed('setup_step_viewed'),

  /// `step`, `seconds_on_step`
  setupExited('setup_exited'),

  /// `seconds`, `seeded_types`, `registered_service`, `profession`
  setupCompleted('setup_completed', isKey: true),

  /// `step`
  checklistStepCompleted('checklist_step_completed'),

  /// `hint`
  hintDismissed('hint_dismissed'),

  /// `version`
  whatsNewViewed('whats_new_viewed'),

  /// `version`, `seconds`
  whatsNewDismissed('whats_new_dismissed'),

  /// `kind`
  nudgeShown('nudge_shown'),

  /// `kind`
  nudgeActioned('nudge_actioned'),

  // Activation

  serviceFormOpened('service_form_opened'),

  /// `seconds`, `filled_fields`, `last_field`, `had_validation_error`
  serviceFormAbandoned('service_form_abandoned'),

  /// `quantity`, `currency`, `has_client`, `commission_configured`,
  /// `seconds_to_create`
  serviceCreated('service_created'),

  /// The account's first service ever — the activation milestone.
  firstServiceCreated('first_service_created', isKey: true),

  serviceUpdated('service_updated'),

  /// `days_old`
  serviceDeleted('service_deleted'),

  /// `source` — setup / catalog / quick_add
  ///
  /// Wire name predates the rename to catalog; changing it splits the metric.
  catalogItemCreated('service_type_created'),

  /// `source` — clients / quick_add
  clientCreated('client_created'),

  /// `entity` — client / catalog_item
  recordArchived('record_archived'),

  /// `entity` — client / catalog_item; `source` — archived_screen / picker
  recordRestored('record_restored'),

  /// `entity` — client / catalog_item
  recordDeleted('record_deleted'),

  receiptGenerated('receipt_generated'),

  // Perceived value

  /// `period`, `has_data`, `services_bucket`, `unconverted_count`
  dashboardViewed('dashboard_viewed'),

  /// `from`, `to`
  dashboardPeriodChanged('dashboard_period_changed'),

  /// The home with nothing on it: a strong churn signal on any session that is
  /// not the first.
  dashboardEmptyStateSeen('dashboard_empty_state_seen'),

  /// `filter`
  filterApplied('filter_applied'),

  // Currency

  currencyMigrationShown('currency_migration_shown'),

  /// `currency`, `backfilled_bucket`
  currencyMigrationConfirmed('currency_migration_confirmed', isKey: true),

  /// `reason`
  currencyMigrationFailed('currency_migration_failed'),

  /// `from`, `to`
  currencyChanged('currency_changed'),

  /// `context` — totals / form_switch. Measures what the silent exchange-rate
  /// fallback actually costs.
  ratesUnavailable('rates_unavailable'),

  /// The only user-visible currency failure.
  formCurrencySwitchRefused('form_currency_switch_refused'),

  // Freemium / paywall

  /// `limit_type`, `form`. The top of the monetization funnel.
  limitReached('limit_reached'),

  /// `source` — limit / menu — plus `limit_type`, `tier`, `is_trial_eligible`
  paywallShown('paywall_shown', isKey: true),

  /// `seconds`, `source`
  paywallDismissed('paywall_dismissed'),

  /// `is_trial_eligible`
  subscribeTapped('subscribe_tapped', isKey: true),

  /// `is_trial`
  subscriptionStarted('subscription_started', isKey: true),

  /// `reason` — the error code only.
  subscriptionPurchaseFailed('subscription_purchase_failed'),

  subscriptionRestored('subscription_restored'),

  // Ads

  /// `after`
  interstitialShown('interstitial_shown'),

  interstitialLoadFailed('interstitial_load_failed'),

  // Interaction shape

  /// `screen`, `target` — `none` when the tap reached no [TapProbe] — plus `x`
  /// and `y` normalized to the surface, and `w_bucket`. Sampled per session and
  /// capped; see `data/analytics/README.md`.
  elementTapped('element_tapped'),

  // Errors and friction

  /// `code`, `screen`. Emitted from `BaseNotifier`, so it covers every handled
  /// error in the app.
  errorShown('error_shown'),

  /// `kind`, `screen`, `count`
  frictionDetected('friction_detected'),

  /// `form`, `field`
  formValidationFailed('form_validation_failed');

  const AnalyticsEvent(this.name, {this.isKey = false});

  /// The wire name, identical in both sinks.
  final String name;

  /// Whether the event also goes to Firebase Analytics.
  final bool isKey;
}
