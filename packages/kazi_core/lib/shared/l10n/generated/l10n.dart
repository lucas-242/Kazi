// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class KaziLocalizations {
  KaziLocalizations();

  static KaziLocalizations? _current;

  static KaziLocalizations get current {
    assert(
      _current != null,
      'No instance of KaziLocalizations was loaded. Try to initialize the KaziLocalizations delegate before accessing KaziLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<KaziLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = KaziLocalizations();
      KaziLocalizations._current = instance;

      return instance;
    });
  }

  static KaziLocalizations of(BuildContext context) {
    final instance = KaziLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of KaziLocalizations present in the widget tree. Did you add KaziLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static KaziLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<KaziLocalizations>(context, KaziLocalizations);
  }

  /// `Actions`
  String get actions {
    return Intl.message('Actions', name: 'actions', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Already has an account? `
  String get alreadyHasAccont {
    return Intl.message(
      'Already has an account? ',
      name: 'alreadyHasAccont',
      desc: '',
      args: [],
    );
  }

  /// `{amount} already received`
  String alreadyReceived(String amount) {
    return Intl.message(
      '$amount already received',
      name: 'alreadyReceived',
      desc: '',
      args: [amount],
    );
  }

  /// `Apply Filters`
  String get applyFilters {
    return Intl.message(
      'Apply Filters',
      name: 'applyFilters',
      desc: '',
      args: [],
    );
  }

  /// `Organize your services`
  String get appSubtitle {
    return Intl.message(
      'Organize your services',
      name: 'appSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Pay cycle`
  String get billingCycle {
    return Intl.message('Pay cycle', name: 'billingCycle', desc: '', args: []);
  }

  /// `{count, plural, one{Closes in 1 day} other{Closes in {count} days}}`
  String billingCycleClosesInDays(int count) {
    return Intl.plural(
      count,
      one: 'Closes in 1 day',
      other: 'Closes in $count days',
      name: 'billingCycleClosesInDays',
      desc: '',
      args: [count],
    );
  }

  /// `Day {day}`
  String billingCycleDay(int day) {
    return Intl.message(
      'Day $day',
      name: 'billingCycleDay',
      desc: '',
      args: [day],
    );
  }

  /// `Kazi adds up your earnings within that period. It's what sets the big number on Home.`
  String get billingCycleDescription {
    return Intl.message(
      'Kazi adds up your earnings within that period. It\'s what sets the big number on Home.',
      name: 'billingCycleDescription',
      desc: '',
      args: [],
    );
  }

  /// `Fortnightly`
  String get billingCycleFortnightly {
    return Intl.message(
      'Fortnightly',
      name: 'billingCycleFortnightly',
      desc: '',
      args: [],
    );
  }

  /// `every {count} days`
  String billingCycleFrequency(int count) {
    return Intl.message(
      'every $count days',
      name: 'billingCycleFrequency',
      desc: '',
      args: [count],
    );
  }

  /// `Last day`
  String get billingCycleLastDay {
    return Intl.message(
      'Last day',
      name: 'billingCycleLastDay',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get billingCycleMonthly {
    return Intl.message(
      'Monthly',
      name: 'billingCycleMonthly',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get billingCycleOther {
    return Intl.message('Other', name: 'billingCycleOther', desc: '', args: []);
  }

  /// `Day I get paid`
  String get billingCyclePayday {
    return Intl.message(
      'Day I get paid',
      name: 'billingCyclePayday',
      desc: '',
      args: [],
    );
  }

  /// `Weekday I get paid`
  String get billingCyclePaydayWeekday {
    return Intl.message(
      'Weekday I get paid',
      name: 'billingCyclePaydayWeekday',
      desc: '',
      args: [],
    );
  }

  /// `You get paid on`
  String get billingCyclePayoutDayGroup {
    return Intl.message(
      'You get paid on',
      name: 'billingCyclePayoutDayGroup',
      desc: '',
      args: [],
    );
  }

  /// `Current cycle: {range}`
  String billingCyclePreview(String range) {
    return Intl.message(
      'Current cycle: $range',
      name: 'billingCyclePreview',
      desc: '',
      args: [range],
    );
  }

  /// `{start} to {end}`
  String billingCycleRange(String start, String end) {
    return Intl.message(
      '$start to $end',
      name: 'billingCycleRange',
      desc: '',
      args: [start, end],
    );
  }

  /// `Save cycle`
  String get billingCycleSave {
    return Intl.message(
      'Save cycle',
      name: 'billingCycleSave',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get billingCycleWeekly {
    return Intl.message(
      'Weekly',
      name: 'billingCycleWeekly',
      desc: '',
      args: [],
    );
  }

  /// `Calculator`
  String get calculator {
    return Intl.message('Calculator', name: 'calculator', desc: '', args: []);
  }

  /// `Calendar`
  String get calendar {
    return Intl.message('Calendar', name: 'calendar', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Clients`
  String get clients {
    return Intl.message('Clients', name: 'clients', desc: '', args: []);
  }

  /// `Last service`
  String get orderLastService {
    return Intl.message(
      'Last service',
      name: 'orderLastService',
      desc: '',
      args: [],
    );
  }

  /// `Alphabetical`
  String get orderAlphabetical {
    return Intl.message(
      'Alphabetical',
      name: 'orderAlphabetical',
      desc: '',
      args: [],
    );
  }

  /// `Top earning`
  String get orderTopEarning {
    return Intl.message(
      'Top earning',
      name: 'orderTopEarning',
      desc: '',
      args: [],
    );
  }

  /// `Last on {date}`
  String lastServiceOn(String date) {
    return Intl.message(
      'Last on $date',
      name: 'lastServiceOn',
      desc: '',
      args: [date],
    );
  }

  /// `No service yet`
  String get noServiceYet {
    return Intl.message(
      'No service yet',
      name: 'noServiceYet',
      desc: '',
      args: [],
    );
  }

  /// `Earned you`
  String get earnedYou {
    return Intl.message('Earned you', name: 'earnedYou', desc: '', args: []);
  }

  /// `Client since`
  String get clientSinceLabel {
    return Intl.message(
      'Client since',
      name: 'clientSinceLabel',
      desc: '',
      args: [],
    );
  }

  /// `client since {month}`
  String clientSince(String month) {
    return Intl.message(
      'client since $month',
      name: 'clientSince',
      desc: '',
      args: [month],
    );
  }

  /// `Mostly gets`
  String get mostGets {
    return Intl.message('Mostly gets', name: 'mostGets', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `No service registered for this person yet.`
  String get noServiceForThisClient {
    return Intl.message(
      'No service registered for this person yet.',
      name: 'noServiceForThisClient',
      desc: '',
      args: [],
    );
  }

  /// `They are created on their own as you register services. Or add the first one now.`
  String get noClientsDescription {
    return Intl.message(
      'They are created on their own as you register services. Or add the first one now.',
      name: 'noClientsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Search by name`
  String get searchClientsHint {
    return Intl.message(
      'Search by name',
      name: 'searchClientsHint',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message('Currency', name: 'currency', desc: '', args: []);
  }

  /// `Current cycle`
  String get currentCycle {
    return Intl.message(
      'Current cycle',
      name: 'currentCycle',
      desc: '',
      args: [],
    );
  }

  /// `{days, plural, =0{closes today} =1{closes tomorrow} other{closes in {days} days}}`
  String cycleClosesIn(int days) {
    return Intl.plural(
      days,
      zero: 'closes today',
      one: 'closes tomorrow',
      other: 'closes in $days days',
      name: 'cycleClosesIn',
      desc: '',
      args: [days],
    );
  }

  /// `{count, plural, one{of {amount} generated in 1 service} other{of {amount} generated in {count} services}}`
  String cycleGeneratedIn(int count, String amount) {
    return Intl.plural(
      count,
      one: 'of $amount generated in 1 service',
      other: 'of $amount generated in $count services',
      name: 'cycleGeneratedIn',
      desc: '',
      args: [count, amount],
    );
  }

  /// `Default currency`
  String get defaultCurrency {
    return Intl.message(
      'Default currency',
      name: 'defaultCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Changing the currency changes the symbol and the format. Amounts already registered are not converted.`
  String get currencyChangeNote {
    return Intl.message(
      'Changing the currency changes the symbol and the format. Amounts already registered are not converted.',
      name: 'currencyChangeNote',
      desc: '',
      args: [],
    );
  }

  /// `are not converted`
  String get currencyChangeNoteEmphasis {
    return Intl.message(
      'are not converted',
      name: 'currencyChangeNoteEmphasis',
      desc: '',
      args: [],
    );
  }

  /// `The app restarts to apply the language. Nothing you registered is lost.`
  String get languageRestartNote {
    return Intl.message(
      'The app restarts to apply the language. Nothing you registered is lost.',
      name: 'languageRestartNote',
      desc: '',
      args: [],
    );
  }

  /// `Kazi {version} · {year}`
  String appVersionFooter(String version, String year) {
    return Intl.message(
      'Kazi $version · $year',
      name: 'appVersionFooter',
      desc: '',
      args: [version, year],
    );
  }

  /// `Error marking the services as received`
  String get errorToMarkReceived {
    return Intl.message(
      'Error marking the services as received',
      name: 'errorToMarkReceived',
      desc: '',
      args: [],
    );
  }

  /// `Marked as received`
  String get markedAsReceived {
    return Intl.message(
      'Marked as received',
      name: 'markedAsReceived',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Mark the 1 pending as received} other{Mark the {count} pending as received}}`
  String markListedReceived(int count) {
    return Intl.plural(
      count,
      one: 'Mark the 1 pending as received',
      other: 'Mark the $count pending as received',
      name: 'markListedReceived',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{Mark 1 service as received?} other{Mark {count} services as received?}}`
  String markListedReceivedConfirm(int count) {
    return Intl.plural(
      count,
      one: 'Mark 1 service as received?',
      other: 'Mark $count services as received?',
      name: 'markListedReceivedConfirm',
      desc: '',
      args: [count],
    );
  }

  /// `{amount} in total. This changes no value and no date — it only records that the payment came in.`
  String markListedReceivedBody(String amount) {
    return Intl.message(
      '$amount in total. This changes no value and no date — it only records that the payment came in.',
      name: 'markListedReceivedBody',
      desc: '',
      args: [amount],
    );
  }

  /// `{count, plural, one{The 1 service already received is not touched.} other{The {count} services already received are not touched.}}`
  String markListedReceivedUntouched(int count) {
    return Intl.plural(
      count,
      one: 'The 1 service already received is not touched.',
      other: 'The $count services already received are not touched.',
      name: 'markListedReceivedUntouched',
      desc: '',
      args: [count],
    );
  }

  /// `Mark received`
  String get markReceived {
    return Intl.message(
      'Mark received',
      name: 'markReceived',
      desc: '',
      args: [],
    );
  }

  /// `{period} · your earnings`
  String periodYourEarnings(String period) {
    return Intl.message(
      '$period · your earnings',
      name: 'periodYourEarnings',
      desc: '',
      args: [period],
    );
  }

  /// `of {amount} generated`
  String generatedFromAmount(String amount) {
    return Intl.message(
      'of $amount generated',
      name: 'generatedFromAmount',
      desc: '',
      args: [amount],
    );
  }

  /// `of {amount} charged to clients`
  String generatedFromClients(String amount) {
    return Intl.message(
      'of $amount charged to clients',
      name: 'generatedFromClients',
      desc: '',
      args: [amount],
    );
  }

  /// `{amount} pending`
  String pendingAmount(String amount) {
    return Intl.message(
      '$amount pending',
      name: 'pendingAmount',
      desc: '',
      args: [amount],
    );
  }

  /// `Not received yet`
  String get notReceived {
    return Intl.message(
      'Not received yet',
      name: 'notReceived',
      desc: '',
      args: [],
    );
  }

  /// `Received`
  String get received {
    return Intl.message('Received', name: 'received', desc: '', args: []);
  }

  /// `Received on {date}`
  String receivedOn(String date) {
    return Intl.message(
      'Received on $date',
      name: 'receivedOn',
      desc: '',
      args: [date],
    );
  }

  /// `Select a currency`
  String get selectCurrency {
    return Intl.message(
      'Select a currency',
      name: 'selectCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Brazilian real`
  String get currencyBRL {
    return Intl.message(
      'Brazilian real',
      name: 'currencyBRL',
      desc: '',
      args: [],
    );
  }

  /// `US dollar`
  String get currencyUSD {
    return Intl.message('US dollar', name: 'currencyUSD', desc: '', args: []);
  }

  /// `Canadian dollar`
  String get currencyCAD {
    return Intl.message(
      'Canadian dollar',
      name: 'currencyCAD',
      desc: '',
      args: [],
    );
  }

  /// `Argentine peso`
  String get currencyARS {
    return Intl.message(
      'Argentine peso',
      name: 'currencyARS',
      desc: '',
      args: [],
    );
  }

  /// `Bolivian boliviano`
  String get currencyBOB {
    return Intl.message(
      'Bolivian boliviano',
      name: 'currencyBOB',
      desc: '',
      args: [],
    );
  }

  /// `Chilean peso`
  String get currencyCLP {
    return Intl.message(
      'Chilean peso',
      name: 'currencyCLP',
      desc: '',
      args: [],
    );
  }

  /// `Colombian peso`
  String get currencyCOP {
    return Intl.message(
      'Colombian peso',
      name: 'currencyCOP',
      desc: '',
      args: [],
    );
  }

  /// `Costa Rican colón`
  String get currencyCRC {
    return Intl.message(
      'Costa Rican colón',
      name: 'currencyCRC',
      desc: '',
      args: [],
    );
  }

  /// `Cuban peso`
  String get currencyCUP {
    return Intl.message('Cuban peso', name: 'currencyCUP', desc: '', args: []);
  }

  /// `Dominican peso`
  String get currencyDOP {
    return Intl.message(
      'Dominican peso',
      name: 'currencyDOP',
      desc: '',
      args: [],
    );
  }

  /// `Guatemalan quetzal`
  String get currencyGTQ {
    return Intl.message(
      'Guatemalan quetzal',
      name: 'currencyGTQ',
      desc: '',
      args: [],
    );
  }

  /// `Honduran lempira`
  String get currencyHNL {
    return Intl.message(
      'Honduran lempira',
      name: 'currencyHNL',
      desc: '',
      args: [],
    );
  }

  /// `Haitian gourde`
  String get currencyHTG {
    return Intl.message(
      'Haitian gourde',
      name: 'currencyHTG',
      desc: '',
      args: [],
    );
  }

  /// `Mexican peso`
  String get currencyMXN {
    return Intl.message(
      'Mexican peso',
      name: 'currencyMXN',
      desc: '',
      args: [],
    );
  }

  /// `Nicaraguan córdoba`
  String get currencyNIO {
    return Intl.message(
      'Nicaraguan córdoba',
      name: 'currencyNIO',
      desc: '',
      args: [],
    );
  }

  /// `Panamanian balboa`
  String get currencyPAB {
    return Intl.message(
      'Panamanian balboa',
      name: 'currencyPAB',
      desc: '',
      args: [],
    );
  }

  /// `Peruvian sol`
  String get currencyPEN {
    return Intl.message(
      'Peruvian sol',
      name: 'currencyPEN',
      desc: '',
      args: [],
    );
  }

  /// `Paraguayan guaraní`
  String get currencyPYG {
    return Intl.message(
      'Paraguayan guaraní',
      name: 'currencyPYG',
      desc: '',
      args: [],
    );
  }

  /// `Uruguayan peso`
  String get currencyUYU {
    return Intl.message(
      'Uruguayan peso',
      name: 'currencyUYU',
      desc: '',
      args: [],
    );
  }

  /// `Venezuelan bolívar`
  String get currencyVES {
    return Intl.message(
      'Venezuelan bolívar',
      name: 'currencyVES',
      desc: '',
      args: [],
    );
  }

  /// `South African rand`
  String get currencyZAR {
    return Intl.message(
      'South African rand',
      name: 'currencyZAR',
      desc: '',
      args: [],
    );
  }

  /// `Nigerian naira`
  String get currencyNGN {
    return Intl.message(
      'Nigerian naira',
      name: 'currencyNGN',
      desc: '',
      args: [],
    );
  }

  /// `West African CFA franc`
  String get currencyXOF {
    return Intl.message(
      'West African CFA franc',
      name: 'currencyXOF',
      desc: '',
      args: [],
    );
  }

  /// `Central African CFA franc`
  String get currencyXAF {
    return Intl.message(
      'Central African CFA franc',
      name: 'currencyXAF',
      desc: '',
      args: [],
    );
  }

  /// `Kenyan shilling`
  String get currencyKES {
    return Intl.message(
      'Kenyan shilling',
      name: 'currencyKES',
      desc: '',
      args: [],
    );
  }

  /// `Ugandan shilling`
  String get currencyUGX {
    return Intl.message(
      'Ugandan shilling',
      name: 'currencyUGX',
      desc: '',
      args: [],
    );
  }

  /// `Moroccan dirham`
  String get currencyMAD {
    return Intl.message(
      'Moroccan dirham',
      name: 'currencyMAD',
      desc: '',
      args: [],
    );
  }

  /// `Ethiopian birr`
  String get currencyETB {
    return Intl.message(
      'Ethiopian birr',
      name: 'currencyETB',
      desc: '',
      args: [],
    );
  }

  /// `Angolan kwanza`
  String get currencyAOA {
    return Intl.message(
      'Angolan kwanza',
      name: 'currencyAOA',
      desc: '',
      args: [],
    );
  }

  /// `Ghanaian cedi`
  String get currencyGHS {
    return Intl.message(
      'Ghanaian cedi',
      name: 'currencyGHS',
      desc: '',
      args: [],
    );
  }

  /// `Euro`
  String get currencyEUR {
    return Intl.message('Euro', name: 'currencyEUR', desc: '', args: []);
  }

  /// `Pound sterling`
  String get currencyGBP {
    return Intl.message(
      'Pound sterling',
      name: 'currencyGBP',
      desc: '',
      args: [],
    );
  }

  /// `Swiss franc`
  String get currencyCHF {
    return Intl.message('Swiss franc', name: 'currencyCHF', desc: '', args: []);
  }

  /// `Japanese yen`
  String get currencyJPY {
    return Intl.message(
      'Japanese yen',
      name: 'currencyJPY',
      desc: '',
      args: [],
    );
  }

  /// `Chinese yuan`
  String get currencyCNY {
    return Intl.message(
      'Chinese yuan',
      name: 'currencyCNY',
      desc: '',
      args: [],
    );
  }

  /// `South Korean won`
  String get currencyKRW {
    return Intl.message(
      'South Korean won',
      name: 'currencyKRW',
      desc: '',
      args: [],
    );
  }

  /// `Singapore dollar`
  String get currencySGD {
    return Intl.message(
      'Singapore dollar',
      name: 'currencySGD',
      desc: '',
      args: [],
    );
  }

  /// `Indian rupee`
  String get currencyINR {
    return Intl.message(
      'Indian rupee',
      name: 'currencyINR',
      desc: '',
      args: [],
    );
  }

  /// `UAE dirham`
  String get currencyAED {
    return Intl.message('UAE dirham', name: 'currencyAED', desc: '', args: []);
  }

  /// `Saudi riyal`
  String get currencySAR {
    return Intl.message('Saudi riyal', name: 'currencySAR', desc: '', args: []);
  }

  /// `Turkish lira`
  String get currencyTRY {
    return Intl.message(
      'Turkish lira',
      name: 'currencyTRY',
      desc: '',
      args: [],
    );
  }

  /// `Russian ruble`
  String get currencyRUB {
    return Intl.message(
      'Russian ruble',
      name: 'currencyRUB',
      desc: '',
      args: [],
    );
  }

  /// `Which currency do you work in?`
  String get currencyMigrationTitle {
    return Intl.message(
      'Which currency do you work in?',
      name: 'currencyMigrationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Kazi now supports several currencies. Tell us which one your existing services were registered in so your totals add up correctly.`
  String get currencyMigrationDescription {
    return Intl.message(
      'Kazi now supports several currencies. Tell us which one your existing services were registered in so your totals add up correctly.',
      name: 'currencyMigrationDescription',
      desc: '',
      args: [],
    );
  }

  /// `This will be applied to {count} services already registered.`
  String currencyMigrationServicesCount(Object count) {
    return Intl.message(
      'This will be applied to $count services already registered.',
      name: 'currencyMigrationServicesCount',
      desc: '',
      args: [count],
    );
  }

  /// `You can change this later in Settings.`
  String get currencyMigrationChangeLater {
    return Intl.message(
      'You can change this later in Settings.',
      name: 'currencyMigrationChangeLater',
      desc: '',
      args: [],
    );
  }

  /// `Updating your services…`
  String get currencyMigrationApplying {
    return Intl.message(
      'Updating your services…',
      name: 'currencyMigrationApplying',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't update your services. Please try again.`
  String get errorToMigrateCurrency {
    return Intl.message(
      'We couldn\'t update your services. Please try again.',
      name: 'errorToMigrateCurrency',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't load your settings.`
  String get errorToGetUserSettings {
    return Intl.message(
      'We couldn\'t load your settings.',
      name: 'errorToGetUserSettings',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't save your settings.`
  String get errorToSaveUserSettings {
    return Intl.message(
      'We couldn\'t save your settings.',
      name: 'errorToSaveUserSettings',
      desc: '',
      args: [],
    );
  }

  /// `Exchange rates unavailable`
  String get ratesUnavailable {
    return Intl.message(
      'Exchange rates unavailable',
      name: 'ratesUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Connect to the internet to see your totals converted.`
  String get ratesUnavailableDescription {
    return Intl.message(
      'Connect to the internet to see your totals converted.',
      name: 'ratesUnavailableDescription',
      desc: '',
      args: [],
    );
  }

  /// `Clipper cut`
  String get clipperCut {
    return Intl.message('Clipper cut', name: 'clipperCut', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `Commission {percent}`
  String commissionPercent(String percent) {
    return Intl.message(
      'Commission $percent',
      name: 'commissionPercent',
      desc: '',
      args: [percent],
    );
  }

  /// `Commission`
  String get commission {
    return Intl.message('Commission', name: 'commission', desc: '', args: []);
  }

  /// `Commission percentage`
  String get commissionPercentage {
    return Intl.message(
      'Commission percentage',
      name: 'commissionPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Create an Account`
  String get createAccount {
    return Intl.message(
      'Create an Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Action`
  String get confirmAction {
    return Intl.message(
      'Confirm Action',
      name: 'confirmAction',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message('Contact', name: 'contact', desc: '', args: []);
  }

  /// `guimaraeslucas242@gmail.com`
  String get contactEmail {
    return Intl.message(
      'guimaraeslucas242@gmail.com',
      name: 'contactEmail',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueAction {
    return Intl.message('Continue', name: 'continueAction', desc: '', args: []);
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Default Value`
  String get defaultValue {
    return Intl.message(
      'Default Value',
      name: 'defaultValue',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Details`
  String get details {
    return Intl.message('Details', name: 'details', desc: '', args: []);
  }

  /// `Didn't receive anything? `
  String get didntReceiveAnything {
    return Intl.message(
      'Didn\'t receive anything? ',
      name: 'didntReceiveAnything',
      desc: '',
      args: [],
    );
  }

  /// `Discount percentage`
  String get discountPercentage {
    return Intl.message(
      'Discount percentage',
      name: 'discountPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Doesn't have an account? `
  String get doesntHaveAccount {
    return Intl.message(
      'Doesn\'t have an account? ',
      name: 'doesntHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Edit Service`
  String get editService {
    return Intl.message(
      'Edit Service',
      name: 'editService',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Employee`
  String get employee {
    return Intl.message('Employee', name: 'employee', desc: '', args: []);
  }

  /// `Employees`
  String get employees {
    return Intl.message('Employees', name: 'employees', desc: '', args: []);
  }

  /// `Access Denied`
  String get errorAccessDenied {
    return Intl.message(
      'Access Denied',
      name: 'errorAccessDenied',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get whatsapp {
    return Intl.message('WhatsApp', name: 'whatsapp', desc: '', args: []);
  }

  /// `Telegram`
  String get telegram {
    return Intl.message('Telegram', name: 'telegram', desc: '', args: []);
  }

  /// `Call`
  String get call {
    return Intl.message('Call', name: 'call', desc: '', args: []);
  }

  /// `Get in touch`
  String get contactOptionsTitle {
    return Intl.message(
      'Get in touch',
      name: 'contactOptionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't open the app.`
  String get errorToOpenApp {
    return Intl.message(
      'Couldn\'t open the app.',
      name: 'errorToOpenApp',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch {url}`
  String errorLaunchUrl(String url) {
    return Intl.message(
      'Could not launch $url',
      name: 'errorLaunchUrl',
      desc: '',
      args: [url],
    );
  }

  /// `This service can't be removed from the catalog because it is in use`
  String get errorCantDeleteCatalogItem {
    return Intl.message(
      'This service can\'t be removed from the catalog because it is in use',
      name: 'errorCantDeleteCatalogItem',
      desc: '',
      args: [],
    );
  }

  /// `Url not found.`
  String get errorNotFound {
    return Intl.message(
      'Url not found.',
      name: 'errorNotFound',
      desc: '',
      args: [],
    );
  }

  /// `The server took a long time to respond. Please try again later or contact us.`
  String get errorTimeout {
    return Intl.message(
      'The server took a long time to respond. Please try again later or contact us.',
      name: 'errorTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Error adding the service to the catalog.`
  String get errorToAddCatalogItem {
    return Intl.message(
      'Error adding the service to the catalog.',
      name: 'errorToAddCatalogItem',
      desc: '',
      args: [],
    );
  }

  /// `Error removing the service from the catalog.`
  String get errorToDeleteCatalogItem {
    return Intl.message(
      'Error removing the service from the catalog.',
      name: 'errorToDeleteCatalogItem',
      desc: '',
      args: [],
    );
  }

  /// `Error loading your catalog.`
  String get errorToGetCatalogItems {
    return Intl.message(
      'Error loading your catalog.',
      name: 'errorToGetCatalogItems',
      desc: '',
      args: [],
    );
  }

  /// `Error updating the service in the catalog.`
  String get errorToUpdateCatalogItem {
    return Intl.message(
      'Error updating the service in the catalog.',
      name: 'errorToUpdateCatalogItem',
      desc: '',
      args: [],
    );
  }

  /// `Error to add service.`
  String get errorToAddService {
    return Intl.message(
      'Error to add service.',
      name: 'errorToAddService',
      desc: '',
      args: [],
    );
  }

  /// `Error to count services.`
  String get errorToCountServices {
    return Intl.message(
      'Error to count services.',
      name: 'errorToCountServices',
      desc: '',
      args: [],
    );
  }

  /// `Error to delete service.`
  String get errorToDeleteService {
    return Intl.message(
      'Error to delete service.',
      name: 'errorToDeleteService',
      desc: '',
      args: [],
    );
  }

  /// `Error to get service.`
  String get errorToGetServices {
    return Intl.message(
      'Error to get service.',
      name: 'errorToGetServices',
      desc: '',
      args: [],
    );
  }

  /// `Error to update service.`
  String get errorToUpdateService {
    return Intl.message(
      'Error to update service.',
      name: 'errorToUpdateService',
      desc: '',
      args: [],
    );
  }

  /// `Your login expired. Please, login and try again.`
  String get errorTokenExpired {
    return Intl.message(
      'Your login expired. Please, login and try again.',
      name: 'errorTokenExpired',
      desc: '',
      args: [],
    );
  }

  /// `Error to sign in. Try again later or contact the support.`
  String get errorToSignIn {
    return Intl.message(
      'Error to sign in. Try again later or contact the support.',
      name: 'errorToSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Error to sign up. Try again later or contact the support.`
  String get errorToSignUp {
    return Intl.message(
      'Error to sign up. Try again later or contact the support.',
      name: 'errorToSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Error to reset password.`
  String get errorToResetPassword {
    return Intl.message(
      'Error to reset password.',
      name: 'errorToResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Error to send email.`
  String get errorToSendEmail {
    return Intl.message(
      'Error to send email.',
      name: 'errorToSendEmail',
      desc: '',
      args: [],
    );
  }

  /// `An unknown exception occurred.`
  String get errorUnknowError {
    return Intl.message(
      'An unknown exception occurred.',
      name: 'errorUnknowError',
      desc: '',
      args: [],
    );
  }

  /// `There is already an account with this credential`
  String get errorThereIsAnotherAccount {
    return Intl.message(
      'There is already an account with this credential',
      name: 'errorThereIsAnotherAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email is invalid or badly formatted`
  String get errorEmailIsInvalid {
    return Intl.message(
      'Email is invalid or badly formatted',
      name: 'errorEmailIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `This user has been disabled. Please contact support for help`
  String get errorUserHasBeenDisabled {
    return Intl.message(
      'This user has been disabled. Please contact support for help',
      name: 'errorUserHasBeenDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Email was not found, please create an account`
  String get errorEmailWasNotFound {
    return Intl.message(
      'Email was not found, please create an account',
      name: 'errorEmailWasNotFound',
      desc: '',
      args: [],
    );
  }

  /// `The credential is invalid`
  String get errorCredentialIsInvalid {
    return Intl.message(
      'The credential is invalid',
      name: 'errorCredentialIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The verification code entered is invalid`
  String get errorVerificationCodeIsInvalid {
    return Intl.message(
      'The verification code entered is invalid',
      name: 'errorVerificationCodeIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The verification ID entered is invalid`
  String get errorVerificationIdIsInvalid {
    return Intl.message(
      'The verification ID entered is invalid',
      name: 'errorVerificationIdIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Method not allowed. Please try another account or contact support for help`
  String get errorMethodNotAllowed {
    return Intl.message(
      'Method not allowed. Please try another account or contact support for help',
      name: 'errorMethodNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password`
  String get errorIncorrectEmailOrPassword {
    return Intl.message(
      'Incorrect email or password',
      name: 'errorIncorrectEmailOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `Field`
  String get field {
    return Intl.message('Field', name: 'field', desc: '', args: []);
  }

  /// `Filters`
  String get filters {
    return Intl.message('Filters', name: 'filters', desc: '', args: []);
  }

  /// `Filtering by last month`
  String get filteringLastMonth {
    return Intl.message(
      'Filtering by last month',
      name: 'filteringLastMonth',
      desc: '',
      args: [],
    );
  }

  /// `Filtering by today`
  String get filteringToday {
    return Intl.message(
      'Filtering by today',
      name: 'filteringToday',
      desc: '',
      args: [],
    );
  }

  /// `Filtering from {start} to {end}`
  String filteringFromTo(String start, String end) {
    return Intl.message(
      'Filtering from $start to $end',
      name: 'filteringFromTo',
      desc: '',
      args: [start, end],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message('Finish', name: 'finish', desc: '', args: []);
  }

  /// `Forgot your password?`
  String get forgotYourPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please, enter your email address to receive a link to reset your password.`
  String get forgotPasswordInfo {
    return Intl.message(
      'Please, enter your email address to receive a link to reset your password.',
      name: 'forgotPasswordInfo',
      desc: '',
      args: [],
    );
  }

  /// `We have sent an email to `
  String get forgotPasswordConfirmation1 {
    return Intl.message(
      'We have sent an email to ',
      name: 'forgotPasswordConfirmation1',
      desc: '',
      args: [],
    );
  }

  /// ` to recover your password. Once you receive the email, follow the link provided to sign in.`
  String get forgotPasswordConfirmation2 {
    return Intl.message(
      ' to recover your password. Once you receive the email, follow the link provided to sign in.',
      name: 'forgotPasswordConfirmation2',
      desc: '',
      args: [],
    );
  }

  /// `15 days`
  String get fortnight {
    return Intl.message('15 days', name: 'fortnight', desc: '', args: []);
  }

  /// `From {start} to {end}`
  String fromTo(String start, String end) {
    return Intl.message(
      'From $start to $end',
      name: 'fromTo',
      desc: '',
      args: [start, end],
    );
  }

  /// `Sign in with Google`
  String get googleSignIn {
    return Intl.message(
      'Sign in with Google',
      name: 'googleSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Hi, {person}!`
  String hi(String person) {
    return Intl.message('Hi, $person!', name: 'hi', desc: '', args: [person]);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Last Month`
  String get lastMonth {
    return Intl.message('Last Month', name: 'lastMonth', desc: '', args: []);
  }

  /// `Last services`
  String get lastServices {
    return Intl.message(
      'Last services',
      name: 'lastServices',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to leave the app?`
  String get leaveApp {
    return Intl.message(
      'Do you really want to leave the app?',
      name: 'leaveApp',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get lightMode {
    return Intl.message('Light Mode', name: 'lightMode', desc: '', args: []);
  }

  /// `Load more`
  String get loadMore {
    return Intl.message('Load more', name: 'loadMore', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Do you really want to logout?`
  String get logoutConfirmation {
    return Intl.message(
      'Do you really want to logout?',
      name: 'logoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message('Month', name: 'month', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `New Client`
  String get newClient {
    return Intl.message('New Client', name: 'newClient', desc: '', args: []);
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `New service`
  String get newService {
    return Intl.message('New service', name: 'newService', desc: '', args: []);
  }

  /// `New service`
  String get newCatalogItem {
    return Intl.message(
      'New service',
      name: 'newCatalogItem',
      desc: '',
      args: [],
    );
  }

  /// `No color`
  String get noColor {
    return Intl.message('No color', name: 'noColor', desc: '', args: []);
  }

  /// `No results`
  String get noResults {
    return Intl.message('No results', name: 'noResults', desc: '', args: []);
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message('Try again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Your data is saved — just try again.`
  String get errorDataIsSafe {
    return Intl.message(
      'Your data is saved — just try again.',
      name: 'errorDataIsSafe',
      desc: '',
      args: [],
    );
  }

  /// `optional`
  String get optional {
    return Intl.message('optional', name: 'optional', desc: '', args: []);
  }

  /// `No services registered today`
  String get noServicesToday {
    return Intl.message(
      'No services registered today',
      name: 'noServicesToday',
      desc: '',
      args: [],
    );
  }

  /// `See in the list`
  String get seeInList {
    return Intl.message(
      'See in the list',
      name: 'seeInList',
      desc: '',
      args: [],
    );
  }

  /// `See the {month} summary`
  String seeSummaryOf(String month) {
    return Intl.message(
      'See the $month summary',
      name: 'seeSummaryOf',
      desc: '',
      args: [month],
    );
  }

  /// `Register one and it shows up here.`
  String get noServicesTodayDescription {
    return Intl.message(
      'Register one and it shows up here.',
      name: 'noServicesTodayDescription',
      desc: '',
      args: [],
    );
  }

  /// `Your catalog is empty. Tap the button above to add your first service.`
  String get noCatalogItems {
    return Intl.message(
      'Your catalog is empty. Tap the button above to add your first service.',
      name: 'noCatalogItems',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Order by`
  String get orderBy {
    return Intl.message('Order by', name: 'orderBy', desc: '', args: []);
  }

  /// `Least current to most current`
  String get orderDateAsc {
    return Intl.message(
      'Least current to most current',
      name: 'orderDateAsc',
      desc: '',
      args: [],
    );
  }

  /// `Most current to least current`
  String get orderDateDesc {
    return Intl.message(
      'Most current to least current',
      name: 'orderDateDesc',
      desc: '',
      args: [],
    );
  }

  /// `Lowest to highest`
  String get orderValueAsc {
    return Intl.message(
      'Lowest to highest',
      name: 'orderValueAsc',
      desc: '',
      args: [],
    );
  }

  /// `Highest to lowest`
  String get orderValueDesc {
    return Intl.message(
      'Highest to lowest',
      name: 'orderValueDesc',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Period`
  String get period {
    return Intl.message('Period', name: 'period', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Privacy Police`
  String get privacyPolice {
    return Intl.message(
      'Privacy Police',
      name: 'privacyPolice',
      desc: '',
      args: [],
    );
  }

  /// `Lucas Guimarães built the Kazi app as an Ad Supported app. This SERVICE is provided by Lucas Guimarães at no cost and is intended for use as is.\nThis page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.\nIf you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Kazi unless otherwise defined in this Privacy Policy.`
  String get privacyPoliceStart {
    return Intl.message(
      'Lucas Guimarães built the Kazi app as an Ad Supported app. This SERVICE is provided by Lucas Guimarães at no cost and is intended for use as is.\nThis page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.\nIf you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Kazi unless otherwise defined in this Privacy Policy.',
      name: 'privacyPoliceStart',
      desc: '',
      args: [],
    );
  }

  /// `For a better experience, while using our Service, I may require you to provide certain personally identifiable information, including but not limited to your name and e-mail address, which come from the Google account you sign in with. That information, together with the services, clients and settings you register, is stored in your account so it is available on every device you sign in from.\nThe app also uses third-party services that may collect information used to identify you.\nLink to the privacy policy of third-party service providers used by the app:\n`
  String get privacyPoliceInformation {
    return Intl.message(
      'For a better experience, while using our Service, I may require you to provide certain personally identifiable information, including but not limited to your name and e-mail address, which come from the Google account you sign in with. That information, together with the services, clients and settings you register, is stored in your account so it is available on every device you sign in from.\nThe app also uses third-party services that may collect information used to identify you.\nLink to the privacy policy of third-party service providers used by the app:\n',
      name: 'privacyPoliceInformation',
      desc: '',
      args: [],
    );
  }

  /// `Google Play Services`
  String get privacyPoliceInformation1 {
    return Intl.message(
      'Google Play Services',
      name: 'privacyPoliceInformation1',
      desc: '',
      args: [],
    );
  }

  /// `AdMob`
  String get privacyPoliceInformation2 {
    return Intl.message(
      'AdMob',
      name: 'privacyPoliceInformation2',
      desc: '',
      args: [],
    );
  }

  /// `Google Analytics`
  String get privacyPoliceInformation3 {
    return Intl.message(
      'Google Analytics',
      name: 'privacyPoliceInformation3',
      desc: '',
      args: [],
    );
  }

  /// `Firebase Crashlytics`
  String get privacyPoliceInformation4 {
    return Intl.message(
      'Firebase Crashlytics',
      name: 'privacyPoliceInformation4',
      desc: '',
      args: [],
    );
  }

  /// `Information Collection and Use`
  String get privacyPoliceInformationTitle {
    return Intl.message(
      'Information Collection and Use',
      name: 'privacyPoliceInformationTitle',
      desc: '',
      args: [],
    );
  }

  /// `I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.`
  String get privacyPoliceLogData {
    return Intl.message(
      'I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.',
      name: 'privacyPoliceLogData',
      desc: '',
      args: [],
    );
  }

  /// `Log Data`
  String get privacyPoliceLogDataTitle {
    return Intl.message(
      'Log Data',
      name: 'privacyPoliceLogDataTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.\nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.`
  String get privacyPoliceCookies {
    return Intl.message(
      'Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device\'s internal memory.\nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.',
      name: 'privacyPoliceCookies',
      desc: '',
      args: [],
    );
  }

  /// `Cookies`
  String get privacyPoliceCookiesTitle {
    return Intl.message(
      'Cookies',
      name: 'privacyPoliceCookiesTitle',
      desc: '',
      args: [],
    );
  }

  /// `I may employ third-party companies and individuals due to the following reasons:\n\nTo facilitate our Service;\nTo provide the Service on our behalf;\nTo perform Service-related services; or\nTo assist us in analyzing how our Service is used.\nI want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.`
  String get privacyPoliceServices {
    return Intl.message(
      'I may employ third-party companies and individuals due to the following reasons:\n\nTo facilitate our Service;\nTo provide the Service on our behalf;\nTo perform Service-related services; or\nTo assist us in analyzing how our Service is used.\nI want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.',
      name: 'privacyPoliceServices',
      desc: '',
      args: [],
    );
  }

  /// `Service Providers`
  String get privacyPoliceServicesTitle {
    return Intl.message(
      'Service Providers',
      name: 'privacyPoliceServicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.`
  String get privacyPoliceSecurity {
    return Intl.message(
      'I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.',
      name: 'privacyPoliceSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get privacyPoliceSecurityTitle {
    return Intl.message(
      'Security',
      name: 'privacyPoliceSecurityTitle',
      desc: '',
      args: [],
    );
  }

  /// `This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.`
  String get pricayPoliceLinks {
    return Intl.message(
      'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.',
      name: 'pricayPoliceLinks',
      desc: '',
      args: [],
    );
  }

  /// `Links to Other Sites`
  String get pricayPoliceLinksTitle {
    return Intl.message(
      'Links to Other Sites',
      name: 'pricayPoliceLinksTitle',
      desc: '',
      args: [],
    );
  }

  /// `These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.`
  String get privacyPoliceChildren {
    return Intl.message(
      'These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.',
      name: 'privacyPoliceChildren',
      desc: '',
      args: [],
    );
  }

  /// `Children’s Privacy`
  String get privacyPoliceChildrenTitle {
    return Intl.message(
      'Children’s Privacy',
      name: 'privacyPoliceChildrenTitle',
      desc: '',
      args: [],
    );
  }

  /// `I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.\nThis policy is effective as of 2026-08-20.`
  String get privacyPoliceChanges {
    return Intl.message(
      'I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.\nThis policy is effective as of 2026-08-20.',
      name: 'privacyPoliceChanges',
      desc: '',
      args: [],
    );
  }

  /// `Changes to This Privacy Policy`
  String get privacyPoliceChangesTitle {
    return Intl.message(
      'Changes to This Privacy Policy',
      name: 'privacyPoliceChangesTitle',
      desc: '',
      args: [],
    );
  }

  /// `If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at `
  String get privacyPoliceContact {
    return Intl.message(
      'If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at ',
      name: 'privacyPoliceContact',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get privacyPoliceContactTitle {
    return Intl.message(
      'Contact Us',
      name: 'privacyPoliceContactTitle',
      desc: '',
      args: [],
    );
  }

  /// `This privacy policy page was created at privacypolicytemplate.net and modified/generated by App Privacy Policy Generator`
  String get privacyPoliceEnd {
    return Intl.message(
      'This privacy policy page was created at privacypolicytemplate.net and modified/generated by App Privacy Policy Generator',
      name: 'privacyPoliceEnd',
      desc: '',
      args: [],
    );
  }

  /// `RevenueCat`
  String get privacyPoliceInformation5 {
    return Intl.message(
      'RevenueCat',
      name: 'privacyPoliceInformation5',
      desc: '',
      args: [],
    );
  }

  /// `PostHog`
  String get privacyPoliceInformation6 {
    return Intl.message(
      'PostHog',
      name: 'privacyPoliceInformation6',
      desc: '',
      args: [],
    );
  }

  /// `Usage Analytics`
  String get privacyPoliceAnalyticsTitle {
    return Intl.message(
      'Usage Analytics',
      name: 'privacyPoliceAnalyticsTitle',
      desc: '',
      args: [],
    );
  }

  /// `To understand where the app gets in the way and why people stop using it, I collect usage events: which screens you open, which actions you complete, which errors you are shown, and technical attributes such as app version, language and device type.\nThese events describe behaviour, never content. They never carry the amounts you record, the names of your clients, your e-mail address, or any free text you type — the app strips those before anything is sent.\nThis is based on my legitimate interest in improving the Service, and you can object to it at any time in Menu > Privacy.\nProcessors: Google Firebase Analytics (Google LLC) and PostHog (PostHog, Inc.), whose data for this app is hosted in the European Union.`
  String get privacyPoliceAnalytics {
    return Intl.message(
      'To understand where the app gets in the way and why people stop using it, I collect usage events: which screens you open, which actions you complete, which errors you are shown, and technical attributes such as app version, language and device type.\nThese events describe behaviour, never content. They never carry the amounts you record, the names of your clients, your e-mail address, or any free text you type — the app strips those before anything is sent.\nThis is based on my legitimate interest in improving the Service, and you can object to it at any time in Menu > Privacy.\nProcessors: Google Firebase Analytics (Google LLC) and PostHog (PostHog, Inc.), whose data for this app is hosted in the European Union.',
      name: 'privacyPoliceAnalytics',
      desc: '',
      args: [],
    );
  }

  /// `Session Recording`
  String get privacyPoliceReplayTitle {
    return Intl.message(
      'Session Recording',
      name: 'privacyPoliceReplayTitle',
      desc: '',
      args: [],
    );
  }

  /// `With your explicit permission, and only then, the app may record a session as a series of screenshots, so I can see where people get stuck.\nEvery text and every image is masked on your device before anything is sent. What is stored shows layout, taps and scrolling — not what is written on the screen.\nRecording is never on by default. You are asked once, and you can withdraw permission at any time in Menu > Privacy, which stops it immediately. Not every session is recorded: a sample is, plus sessions where the app detects that something went wrong.`
  String get privacyPoliceReplay {
    return Intl.message(
      'With your explicit permission, and only then, the app may record a session as a series of screenshots, so I can see where people get stuck.\nEvery text and every image is masked on your device before anything is sent. What is stored shows layout, taps and scrolling — not what is written on the screen.\nRecording is never on by default. You are asked once, and you can withdraw permission at any time in Menu > Privacy, which stops it immediately. Not every session is recorded: a sample is, plus sessions where the app detects that something went wrong.',
      name: 'privacyPoliceReplay',
      desc: '',
      args: [],
    );
  }

  /// `Data Retention`
  String get privacyPoliceRetentionTitle {
    return Intl.message(
      'Data Retention',
      name: 'privacyPoliceRetentionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your services, clients and settings are kept for as long as your account exists, and are deleted when you ask for the account to be deleted.\nUsage events and session recordings are kept for a limited period by the analytics providers and are deleted automatically afterwards. Crash reports are kept for up to 90 days.`
  String get privacyPoliceRetention {
    return Intl.message(
      'Your services, clients and settings are kept for as long as your account exists, and are deleted when you ask for the account to be deleted.\nUsage events and session recordings are kept for a limited period by the analytics providers and are deleted automatically afterwards. Crash reports are kept for up to 90 days.',
      name: 'privacyPoliceRetention',
      desc: '',
      args: [],
    );
  }

  /// `Your Rights`
  String get privacyPoliceRightsTitle {
    return Intl.message(
      'Your Rights',
      name: 'privacyPoliceRightsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Under Brazil's General Data Protection Law (LGPD, Law 13.709/2018) and equivalent legislation, you have the right to confirm that your data is processed, to access it, to correct it, to request its anonymisation, blocking or deletion, to request portability, to know who it is shared with, and to object to processing based on legitimate interest.\nThe two switches in Menu > Privacy let you exercise the right to object directly in the app, without asking anyone. For anything else, write to me at the address below and I will respond.`
  String get privacyPoliceRights {
    return Intl.message(
      'Under Brazil\'s General Data Protection Law (LGPD, Law 13.709/2018) and equivalent legislation, you have the right to confirm that your data is processed, to access it, to correct it, to request its anonymisation, blocking or deletion, to request portability, to know who it is shared with, and to object to processing based on legitimate interest.\nThe two switches in Menu > Privacy let you exercise the right to object directly in the app, without asking anyone. For anything else, write to me at the address below and I will respond.',
      name: 'privacyPoliceRights',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message('Privacy', name: 'privacy', desc: '', args: []);
  }

  /// `Help improve Kazi`
  String get privacyUsageData {
    return Intl.message(
      'Help improve Kazi',
      name: 'privacyUsageData',
      desc: '',
      args: [],
    );
  }

  /// `Sends anonymous usage events so we can find what is not working. Never your amounts or your clients.`
  String get privacyUsageDataDescription {
    return Intl.message(
      'Sends anonymous usage events so we can find what is not working. Never your amounts or your clients.',
      name: 'privacyUsageDataDescription',
      desc: '',
      args: [],
    );
  }

  /// `Session recording`
  String get privacySessionRecording {
    return Intl.message(
      'Session recording',
      name: 'privacySessionRecording',
      desc: '',
      args: [],
    );
  }

  /// `Records a masked replay of some sessions. Every text and image is hidden.`
  String get privacySessionRecordingDescription {
    return Intl.message(
      'Records a masked replay of some sessions. Every text and image is hidden.',
      name: 'privacySessionRecordingDescription',
      desc: '',
      args: [],
    );
  }

  /// `Can we record how you use the app?`
  String get replayConsentTitle {
    return Intl.message(
      'Can we record how you use the app?',
      name: 'replayConsentTitle',
      desc: '',
      args: [],
    );
  }

  /// `We record taps and screens to find where Kazi gets in your way. Amounts, client names and anything you type are hidden from the recording.\n\nYou can turn it off anytime, in Menu > Session recording.`
  String get replayConsentBody {
    return Intl.message(
      'We record taps and screens to find where Kazi gets in your way. Amounts, client names and anything you type are hidden from the recording.\n\nYou can turn it off anytime, in Menu > Session recording.',
      name: 'replayConsentBody',
      desc: '',
      args: [],
    );
  }

  /// `Allow recording`
  String get replayConsentAccept {
    return Intl.message(
      'Allow recording',
      name: 'replayConsentAccept',
      desc: '',
      args: [],
    );
  }

  /// `Not now`
  String get replayConsentDecline {
    return Intl.message(
      'Not now',
      name: 'replayConsentDecline',
      desc: '',
      args: [],
    );
  }

  /// `How this is used`
  String get replayConsentLearnMore {
    return Intl.message(
      'How this is used',
      name: 'replayConsentLearnMore',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Rate the app`
  String get rateApp {
    return Intl.message('Rate the app', name: 'rateApp', desc: '', args: []);
  }

  /// `Remove filters`
  String get removeFilters {
    return Intl.message(
      'Remove filters',
      name: 'removeFilters',
      desc: '',
      args: [],
    );
  }

  /// `Resend Email`
  String get resendEmail {
    return Intl.message(
      'Resend Email',
      name: 'resendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password reseted successfully`
  String get resetedPassword {
    return Intl.message(
      'Password reseted successfully',
      name: 'resetedPassword',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message('Role', name: 'role', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Type, client or note`
  String get searchServicesHint {
    return Intl.message(
      'Type, client or note',
      name: 'searchServicesHint',
      desc: '',
      args: [],
    );
  }

  /// `Search ignores the period: it looks through everything you have registered.`
  String get searchIgnoresPeriod {
    return Intl.message(
      'Search ignores the period: it looks through everything you have registered.',
      name: 'searchIgnoresPeriod',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{1 service} other{{count} services}} · {amount} for you`
  String searchServicesFound(int count, String amount) {
    return Intl.message(
      '${Intl.plural(count, one: '1 service', other: '$count services')} · $amount for you',
      name: 'searchServicesFound',
      desc: '',
      args: [count, amount],
    );
  }

  /// `See in the summary`
  String get seeInSummary {
    return Intl.message(
      'See in the summary',
      name: 'seeInSummary',
      desc: '',
      args: [],
    );
  }

  /// `Nothing found for “{term}”`
  String nothingFoundFor(String term) {
    return Intl.message(
      'Nothing found for “$term”',
      name: 'nothingFoundFor',
      desc: '',
      args: [term],
    );
  }

  /// `No service, client or catalog item by that name.`
  String get nothingFoundForDescription {
    return Intl.message(
      'No service, client or catalog item by that name.',
      name: 'nothingFoundForDescription',
      desc: '',
      args: [],
    );
  }

  /// `Create “{term}” in the catalog`
  String createInCatalog(String term) {
    return Intl.message(
      'Create “$term” in the catalog',
      name: 'createInCatalog',
      desc: '',
      args: [term],
    );
  }

  /// `Service type`
  String get serviceType {
    return Intl.message(
      'Service type',
      name: 'serviceType',
      desc: '',
      args: [],
    );
  }

  /// `Search a type`
  String get searchServiceTypeHint {
    return Intl.message(
      'Search a type',
      name: 'searchServiceTypeHint',
      desc: '',
      args: [],
    );
  }

  /// `Show all ({count})`
  String showAllTypes(int count) {
    return Intl.message(
      'Show all ($count)',
      name: 'showAllTypes',
      desc: '',
      args: [count],
    );
  }

  /// `Status`
  String get situation {
    return Intl.message('Status', name: 'situation', desc: '', args: []);
  }

  /// `Clear all`
  String get clearAll {
    return Intl.message('Clear all', name: 'clearAll', desc: '', args: []);
  }

  /// `{count, plural, =0{No service} one{See 1 service} other{See {count} services}}`
  String seeNServices(int count) {
    return Intl.plural(
      count,
      zero: 'No service',
      one: 'See 1 service',
      other: 'See $count services',
      name: 'seeNServices',
      desc: '',
      args: [count],
    );
  }

  /// `Pick dates`
  String get pickDates {
    return Intl.message('Pick dates', name: 'pickDates', desc: '', args: []);
  }

  /// `Select the service`
  String get selectCatalogItem {
    return Intl.message(
      'Select the service',
      name: 'selectCatalogItem',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get sendEmail {
    return Intl.message('Send Email', name: 'sendEmail', desc: '', args: []);
  }

  /// `Service`
  String get service {
    return Intl.message('Service', name: 'service', desc: '', args: []);
  }

  /// `Pending`
  String get statusPending {
    return Intl.message('Pending', name: 'statusPending', desc: '', args: []);
  }

  /// `Mark as received`
  String get markAsReceived {
    return Intl.message(
      'Mark as received',
      name: 'markAsReceived',
      desc: '',
      args: [],
    );
  }

  /// `Mark as not received`
  String get unmarkAsReceived {
    return Intl.message(
      'Mark as not received',
      name: 'unmarkAsReceived',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get observation {
    return Intl.message('Note', name: 'observation', desc: '', args: []);
  }

  /// `Allergy, preference, usual time`
  String get observationHint {
    return Intl.message(
      'Allergy, preference, usual time',
      name: 'observationHint',
      desc: '',
      args: [],
    );
  }

  /// `{percent} of {amount}`
  String commissionOfGross(String percent, String amount) {
    return Intl.message(
      '$percent of $amount',
      name: 'commissionOfGross',
      desc: '',
      args: [percent, amount],
    );
  }

  /// `Service added successfully`
  String get serviceAdded {
    return Intl.message(
      'Service added successfully',
      name: 'serviceAdded',
      desc: '',
      args: [],
    );
  }

  /// `Service deleted successfully`
  String get serviceDeleted {
    return Intl.message(
      'Service deleted successfully',
      name: 'serviceDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Service updated successfully`
  String get serviceUpdated {
    return Intl.message(
      'Service updated successfully',
      name: 'serviceUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Service Value`
  String get serviceValue {
    return Intl.message(
      'Service Value',
      name: 'serviceValue',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message('Services', name: 'services', desc: '', args: []);
  }

  /// `Service`
  String get catalogItem {
    return Intl.message('Service', name: 'catalogItem', desc: '', args: []);
  }

  /// `Catalog`
  String get catalogItems {
    return Intl.message('Catalog', name: 'catalogItems', desc: '', args: []);
  }

  /// `{count, plural, one{1 item} other{{count} items}}`
  String itemsCount(int count) {
    return Intl.plural(
      count,
      one: '1 item',
      other: '$count items',
      name: 'itemsCount',
      desc: '',
      args: [count],
    );
  }

  /// `All`
  String get catalogAll {
    return Intl.message('All', name: 'catalogAll', desc: '', args: []);
  }

  /// `Most used`
  String get catalogMostUsed {
    return Intl.message(
      'Most used',
      name: 'catalogMostUsed',
      desc: '',
      args: [],
    );
  }

  /// `No commission`
  String get catalogWithoutCommission {
    return Intl.message(
      'No commission',
      name: 'catalogWithoutCommission',
      desc: '',
      args: [],
    );
  }

  /// `no commission`
  String get withoutCommission {
    return Intl.message(
      'no commission',
      name: 'withoutCommission',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{1 use} other{{count} uses}}`
  String usesCount(int count) {
    return Intl.plural(
      count,
      one: '1 use',
      other: '$count uses',
      name: 'usesCount',
      desc: '',
      args: [count],
    );
  }

  /// `Used in`
  String get usedIn {
    return Intl.message('Used in', name: 'usedIn', desc: '', args: []);
  }

  /// `Generated so far`
  String get generatedSoFar {
    return Intl.message(
      'Generated so far',
      name: 'generatedSoFar',
      desc: '',
      args: [],
    );
  }

  /// `You keep`
  String get youKeep {
    return Intl.message('You keep', name: 'youKeep', desc: '', args: []);
  }

  /// `{count, plural, one{Changing the price here applies to the next records. The service already registered keeps the value of its time.} other{Changing the price here applies to the next records. The {count} services already registered keep the value of their time.}}`
  String priceChangeNote(int count) {
    return Intl.plural(
      count,
      one:
          'Changing the price here applies to the next records. The service already registered keeps the value of its time.',
      other:
          'Changing the price here applies to the next records. The $count services already registered keep the value of their time.',
      name: 'priceChangeNote',
      desc: '',
      args: [count],
    );
  }

  /// `{name} cannot be deleted`
  String cantDeleteTitle(String name) {
    return Intl.message(
      '$name cannot be deleted',
      name: 'cantDeleteTitle',
      desc: '',
      args: [name],
    );
  }

  /// `{count, plural, one{It names 1 service already registered. Deleting it now would leave that record unidentified.} other{It names {count} services already registered. Deleting it now would leave those records unidentified — and they add up to {amount} in your history.}}`
  String cantDeleteBody(int count, String amount) {
    return Intl.plural(
      count,
      one:
          'It names 1 service already registered. Deleting it now would leave that record unidentified.',
      other:
          'It names $count services already registered. Deleting it now would leave those records unidentified — and they add up to $amount in your history.',
      name: 'cantDeleteBody',
      desc: '',
      args: [count, amount],
    );
  }

  /// `Archived is enough: the item no longer shows up when you register a new service.`
  String get cantDeleteReassurance {
    return Intl.message(
      'Archived is enough: the item no longer shows up when you register a new service.',
      name: 'cantDeleteReassurance',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{See the 1 service} other{See the {count} services}}`
  String seeTheServices(int count) {
    return Intl.plural(
      count,
      one: 'See the 1 service',
      other: 'See the $count services',
      name: 'seeTheServices',
      desc: '',
      args: [count],
    );
  }

  /// `Got it`
  String get understood {
    return Intl.message('Got it', name: 'understood', desc: '', args: []);
  }

  /// `Register what you do and for how much.`
  String get noCatalogItemsDescription {
    return Intl.message(
      'Register what you do and for how much.',
      name: 'noCatalogItemsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Sign out of account`
  String get signOut {
    return Intl.message(
      'Sign out of account',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Sign out of account?`
  String get signOutTitle {
    return Intl.message(
      'Sign out of account?',
      name: 'signOutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signOutConfirm {
    return Intl.message('Sign out', name: 'signOutConfirm', desc: '', args: []);
  }

  /// `Your services stay saved. To see them again, just sign in with the same account.`
  String get signOutConfirmation {
    return Intl.message(
      'Your services stay saved. To see them again, just sign in with the same account.',
      name: 'signOutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Account created successfully`
  String get signUpSuccess {
    return Intl.message(
      'Account created successfully',
      name: 'signUpSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Action done successfully`
  String get success {
    return Intl.message(
      'Action done successfully',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `this service`
  String get thisService {
    return Intl.message(
      'this service',
      name: 'thisService',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `{count, plural, one{Today · 1 service} other{Today · {count} services}}`
  String todaySection(int count) {
    return Intl.plural(
      count,
      one: 'Today · 1 service',
      other: 'Today · $count services',
      name: 'todaySection',
      desc: '',
      args: [count],
    );
  }

  /// `Today's services`
  String get todaysServices {
    return Intl.message(
      'Today\'s services',
      name: 'todaysServices',
      desc: '',
      args: [],
    );
  }

  /// `Total value`
  String get total {
    return Intl.message('Total value', name: 'total', desc: '', args: []);
  }

  /// `Perfil Area`
  String get tourAppBarTitle {
    return Intl.message(
      'Perfil Area',
      name: 'tourAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Here you build your service catalog and log out of your account.`
  String get tourAppBarDescription {
    return Intl.message(
      'Here you build your service catalog and log out of your account.',
      name: 'tourAppBarDescription',
      desc: '',
      args: [],
    );
  }

  /// `Services Area`
  String get tourBottomNavigationServicesTitle {
    return Intl.message(
      'Services Area',
      name: 'tourBottomNavigationServicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `In this menu you will find all the services you have performed, and also being able to register a new service.`
  String get tourBottomNavigationServicesDescription {
    return Intl.message(
      'In this menu you will find all the services you have performed, and also being able to register a new service.',
      name: 'tourBottomNavigationServicesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get tourHomeBalanceTitle {
    return Intl.message(
      'Balance',
      name: 'tourHomeBalanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Here your daily earnings are displayed, also the total discount and the total received.`
  String get tourHomeBalanceDescription {
    return Intl.message(
      'Here your daily earnings are displayed, also the total discount and the total received.',
      name: 'tourHomeBalanceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Daily Services`
  String get tourHomeServicesTitle {
    return Intl.message(
      'Daily Services',
      name: 'tourHomeServicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `These are the services you performed today.`
  String get tourHomeServicesDescription {
    return Intl.message(
      'These are the services you performed today.',
      name: 'tourHomeServicesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get tourProfileTitle {
    return Intl.message(
      'Actions',
      name: 'tourProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Here you build your catalog: the services you offer, with price and commission ready for every entry.`
  String get tourProfileDescription {
    return Intl.message(
      'Here you build your catalog: the services you offer, with price and commission ready for every entry.',
      name: 'tourProfileDescription',
      desc: '',
      args: [],
    );
  }

  /// `Service Details`
  String get tourServiceDetailsTitle {
    return Intl.message(
      'Service Details',
      name: 'tourServiceDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can click in the services to see all the information, update or delete it.`
  String get tourServiceDetailsDescription {
    return Intl.message(
      'You can click in the services to see all the information, update or delete it.',
      name: 'tourServiceDetailsDescription',
      desc: '',
      args: [],
    );
  }

  /// `New Service`
  String get tourServicesForm1Title {
    return Intl.message(
      'New Service',
      name: 'tourServicesForm1Title',
      desc: '',
      args: [],
    );
  }

  /// `Pick a service from your catalog and the amounts come filled in. You can adjust them for this entry alone.`
  String get tourServicesForm1Description {
    return Intl.message(
      'Pick a service from your catalog and the amounts come filled in. You can adjust them for this entry alone.',
      name: 'tourServicesForm1Description',
      desc: '',
      args: [],
    );
  }

  /// `New Service`
  String get tourServicesForm2Title {
    return Intl.message(
      'New Service',
      name: 'tourServicesForm2Title',
      desc: '',
      args: [],
    );
  }

  /// `Just select the date and the number of services performed, and fill in a description or note if you wish.`
  String get tourServicesForm2Description {
    return Intl.message(
      'Just select the date and the number of services performed, and fill in a description or note if you wish.',
      name: 'tourServicesForm2Description',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get tourServicesInfoTitle {
    return Intl.message(
      'Services',
      name: 'tourServicesInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Here you can filter and sort your services and view the balance for the selected period. You can also register performed services.`
  String get tourServicesInfoDescription {
    return Intl.message(
      'Here you can filter and sort your services and view the balance for the selected period. You can also register performed services.',
      name: 'tourServicesInfoDescription',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get tourServicesListTitle {
    return Intl.message(
      'Services',
      name: 'tourServicesListTitle',
      desc: '',
      args: [],
    );
  }

  /// `These are all the jobs you've provided in a given period of time. By default you will see all the services for the current month.`
  String get tourServicesListDescription {
    return Intl.message(
      'These are all the jobs you\'ve provided in a given period of time. By default you will see all the services for the current month.',
      name: 'tourServicesListDescription',
      desc: '',
      args: [],
    );
  }

  /// `Catalog`
  String get tourCatalogItemsTitle {
    return Intl.message(
      'Catalog',
      name: 'tourCatalogItemsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name the service, such as "Lashes - Brazilian Volume", and fill in its default price and the commission you receive for it.`
  String get tourCatalogItemsDescription {
    return Intl.message(
      'Name the service, such as "Lashes - Brazilian Volume", and fill in its default price and the commission you receive for it.',
      name: 'tourCatalogItemsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Undo`
  String get undo {
    return Intl.message('Undo', name: 'undo', desc: '', args: []);
  }

  /// `Update Password`
  String get updatePassword {
    return Intl.message(
      'Update Password',
      name: 'updatePassword',
      desc: '',
      args: [],
    );
  }

  /// `This version of Kazi has stopped working`
  String get forcedUpdateTitle {
    return Intl.message(
      'This version of Kazi has stopped working',
      name: 'forcedUpdateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Update to continue — your data is saved and appears as soon as the app opens.`
  String get forcedUpdateMessage {
    return Intl.message(
      'Update to continue — your data is saved and appears as soon as the app opens.',
      name: 'forcedUpdateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Update now`
  String get forcedUpdateButton {
    return Intl.message(
      'Update now',
      name: 'forcedUpdateButton',
      desc: '',
      args: [],
    );
  }

  /// `Version {latest} · you're on {current}`
  String forcedUpdateVersions(Object latest, Object current) {
    return Intl.message(
      'Version $latest · you\'re on $current',
      name: 'forcedUpdateVersions',
      desc: '',
      args: [latest, current],
    );
  }

  /// `Update available`
  String get optionalUpdateTitle {
    return Intl.message(
      'Update available',
      name: 'optionalUpdateTitle',
      desc: '',
      args: [],
    );
  }

  /// `A new version of Kazi is available with improvements. Would you like to update now?`
  String get optionalUpdateMessage {
    return Intl.message(
      'A new version of Kazi is available with improvements. Would you like to update now?',
      name: 'optionalUpdateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get updateNow {
    return Intl.message('Update', name: 'updateNow', desc: '', args: []);
  }

  /// `Later`
  String get updateLater {
    return Intl.message('Later', name: 'updateLater', desc: '', args: []);
  }

  /// `By continuing, you agree to the `
  String get userTermsAlert1 {
    return Intl.message(
      'By continuing, you agree to the ',
      name: 'userTermsAlert1',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service `
  String get userTermsAlert2 {
    return Intl.message(
      'Terms of Service ',
      name: 'userTermsAlert2',
      desc: '',
      args: [],
    );
  }

  /// `and confirm that you have read our `
  String get userTermsAlert3 {
    return Intl.message(
      'and confirm that you have read our ',
      name: 'userTermsAlert3',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get userTermsAlert4 {
    return Intl.message(
      'Privacy Policy',
      name: 'userTermsAlert4',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get validatorConfirmPassword {
    return Intl.message(
      'Passwords don\'t match',
      name: 'validatorConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email is invalid or badly formatted`
  String get validatorEmail {
    return Intl.message(
      'Email is invalid or badly formatted',
      name: 'validatorEmail',
      desc: '',
      args: [],
    );
  }

  /// `Your password must have a minimum of 8 characters and a maximum of 16`
  String get validatorPassword {
    return Intl.message(
      'Your password must have a minimum of 8 characters and a maximum of 16',
      name: 'validatorPassword',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `+ New`
  String get newShort {
    return Intl.message('+ New', name: 'newShort', desc: '', args: []);
  }

  /// `Price and commission come from the catalog. You can change them for this record only.`
  String get catalogItemFormHint {
    return Intl.message(
      'Price and commission come from the catalog. You can change them for this record only.',
      name: 'catalogItemFormHint',
      desc: '',
      args: [],
    );
  }

  /// `Optional. It feeds the history and the per-client summary.`
  String get clientFormHint {
    return Intl.message(
      'Optional. It feeds the history and the per-client summary.',
      name: 'clientFormHint',
      desc: '',
      args: [],
    );
  }

  /// `{amount} is yours`
  String yoursFromThis(String amount) {
    return Intl.message(
      '$amount is yours',
      name: 'yoursFromThis',
      desc: '',
      args: [amount],
    );
  }

  /// `Pick`
  String get pickDate {
    return Intl.message('Pick', name: 'pickDate', desc: '', args: []);
  }

  /// `Register service`
  String get registerService {
    return Intl.message(
      'Register service',
      name: 'registerService',
      desc: '',
      args: [],
    );
  }

  /// `The currency the service was charged in`
  String get serviceCurrencyHint {
    return Intl.message(
      'The currency the service was charged in',
      name: 'serviceCurrencyHint',
      desc: '',
      args: [],
    );
  }

  /// `How many times the service was performed`
  String get quantityHint {
    return Intl.message(
      'How many times the service was performed',
      name: 'quantityHint',
      desc: '',
      args: [],
    );
  }

  /// `To reach them later`
  String get phoneHint {
    return Intl.message(
      'To reach them later',
      name: 'phoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Only so you can identify the person and issue a receipt. Kazi neither validates this number nor sends it anywhere.`
  String get documentPrivacyHint {
    return Intl.message(
      'Only so you can identify the person and issue a receipt. Kazi neither validates this number nor sends it anywhere.',
      name: 'documentPrivacyHint',
      desc: '',
      args: [],
    );
  }

  /// `Tax id, national id or other`
  String get documentHint {
    return Intl.message(
      'Tax id, national id or other',
      name: 'documentHint',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{{name} already exists, with 1 service. If it's the same person, use the one already there so the history isn't split in two.} other{{name} already exists, with {count} services. If it's the same person, use the one already there so the history isn't split in two.}}`
  String clientNamesake(int count, String name) {
    return Intl.plural(
      count,
      one:
          '$name already exists, with 1 service. If it\'s the same person, use the one already there so the history isn\'t split in two.',
      other:
          '$name already exists, with $count services. If it\'s the same person, use the one already there so the history isn\'t split in two.',
      name: 'clientNamesake',
      desc: '',
      args: [count, name],
    );
  }

  /// `{name} already exists, last seen for {service} on {date}. If it's the same person, use the one already there so the history isn't split in two.`
  String clientNamesakeLastService(String name, String service, String date) {
    return Intl.message(
      '$name already exists, last seen for $service on $date. If it\'s the same person, use the one already there so the history isn\'t split in two.',
      name: 'clientNamesakeLastService',
      desc: '',
      args: [name, service, date],
    );
  }

  /// `{name} already exists. If it's the same person, use the one already there so the history isn't split in two.`
  String clientNamesakePlain(String name) {
    return Intl.message(
      '$name already exists. If it\'s the same person, use the one already there so the history isn\'t split in two.',
      name: 'clientNamesakePlain',
      desc: '',
      args: [name],
    );
  }

  /// `Use the {name} that already exists`
  String useExistingClient(String name) {
    return Intl.message(
      'Use the $name that already exists',
      name: 'useExistingClient',
      desc: '',
      args: [name],
    );
  }

  /// `Create anyway`
  String get createAnyway {
    return Intl.message(
      'Create anyway',
      name: 'createAnyway',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Create and use`
  String get createAndUse {
    return Intl.message(
      'Create and use',
      name: 'createAndUse',
      desc: '',
      args: [],
    );
  }

  /// `Default price`
  String get defaultPrice {
    return Intl.message(
      'Default price',
      name: 'defaultPrice',
      desc: '',
      args: [],
    );
  }

  /// `What was done`
  String get whatWasDone {
    return Intl.message(
      'What was done',
      name: 'whatWasDone',
      desc: '',
      args: [],
    );
  }

  /// `Who you served`
  String get whoWasServed {
    return Intl.message(
      'Who you served',
      name: 'whoWasServed',
      desc: '',
      args: [],
    );
  }

  /// `Color · swipe to see all`
  String get colorSwipeAll {
    return Intl.message(
      'Color · swipe to see all',
      name: 'colorSwipeAll',
      desc: '',
      args: [],
    );
  }

  /// `Saving…`
  String get saving {
    return Intl.message('Saving…', name: 'saving', desc: '', args: []);
  }

  /// `Your earnings`
  String get yourEarnings {
    return Intl.message(
      'Your earnings',
      name: 'yourEarnings',
      desc: '',
      args: [],
    );
  }

  /// `your earnings per week`
  String get earningsPerWeek {
    return Intl.message(
      'your earnings per week',
      name: 'earningsPerWeek',
      desc: '',
      args: [],
    );
  }

  /// `7 days`
  String get week {
    return Intl.message('7 days', name: 'week', desc: '', args: []);
  }

  /// `Would you like to delete {item}?`
  String wouldYouLikeDelete(String item) {
    return Intl.message(
      'Would you like to delete $item?',
      name: 'wouldYouLikeDelete',
      desc: '',
      args: [item],
    );
  }

  /// `{property} already exists`
  String alreadyExists(String property) {
    return Intl.message(
      '$property already exists',
      name: 'alreadyExists',
      desc: '',
      args: [property],
    );
  }

  /// `{property} is Empty`
  String isEmpty(String property) {
    return Intl.message(
      '$property is Empty',
      name: 'isEmpty',
      desc: '',
      args: [property],
    );
  }

  /// `Please, inform a valid number`
  String get invalidNumber {
    return Intl.message(
      'Please, inform a valid number',
      name: 'invalidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please, inform a valid integer number`
  String get invalidIntNumber {
    return Intl.message(
      'Please, inform a valid integer number',
      name: 'invalidIntNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please, inform a number equal or greater than 0`
  String get numberLesserThanZero {
    return Intl.message(
      'Please, inform a number equal or greater than 0',
      name: 'numberLesserThanZero',
      desc: '',
      args: [],
    );
  }

  /// `Please, inform a number equal or lesser than 100`
  String get numberBiggerThan100 {
    return Intl.message(
      'Please, inform a number equal or lesser than 100',
      name: 'numberBiggerThan100',
      desc: '',
      args: [],
    );
  }

  /// `{property} is being used`
  String inUse(String property) {
    return Intl.message(
      '$property is being used',
      name: 'inUse',
      desc: '',
      args: [property],
    );
  }

  /// `{property} is invalid`
  String invalidProperty(String property) {
    return Intl.message(
      '$property is invalid',
      name: 'invalidProperty',
      desc: '',
      args: [property],
    );
  }

  /// `{property} is required`
  String requiredProperty(String property) {
    return Intl.message(
      '$property is required',
      name: 'requiredProperty',
      desc: '',
      args: [property],
    );
  }

  /// `Client`
  String get client {
    return Intl.message('Client', name: 'client', desc: '', args: []);
  }

  /// `Select the client`
  String get selectClient {
    return Intl.message(
      'Select the client',
      name: 'selectClient',
      desc: '',
      args: [],
    );
  }

  /// `Add client`
  String get addClient {
    return Intl.message('Add client', name: 'addClient', desc: '', args: []);
  }

  /// `Search by name`
  String get searchByName {
    return Intl.message(
      'Search by name',
      name: 'searchByName',
      desc: '',
      args: [],
    );
  }

  /// `No clients found`
  String get noClientsFound {
    return Intl.message(
      'No clients found',
      name: 'noClientsFound',
      desc: '',
      args: [],
    );
  }

  /// `No services yet`
  String get noServicesYet {
    return Intl.message(
      'No services yet',
      name: 'noServicesYet',
      desc: '',
      args: [],
    );
  }

  /// `this client`
  String get thisClient {
    return Intl.message('this client', name: 'thisClient', desc: '', args: []);
  }

  /// `this service`
  String get thisCatalogItem {
    return Intl.message(
      'this service',
      name: 'thisCatalogItem',
      desc: '',
      args: [],
    );
  }

  /// `Error to get clients.`
  String get errorToGetClients {
    return Intl.message(
      'Error to get clients.',
      name: 'errorToGetClients',
      desc: '',
      args: [],
    );
  }

  /// `Error to add client.`
  String get errorToAddClient {
    return Intl.message(
      'Error to add client.',
      name: 'errorToAddClient',
      desc: '',
      args: [],
    );
  }

  /// `Error to update client.`
  String get errorToUpdateClient {
    return Intl.message(
      'Error to update client.',
      name: 'errorToUpdateClient',
      desc: '',
      args: [],
    );
  }

  /// `Error to delete client.`
  String get errorToDeleteClient {
    return Intl.message(
      'Error to delete client.',
      name: 'errorToDeleteClient',
      desc: '',
      args: [],
    );
  }

  /// `Document`
  String get document {
    return Intl.message('Document', name: 'document', desc: '', args: []);
  }

  /// `Birthday`
  String get birthDate {
    return Intl.message('Birthday', name: 'birthDate', desc: '', args: []);
  }

  /// `Free`
  String get freePlan {
    return Intl.message('Free', name: 'freePlan', desc: '', args: []);
  }

  /// `Premium`
  String get premiumPlan {
    return Intl.message('Premium', name: 'premiumPlan', desc: '', args: []);
  }

  /// `Unlock Kazi Premium`
  String get paywallTitle {
    return Intl.message(
      'Unlock Kazi Premium',
      name: 'paywallTitle',
      desc: '',
      args: [],
    );
  }

  /// `Remove every limit and all ads.`
  String get paywallSubtitle {
    return Intl.message(
      'Remove every limit and all ads.',
      name: 'paywallSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Start 7-day free trial`
  String get paywallStartTrial {
    return Intl.message(
      'Start 7-day free trial',
      name: 'paywallStartTrial',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get paywallSubscribe {
    return Intl.message(
      'Subscribe',
      name: 'paywallSubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Restore purchase`
  String get paywallRestore {
    return Intl.message(
      'Restore purchase',
      name: 'paywallRestore',
      desc: '',
      args: [],
    );
  }

  /// `Auto-renews monthly. Cancel anytime.`
  String get paywallRenewInfo {
    return Intl.message(
      'Auto-renews monthly. Cancel anytime.',
      name: 'paywallRenewInfo',
      desc: '',
      args: [],
    );
  }

  /// `{price}/month`
  String paywallPricePerMonth(String price) {
    return Intl.message(
      '$price/month',
      name: 'paywallPricePerMonth',
      desc: '',
      args: [price],
    );
  }

  /// `7 days free, then {price}/month.`
  String paywallTrialThenPrice(String price) {
    return Intl.message(
      '7 days free, then $price/month.',
      name: 'paywallTrialThenPrice',
      desc: '',
      args: [price],
    );
  }

  /// `Unlimited services`
  String get featureUnlimitedServices {
    return Intl.message(
      'Unlimited services',
      name: 'featureUnlimitedServices',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited catalog`
  String get featureUnlimitedCatalog {
    return Intl.message(
      'Unlimited catalog',
      name: 'featureUnlimitedCatalog',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited clients`
  String get featureUnlimitedClients {
    return Intl.message(
      'Unlimited clients',
      name: 'featureUnlimitedClients',
      desc: '',
      args: [],
    );
  }

  /// `No ads`
  String get featureNoAds {
    return Intl.message('No ads', name: 'featureNoAds', desc: '', args: []);
  }

  /// `You reached this month's service limit`
  String get limitReachedServicesTitle {
    return Intl.message(
      'You reached this month\'s service limit',
      name: 'limitReachedServicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `You reached your catalog limit`
  String get limitReachedCatalogTitle {
    return Intl.message(
      'You reached your catalog limit',
      name: 'limitReachedCatalogTitle',
      desc: '',
      args: [],
    );
  }

  /// `You reached the client limit`
  String get limitReachedClientsTitle {
    return Intl.message(
      'You reached the client limit',
      name: 'limitReachedClientsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Go Premium to keep adding without limits.`
  String get limitReachedSubtitle {
    return Intl.message(
      'Go Premium to keep adding without limits.',
      name: 'limitReachedSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Free vs Premium`
  String get planComparisonTitle {
    return Intl.message(
      'Free vs Premium',
      name: 'planComparisonTitle',
      desc: '',
      args: [],
    );
  }

  /// `{count} services / month`
  String freeLimitServices(int count) {
    return Intl.message(
      '$count services / month',
      name: 'freeLimitServices',
      desc: '',
      args: [count],
    );
  }

  /// `{count} services in the catalog`
  String freeLimitCatalogItems(int count) {
    return Intl.message(
      '$count services in the catalog',
      name: 'freeLimitCatalogItems',
      desc: '',
      args: [count],
    );
  }

  /// `{count} clients`
  String freeLimitClients(int count) {
    return Intl.message(
      '$count clients',
      name: 'freeLimitClients',
      desc: '',
      args: [count],
    );
  }

  /// `With ads`
  String get freeLimitAds {
    return Intl.message('With ads', name: 'freeLimitAds', desc: '', args: []);
  }

  /// `Everything unlimited, no ads`
  String get premiumUnlimited {
    return Intl.message(
      'Everything unlimited, no ads',
      name: 'premiumUnlimited',
      desc: '',
      args: [],
    );
  }

  /// `Manage plan`
  String get managePlan {
    return Intl.message('Manage plan', name: 'managePlan', desc: '', args: []);
  }

  /// `Go Premium`
  String get goPremium {
    return Intl.message('Go Premium', name: 'goPremium', desc: '', args: []);
  }

  /// `Menu`
  String get menu {
    return Intl.message('Menu', name: 'menu', desc: '', args: []);
  }

  /// `My work`
  String get myWork {
    return Intl.message('My work', name: 'myWork', desc: '', args: []);
  }

  /// `Preferences`
  String get preferences {
    return Intl.message('Preferences', name: 'preferences', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Service catalog`
  String get serviceCatalog {
    return Intl.message(
      'Service catalog',
      name: 'serviceCatalog',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `System`
  String get themeSystem {
    return Intl.message('System', name: 'themeSystem', desc: '', args: []);
  }

  /// `follows the device`
  String get themeSystemDetail {
    return Intl.message(
      'follows the device',
      name: 'themeSystemDetail',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get themeLight {
    return Intl.message('Light', name: 'themeLight', desc: '', args: []);
  }

  /// `Dark`
  String get themeDark {
    return Intl.message('Dark', name: 'themeDark', desc: '', args: []);
  }

  /// `The change is immediate and applies to the whole app. The sheet stays open so you can compare.`
  String get themeChangeNote {
    return Intl.message(
      'The change is immediate and applies to the whole app. The sheet stays open so you can compare.',
      name: 'themeChangeNote',
      desc: '',
      args: [],
    );
  }

  /// `kazi · work`
  String get splashSignature {
    return Intl.message(
      'kazi · work',
      name: 'splashSignature',
      desc: '',
      args: [],
    );
  }

  /// `Your work, made clear.`
  String get loginHeadline {
    return Intl.message(
      'Your work, made clear.',
      name: 'loginHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to see how much you make and how much you keep.`
  String get loginSubtitle {
    return Intl.message(
      'Sign in to see how much you make and how much you keep.',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `By continuing, you accept the {privacy}.`
  String loginLegal(String privacy) {
    return Intl.message(
      'By continuing, you accept the $privacy.',
      name: 'loginLegal',
      desc: '',
      args: [privacy],
    );
  }

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Summary`
  String get summary {
    return Intl.message('Summary', name: 'summary', desc: '', args: []);
  }

  /// `List`
  String get list {
    return Intl.message('List', name: 'list', desc: '', args: []);
  }

  /// `of {amount}`
  String ofGross(String amount) {
    return Intl.message(
      'of $amount',
      name: 'ofGross',
      desc: '',
      args: [amount],
    );
  }

  /// `Generated in the period`
  String get generatedInPeriod {
    return Intl.message(
      'Generated in the period',
      name: 'generatedInPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Generated`
  String get generated {
    return Intl.message('Generated', name: 'generated', desc: '', args: []);
  }

  /// `Your earnings: {amount}`
  String yourEarningsAmount(String amount) {
    return Intl.message(
      'Your earnings: $amount',
      name: 'yourEarningsAmount',
      desc: '',
      args: [amount],
    );
  }

  /// `By service`
  String get byCatalogItem {
    return Intl.message(
      'By service',
      name: 'byCatalogItem',
      desc: '',
      args: [],
    );
  }

  /// `Clients who earned the most`
  String get topClients {
    return Intl.message(
      'Clients who earned the most',
      name: 'topClients',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{1 service} other{{count} services}}`
  String servicesCount(int count) {
    return Intl.plural(
      count,
      one: '1 service',
      other: '$count services',
      name: 'servicesCount',
      desc: '',
      args: [count],
    );
  }

  /// `Pending`
  String get pendingReceipt {
    return Intl.message('Pending', name: 'pendingReceipt', desc: '', args: []);
  }

  /// `Received`
  String get receivedPlural {
    return Intl.message('Received', name: 'receivedPlural', desc: '', args: []);
  }

  /// `All`
  String get allReceipts {
    return Intl.message('All', name: 'allReceipts', desc: '', args: []);
  }

  /// `All clients`
  String get allClients {
    return Intl.message('All clients', name: 'allClients', desc: '', args: []);
  }

  /// `Not in the catalog`
  String get withoutCatalogItem {
    return Intl.message(
      'Not in the catalog',
      name: 'withoutCatalogItem',
      desc: '',
      args: [],
    );
  }

  /// `No service matches these filters.`
  String get noServicesForFilters {
    return Intl.message(
      'No service matches these filters.',
      name: 'noServicesForFilters',
      desc: '',
      args: [],
    );
  }

  /// `No services found.`
  String get noServicesFound {
    return Intl.message(
      'No services found.',
      name: 'noServicesFound',
      desc: '',
      args: [],
    );
  }

  /// `Manicure and pedicure`
  String get presetManicure {
    return Intl.message(
      'Manicure and pedicure',
      name: 'presetManicure',
      desc: '',
      args: [],
    );
  }

  /// `Hand polish`
  String get presetManicurePolishHands {
    return Intl.message(
      'Hand polish',
      name: 'presetManicurePolishHands',
      desc: '',
      args: [],
    );
  }

  /// `Foot polish`
  String get presetManicurePolishFeet {
    return Intl.message(
      'Foot polish',
      name: 'presetManicurePolishFeet',
      desc: '',
      args: [],
    );
  }

  /// `Hands and feet`
  String get presetManicureHandsAndFeet {
    return Intl.message(
      'Hands and feet',
      name: 'presetManicureHandsAndFeet',
      desc: '',
      args: [],
    );
  }

  /// `Gel extensions`
  String get presetManicureGelExtension {
    return Intl.message(
      'Gel extensions',
      name: 'presetManicureGelExtension',
      desc: '',
      args: [],
    );
  }

  /// `Gel refill`
  String get presetManicureGelRefill {
    return Intl.message(
      'Gel refill',
      name: 'presetManicureGelRefill',
      desc: '',
      args: [],
    );
  }

  /// `Nail strengthening`
  String get presetManicureStrengthening {
    return Intl.message(
      'Nail strengthening',
      name: 'presetManicureStrengthening',
      desc: '',
      args: [],
    );
  }

  /// `Foot spa`
  String get presetManicureFootSpa {
    return Intl.message(
      'Foot spa',
      name: 'presetManicureFootSpa',
      desc: '',
      args: [],
    );
  }

  /// `Extension removal`
  String get presetManicureExtensionRemoval {
    return Intl.message(
      'Extension removal',
      name: 'presetManicureExtensionRemoval',
      desc: '',
      args: [],
    );
  }

  /// `Hair and barbering`
  String get presetHair {
    return Intl.message(
      'Hair and barbering',
      name: 'presetHair',
      desc: '',
      args: [],
    );
  }

  /// `Men's haircut`
  String get presetHairMensCut {
    return Intl.message(
      'Men\'s haircut',
      name: 'presetHairMensCut',
      desc: '',
      args: [],
    );
  }

  /// `Women's haircut`
  String get presetHairWomensCut {
    return Intl.message(
      'Women\'s haircut',
      name: 'presetHairWomensCut',
      desc: '',
      args: [],
    );
  }

  /// `Beard trim`
  String get presetHairBeard {
    return Intl.message(
      'Beard trim',
      name: 'presetHairBeard',
      desc: '',
      args: [],
    );
  }

  /// `Haircut and beard`
  String get presetHairCutAndBeard {
    return Intl.message(
      'Haircut and beard',
      name: 'presetHairCutAndBeard',
      desc: '',
      args: [],
    );
  }

  /// `Blow-dry`
  String get presetHairBlowDry {
    return Intl.message(
      'Blow-dry',
      name: 'presetHairBlowDry',
      desc: '',
      args: [],
    );
  }

  /// `Colouring`
  String get presetHairColoring {
    return Intl.message(
      'Colouring',
      name: 'presetHairColoring',
      desc: '',
      args: [],
    );
  }

  /// `Highlights`
  String get presetHairHighlights {
    return Intl.message(
      'Highlights',
      name: 'presetHairHighlights',
      desc: '',
      args: [],
    );
  }

  /// `Deep conditioning`
  String get presetHairConditioning {
    return Intl.message(
      'Deep conditioning',
      name: 'presetHairConditioning',
      desc: '',
      args: [],
    );
  }

  /// `Esthetics and brows`
  String get presetEsthetics {
    return Intl.message(
      'Esthetics and brows',
      name: 'presetEsthetics',
      desc: '',
      args: [],
    );
  }

  /// `Brow shaping`
  String get presetEstheticsBrowDesign {
    return Intl.message(
      'Brow shaping',
      name: 'presetEstheticsBrowDesign',
      desc: '',
      args: [],
    );
  }

  /// `Brow shaping with henna`
  String get presetEstheticsBrowHenna {
    return Intl.message(
      'Brow shaping with henna',
      name: 'presetEstheticsBrowHenna',
      desc: '',
      args: [],
    );
  }

  /// `Facial cleansing`
  String get presetEstheticsFacialCleansing {
    return Intl.message(
      'Facial cleansing',
      name: 'presetEstheticsFacialCleansing',
      desc: '',
      args: [],
    );
  }

  /// `Upper lip wax`
  String get presetEstheticsUpperLipWax {
    return Intl.message(
      'Upper lip wax',
      name: 'presetEstheticsUpperLipWax',
      desc: '',
      args: [],
    );
  }

  /// `Underarm wax`
  String get presetEstheticsUnderarmWax {
    return Intl.message(
      'Underarm wax',
      name: 'presetEstheticsUnderarmWax',
      desc: '',
      args: [],
    );
  }

  /// `Full leg wax`
  String get presetEstheticsFullLegWax {
    return Intl.message(
      'Full leg wax',
      name: 'presetEstheticsFullLegWax',
      desc: '',
      args: [],
    );
  }

  /// `Lash extensions`
  String get presetEstheticsLashExtensions {
    return Intl.message(
      'Lash extensions',
      name: 'presetEstheticsLashExtensions',
      desc: '',
      args: [],
    );
  }

  /// `Peel`
  String get presetEstheticsPeeling {
    return Intl.message(
      'Peel',
      name: 'presetEstheticsPeeling',
      desc: '',
      args: [],
    );
  }

  /// `Makeup`
  String get presetMakeup {
    return Intl.message('Makeup', name: 'presetMakeup', desc: '', args: []);
  }

  /// `Event makeup`
  String get presetMakeupSocial {
    return Intl.message(
      'Event makeup',
      name: 'presetMakeupSocial',
      desc: '',
      args: [],
    );
  }

  /// `Bridesmaid makeup`
  String get presetMakeupBridesmaid {
    return Intl.message(
      'Bridesmaid makeup',
      name: 'presetMakeupBridesmaid',
      desc: '',
      args: [],
    );
  }

  /// `Graduation makeup`
  String get presetMakeupGraduation {
    return Intl.message(
      'Graduation makeup',
      name: 'presetMakeupGraduation',
      desc: '',
      args: [],
    );
  }

  /// `Bridal makeup`
  String get presetMakeupBride {
    return Intl.message(
      'Bridal makeup',
      name: 'presetMakeupBride',
      desc: '',
      args: [],
    );
  }

  /// `Self-makeup class`
  String get presetMakeupClass {
    return Intl.message(
      'Self-makeup class',
      name: 'presetMakeupClass',
      desc: '',
      args: [],
    );
  }

  /// `Massage and wellness`
  String get presetMassage {
    return Intl.message(
      'Massage and wellness',
      name: 'presetMassage',
      desc: '',
      args: [],
    );
  }

  /// `Relaxing massage, 60 min`
  String get presetMassageRelaxing {
    return Intl.message(
      'Relaxing massage, 60 min',
      name: 'presetMassageRelaxing',
      desc: '',
      args: [],
    );
  }

  /// `Lymphatic drainage`
  String get presetMassageLymphatic {
    return Intl.message(
      'Lymphatic drainage',
      name: 'presetMassageLymphatic',
      desc: '',
      args: [],
    );
  }

  /// `Contouring massage`
  String get presetMassageContouring {
    return Intl.message(
      'Contouring massage',
      name: 'presetMassageContouring',
      desc: '',
      args: [],
    );
  }

  /// `Hot stone massage`
  String get presetMassageHotStone {
    return Intl.message(
      'Hot stone massage',
      name: 'presetMassageHotStone',
      desc: '',
      args: [],
    );
  }

  /// `Pack of 10 sessions`
  String get presetMassagePackTen {
    return Intl.message(
      'Pack of 10 sessions',
      name: 'presetMassagePackTen',
      desc: '',
      args: [],
    );
  }

  /// `Personal training`
  String get presetPersonalTrainer {
    return Intl.message(
      'Personal training',
      name: 'presetPersonalTrainer',
      desc: '',
      args: [],
    );
  }

  /// `Single session`
  String get presetPersonalSingleSession {
    return Intl.message(
      'Single session',
      name: 'presetPersonalSingleSession',
      desc: '',
      args: [],
    );
  }

  /// `Pack of 8 sessions`
  String get presetPersonalPackEight {
    return Intl.message(
      'Pack of 8 sessions',
      name: 'presetPersonalPackEight',
      desc: '',
      args: [],
    );
  }

  /// `Monthly, 3× a week`
  String get presetPersonalMonthlyPlan {
    return Intl.message(
      'Monthly, 3× a week',
      name: 'presetPersonalMonthlyPlan',
      desc: '',
      args: [],
    );
  }

  /// `Fitness assessment`
  String get presetPersonalAssessment {
    return Intl.message(
      'Fitness assessment',
      name: 'presetPersonalAssessment',
      desc: '',
      args: [],
    );
  }

  /// `Online program`
  String get presetPersonalOnlineProgram {
    return Intl.message(
      'Online program',
      name: 'presetPersonalOnlineProgram',
      desc: '',
      args: [],
    );
  }

  /// `Cleaning and housekeeping`
  String get presetCleaning {
    return Intl.message(
      'Cleaning and housekeeping',
      name: 'presetCleaning',
      desc: '',
      args: [],
    );
  }

  /// `Full day`
  String get presetCleaningFullDay {
    return Intl.message(
      'Full day',
      name: 'presetCleaningFullDay',
      desc: '',
      args: [],
    );
  }

  /// `Half day`
  String get presetCleaningHalfDay {
    return Intl.message(
      'Half day',
      name: 'presetCleaningHalfDay',
      desc: '',
      args: [],
    );
  }

  /// `Deep clean`
  String get presetCleaningDeepClean {
    return Intl.message(
      'Deep clean',
      name: 'presetCleaningDeepClean',
      desc: '',
      args: [],
    );
  }

  /// `Ironing, per hour`
  String get presetCleaningIroning {
    return Intl.message(
      'Ironing, per hour',
      name: 'presetCleaningIroning',
      desc: '',
      args: [],
    );
  }

  /// `Post-construction clean`
  String get presetCleaningPostConstruction {
    return Intl.message(
      'Post-construction clean',
      name: 'presetCleaningPostConstruction',
      desc: '',
      args: [],
    );
  }

  /// `Assembly and repairs`
  String get presetHandyman {
    return Intl.message(
      'Assembly and repairs',
      name: 'presetHandyman',
      desc: '',
      args: [],
    );
  }

  /// `Wardrobe assembly`
  String get presetHandymanWardrobe {
    return Intl.message(
      'Wardrobe assembly',
      name: 'presetHandymanWardrobe',
      desc: '',
      args: [],
    );
  }

  /// `Bed assembly`
  String get presetHandymanBed {
    return Intl.message(
      'Bed assembly',
      name: 'presetHandymanBed',
      desc: '',
      args: [],
    );
  }

  /// `TV mounting`
  String get presetHandymanTvMount {
    return Intl.message(
      'TV mounting',
      name: 'presetHandymanTvMount',
      desc: '',
      args: [],
    );
  }

  /// `Shelf or bracket`
  String get presetHandymanShelf {
    return Intl.message(
      'Shelf or bracket',
      name: 'presetHandymanShelf',
      desc: '',
      args: [],
    );
  }

  /// `Call-out visit`
  String get presetHandymanCallout {
    return Intl.message(
      'Call-out visit',
      name: 'presetHandymanCallout',
      desc: '',
      args: [],
    );
  }

  /// `Design and creative`
  String get presetDesign {
    return Intl.message(
      'Design and creative',
      name: 'presetDesign',
      desc: '',
      args: [],
    );
  }

  /// `Logo`
  String get presetDesignLogo {
    return Intl.message('Logo', name: 'presetDesignLogo', desc: '', args: []);
  }

  /// `Social media post`
  String get presetDesignSocialPost {
    return Intl.message(
      'Social media post',
      name: 'presetDesignSocialPost',
      desc: '',
      args: [],
    );
  }

  /// `Hourly rate`
  String get presetDesignHourly {
    return Intl.message(
      'Hourly rate',
      name: 'presetDesignHourly',
      desc: '',
      args: [],
    );
  }

  /// `Brand identity`
  String get presetDesignBrandIdentity {
    return Intl.message(
      'Brand identity',
      name: 'presetDesignBrandIdentity',
      desc: '',
      args: [],
    );
  }

  /// `Landing page`
  String get presetDesignLandingPage {
    return Intl.message(
      'Landing page',
      name: 'presetDesignLandingPage',
      desc: '',
      args: [],
    );
  }

  /// `Another profession`
  String get presetOther {
    return Intl.message(
      'Another profession',
      name: 'presetOther',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get setupContinue {
    return Intl.message('Continue', name: 'setupContinue', desc: '', args: []);
  }

  /// `Leave the setup?`
  String get setupExitTitle {
    return Intl.message(
      'Leave the setup?',
      name: 'setupExitTitle',
      desc: '',
      args: [],
    );
  }

  /// `What you have answered is saved. You can pick it up from the home screen.`
  String get setupExitMessage {
    return Intl.message(
      'What you have answered is saved. You can pick it up from the home screen.',
      name: 'setupExitMessage',
      desc: '',
      args: [],
    );
  }

  /// `Before we start, tell me what you do.`
  String get setupProfessionTitle {
    return Intl.message(
      'Before we start, tell me what you do.',
      name: 'setupProfessionTitle',
      desc: '',
      args: [],
    );
  }

  /// `That way Kazi starts out with your services already set up.`
  String get setupProfessionSubtitle {
    return Intl.message(
      'That way Kazi starts out with your services already set up.',
      name: 'setupProfessionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `What do you do?`
  String get setupProfessionTypedTitle {
    return Intl.message(
      'What do you do?',
      name: 'setupProfessionTypedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Write it your way. If I know it, I will bring a ready-made list.`
  String get setupProfessionTypedSubtitle {
    return Intl.message(
      'Write it your way. If I know it, I will bring a ready-made list.',
      name: 'setupProfessionTypedSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Profession`
  String get setupProfessionField {
    return Intl.message(
      'Profession',
      name: 'setupProfessionField',
      desc: '',
      args: [],
    );
  }

  /// `Did not find it? Just keep writing.`
  String get setupProfessionNoMatch {
    return Intl.message(
      'Did not find it? Just keep writing.',
      name: 'setupProfessionNoMatch',
      desc: '',
      args: [],
    );
  }

  /// `I do not know that work yet.`
  String get setupUnknownProfessionTitle {
    return Intl.message(
      'I do not know that work yet.',
      name: 'setupUnknownProfessionTitle',
      desc: '',
      args: [],
    );
  }

  /// `No problem — Kazi learns it from you in a minute. First: how do you get paid?`
  String get setupUnknownProfessionSubtitle {
    return Intl.message(
      'No problem — Kazi learns it from you in a minute. First: how do you get paid?',
      name: 'setupUnknownProfessionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `I work for myself`
  String get setupSelfEmployed {
    return Intl.message(
      'I work for myself',
      name: 'setupSelfEmployed',
      desc: '',
      args: [],
    );
  }

  /// `I keep 100%`
  String get setupSelfEmployedDetail {
    return Intl.message(
      'I keep 100%',
      name: 'setupSelfEmployedDetail',
      desc: '',
      args: [],
    );
  }

  /// `I work for a salon or company`
  String get setupEmployed {
    return Intl.message(
      'I work for a salon or company',
      name: 'setupEmployed',
      desc: '',
      args: [],
    );
  }

  /// `I get a commission`
  String get setupEmployedDetail {
    return Intl.message(
      'I get a commission',
      name: 'setupEmployedDetail',
      desc: '',
      args: [],
    );
  }

  /// `Are these the services you offer?`
  String get setupCatalogTitle {
    return Intl.message(
      'Are these the services you offer?',
      name: 'setupCatalogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Untick anything you do not do, and tap the price to set your own.`
  String get setupCatalogSubtitle {
    return Intl.message(
      'Untick anything you do not do, and tap the price to set your own.',
      name: 'setupCatalogSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Which services do you offer?`
  String get setupCatalogTypedTitle {
    return Intl.message(
      'Which services do you offer?',
      name: 'setupCatalogTypedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Start with the most common one. You can add as many as you want later.`
  String get setupCatalogTypedSubtitle {
    return Intl.message(
      'Start with the most common one. You can add as many as you want later.',
      name: 'setupCatalogTypedSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Your prices`
  String get setupCatalogYourPrices {
    return Intl.message(
      'Your prices',
      name: 'setupCatalogYourPrices',
      desc: '',
      args: [],
    );
  }

  /// `Add another service`
  String get setupCatalogAddAnother {
    return Intl.message(
      'Add another service',
      name: 'setupCatalogAddAnother',
      desc: '',
      args: [],
    );
  }

  /// `Do not know the price? Leave it blank — Kazi asks when you register.`
  String get setupCatalogBlankPrice {
    return Intl.message(
      'Do not know the price? Leave it blank — Kazi asks when you register.',
      name: 'setupCatalogBlankPrice',
      desc: '',
      args: [],
    );
  }

  /// `Continue with {count}`
  String setupCatalogContinueWith(int count) {
    return Intl.message(
      'Continue with $count',
      name: 'setupCatalogContinueWith',
      desc: '',
      args: [count],
    );
  }

  /// `You already have a service with this name.`
  String get setupCatalogDuplicate {
    return Intl.message(
      'You already have a service with this name.',
      name: 'setupCatalogDuplicate',
      desc: '',
      args: [],
    );
  }

  /// `Service name`
  String get setupPriceSheetName {
    return Intl.message(
      'Service name',
      name: 'setupPriceSheetName',
      desc: '',
      args: [],
    );
  }

  /// `What you charge`
  String get setupPriceSheetValue {
    return Intl.message(
      'What you charge',
      name: 'setupPriceSheetValue',
      desc: '',
      args: [],
    );
  }

  /// `What you keep`
  String get setupPriceSheetKeep {
    return Intl.message(
      'What you keep',
      name: 'setupPriceSheetKeep',
      desc: '',
      args: [],
    );
  }

  /// `How much of each service do you keep?`
  String get setupCommissionTitle {
    return Intl.message(
      'How much of each service do you keep?',
      name: 'setupCommissionTitle',
      desc: '',
      args: [],
    );
  }

  /// `It is the salon's commission. If you work for yourself, choose 100%.`
  String get setupCommissionSubtitle {
    return Intl.message(
      'It is the salon\'s commission. If you work for yourself, choose 100%.',
      name: 'setupCommissionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap a service to change just that one.`
  String get setupCommissionPerItem {
    return Intl.message(
      'Tap a service to change just that one.',
      name: 'setupCommissionPerItem',
      desc: '',
      args: [],
    );
  }

  /// `When do you get paid?`
  String get setupCycleTitle {
    return Intl.message(
      'When do you get paid?',
      name: 'setupCycleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Kazi adds up your earnings within that period.`
  String get setupCycleSubtitle {
    return Intl.message(
      'Kazi adds up your earnings within that period.',
      name: 'setupCycleSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `day {day}`
  String setupCycleMonthlyDetail(int day) {
    return Intl.message(
      'day $day',
      name: 'setupCycleMonthlyDetail',
      desc: '',
      args: [day],
    );
  }

  /// `Let's record a service you have already done.`
  String get setupFirstServiceTitle {
    return Intl.message(
      'Let\'s record a service you have already done.',
      name: 'setupFirstServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `It can be today's. It takes 10 seconds.`
  String get setupFirstServiceSubtitle {
    return Intl.message(
      'It can be today\'s. It takes 10 seconds.',
      name: 'setupFirstServiceSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `When was it?`
  String get setupFirstServiceWhen {
    return Intl.message(
      'When was it?',
      name: 'setupFirstServiceWhen',
      desc: '',
      args: [],
    );
  }

  /// `Another day`
  String get setupFirstServiceOtherDay {
    return Intl.message(
      'Another day',
      name: 'setupFirstServiceOtherDay',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get setupFirstServiceRegister {
    return Intl.message(
      'Register',
      name: 'setupFirstServiceRegister',
      desc: '',
      args: [],
    );
  }

  /// `I have not worked yet — I will do this later`
  String get setupFirstServiceSkip {
    return Intl.message(
      'I have not worked yet — I will do this later',
      name: 'setupFirstServiceSkip',
      desc: '',
      args: [],
    );
  }

  /// `This service goes into the previous cycle.`
  String get setupFirstServicePastCycle {
    return Intl.message(
      'This service goes into the previous cycle.',
      name: 'setupFirstServicePastCycle',
      desc: '',
      args: [],
    );
  }

  /// `Service registered`
  String get setupResultLabel {
    return Intl.message(
      'Service registered',
      name: 'setupResultLabel',
      desc: '',
      args: [],
    );
  }

  /// `is yours`
  String get setupResultYours {
    return Intl.message(
      'is yours',
      name: 'setupResultYours',
      desc: '',
      args: [],
    );
  }

  /// `of {total} · {percent} commission`
  String setupResultBreakdown(String total, String percent) {
    return Intl.message(
      'of $total · $percent commission',
      name: 'setupResultBreakdown',
      desc: '',
      args: [total, percent],
    );
  }

  /// `See my Kazi`
  String get setupResultCta {
    return Intl.message(
      'See my Kazi',
      name: 'setupResultCta',
      desc: '',
      args: [],
    );
  }

  /// `Your Kazi is ready.`
  String get setupResultReadyTitle {
    return Intl.message(
      'Your Kazi is ready.',
      name: 'setupResultReadyTitle',
      desc: '',
      args: [],
    );
  }

  /// `As soon as you finish a job, tap the K in the middle of the bar.`
  String get setupResultReadySubtitle {
    return Intl.message(
      'As soon as you finish a job, tap the K in the middle of the bar.',
      name: 'setupResultReadySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Make Kazi yours`
  String get checklistTitle {
    return Intl.message(
      'Make Kazi yours',
      name: 'checklistTitle',
      desc: '',
      args: [],
    );
  }

  /// `{done}/{total}`
  String checklistProgress(int done, int total) {
    return Intl.message(
      '$done/$total',
      name: 'checklistProgress',
      desc: '',
      args: [done, total],
    );
  }

  /// `Build your catalog`
  String get checklistBuildCatalog {
    return Intl.message(
      'Build your catalog',
      name: 'checklistBuildCatalog',
      desc: '',
      args: [],
    );
  }

  /// `Register your first service`
  String get checklistFirstService {
    return Intl.message(
      'Register your first service',
      name: 'checklistFirstService',
      desc: '',
      args: [],
    );
  }

  /// `Register 3 services in a row`
  String get checklistThreeServices {
    return Intl.message(
      'Register 3 services in a row',
      name: 'checklistThreeServices',
      desc: '',
      args: [],
    );
  }

  /// `Mark a service as received`
  String get checklistMarkReceived {
    return Intl.message(
      'Mark a service as received',
      name: 'checklistMarkReceived',
      desc: '',
      args: [],
    );
  }

  /// `See your monthly summary`
  String get checklistSeeSummary {
    return Intl.message(
      'See your monthly summary',
      name: 'checklistSeeSummary',
      desc: '',
      args: [],
    );
  }

  /// `Done. From here on, it is just registering.`
  String get checklistFinished {
    return Intl.message(
      'Done. From here on, it is just registering.',
      name: 'checklistFinished',
      desc: '',
      args: [],
    );
  }

  /// `Got it`
  String get hintGotIt {
    return Intl.message('Got it', name: 'hintGotIt', desc: '', args: []);
  }

  /// `This is where you register`
  String get hintFabTitle {
    return Intl.message(
      'This is where you register',
      name: 'hintFabTitle',
      desc: '',
      args: [],
    );
  }

  /// `Every time you finish a job, tap the K in the middle of the bar. Choose the service, confirm, and it is registered.`
  String get hintFabBody {
    return Intl.message(
      'Every time you finish a job, tap the K in the middle of the bar. Choose the service, confirm, and it is registered.',
      name: 'hintFabBody',
      desc: '',
      args: [],
    );
  }

  /// `Mark it when the money lands`
  String get hintReceivedTitle {
    return Intl.message(
      'Mark it when the money lands',
      name: 'hintReceivedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Marking a service as received closes the loop between what you earned and what you were paid.`
  String get hintReceivedBody {
    return Intl.message(
      'Marking a service as received closes the loop between what you earned and what you were paid.',
      name: 'hintReceivedBody',
      desc: '',
      args: [],
    );
  }

  /// `Narrow the list`
  String get hintFiltersTitle {
    return Intl.message(
      'Narrow the list',
      name: 'hintFiltersTitle',
      desc: '',
      args: [],
    );
  }

  /// `With some history behind you, the filters find a client, a period or a service.`
  String get hintFiltersBody {
    return Intl.message(
      'With some history behind you, the filters find a client, a period or a service.',
      name: 'hintFiltersBody',
      desc: '',
      args: [],
    );
  }

  /// `Your month, in one place`
  String get hintSummaryTitle {
    return Intl.message(
      'Your month, in one place',
      name: 'hintSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `The summary shows what you generated, what is yours and what has already been paid.`
  String get hintSummaryBody {
    return Intl.message(
      'The summary shows what you generated, what is yours and what has already been paid.',
      name: 'hintSummaryBody',
      desc: '',
      args: [],
    );
  }

  /// `One question, then back to your work`
  String get cycleConfirmTitle {
    return Intl.message(
      'One question, then back to your work',
      name: 'cycleConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Kazi now groups your earnings by the period you get paid in. We are adding up by month, from the 1st to the last day. Is that right?`
  String get cycleConfirmBody {
    return Intl.message(
      'Kazi now groups your earnings by the period you get paid in. We are adding up by month, from the 1st to the last day. Is that right?',
      name: 'cycleConfirmBody',
      desc: '',
      args: [],
    );
  }

  /// `That is right`
  String get cycleConfirmYes {
    return Intl.message(
      'That is right',
      name: 'cycleConfirmYes',
      desc: '',
      args: [],
    );
  }

  /// `I get paid differently`
  String get cycleConfirmNo {
    return Intl.message(
      'I get paid differently',
      name: 'cycleConfirmNo',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{1 service in your catalog has no commission} other{{count} services in your catalog have no commission}}`
  String commissionGapsTitle(int count) {
    return Intl.plural(
      count,
      one: '1 service in your catalog has no commission',
      other: '$count services in your catalog have no commission',
      name: 'commissionGapsTitle',
      desc: '',
      args: [count],
    );
  }

  /// `Without it they count toward the total generated, but not toward what you receive.`
  String get commissionGapsBody {
    return Intl.message(
      'Without it they count toward the total generated, but not toward what you receive.',
      name: 'commissionGapsBody',
      desc: '',
      args: [],
    );
  }

  /// `Set now · 30 sec`
  String get commissionGapsCta {
    return Intl.message(
      'Set now · 30 sec',
      name: 'commissionGapsCta',
      desc: '',
      args: [],
    );
  }

  /// `What changed`
  String get whatsNewTitle {
    return Intl.message(
      'What changed',
      name: 'whatsNewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Version {version}`
  String whatsNewVersion(Object version) {
    return Intl.message(
      'Version $version',
      name: 'whatsNewVersion',
      desc: '',
      args: [version],
    );
  }

  /// `Three things, written by us — not discovered in the middle of a job.`
  String get whatsNewSubtitle {
    return Intl.message(
      'Three things, written by us — not discovered in the middle of a job.',
      name: 'whatsNewSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `How to use Kazi`
  String get howToUseKazi {
    return Intl.message(
      'How to use Kazi',
      name: 'howToUseKazi',
      desc: '',
      args: [],
    );
  }

  /// `Start here`
  String get howToUseStartHere {
    return Intl.message(
      'Start here',
      name: 'howToUseStartHere',
      desc: '',
      args: [],
    );
  }

  /// `Register a service`
  String get howToUseStartTitle {
    return Intl.message(
      'Register a service',
      name: 'howToUseStartTitle',
      desc: '',
      args: [],
    );
  }

  /// `The yellow button in the middle of the bar opens the screen to register a service.`
  String get howToUseStartBody {
    return Intl.message(
      'The yellow button in the middle of the bar opens the screen to register a service.',
      name: 'howToUseStartBody',
      desc: '',
      args: [],
    );
  }

  /// `Close the whole period at once`
  String get howToUseCloseCycleTitle {
    return Intl.message(
      'Close the whole period at once',
      name: 'howToUseCloseCycleTitle',
      desc: '',
      args: [],
    );
  }

  /// `On the Services header, mark everything still pending as received in one tap.`
  String get howToUseCloseCycleBody {
    return Intl.message(
      'On the Services header, mark everything still pending as received in one tap.',
      name: 'howToUseCloseCycleBody',
      desc: '',
      args: [],
    );
  }

  /// `See what each client is worth`
  String get howToUseClientEarningsTitle {
    return Intl.message(
      'See what each client is worth',
      name: 'howToUseClientEarningsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Open a client and tap "See in the summary" to know what they generated and what you were paid.`
  String get howToUseClientEarningsBody {
    return Intl.message(
      'Open a client and tap "See in the summary" to know what they generated and what you were paid.',
      name: 'howToUseClientEarningsBody',
      desc: '',
      args: [],
    );
  }

  /// `Your clients show up here as you register services. You can also add one now.`
  String get clientsEmptyExplained {
    return Intl.message(
      'Your clients show up here as you register services. You can also add one now.',
      name: 'clientsEmptyExplained',
      desc: '',
      args: [],
    );
  }

  /// `Archive`
  String get archive {
    return Intl.message('Archive', name: 'archive', desc: '', args: []);
  }

  /// `Restore`
  String get restore {
    return Intl.message('Restore', name: 'restore', desc: '', args: []);
  }

  /// `Archived`
  String get archived {
    return Intl.message('Archived', name: 'archived', desc: '', args: []);
  }

  /// `Archived`
  String get archivedSectionLabel {
    return Intl.message(
      'Archived',
      name: 'archivedSectionLabel',
      desc: '',
      args: [],
    );
  }

  /// `View archived · {count}`
  String viewArchived(int count) {
    return Intl.message(
      'View archived · $count',
      name: 'viewArchived',
      desc: '',
      args: [count],
    );
  }

  /// `Archived on {date}`
  String archivedOn(String date) {
    return Intl.message(
      'Archived on $date',
      name: 'archivedOn',
      desc: '',
      args: [date],
    );
  }

  /// `{name} archived.`
  String archivedSnackbar(String name) {
    return Intl.message(
      '$name archived.',
      name: 'archivedSnackbar',
      desc: '',
      args: [name],
    );
  }

  /// `{name} restored.`
  String restoredSnackbar(String name) {
    return Intl.message(
      '$name restored.',
      name: 'restoredSnackbar',
      desc: '',
      args: [name],
    );
  }

  /// `It appears in no service, so nothing in your history changes. This can't be undone.`
  String get deleteNoServicesImpact {
    return Intl.message(
      'It appears in no service, so nothing in your history changes. This can\'t be undone.',
      name: 'deleteNoServicesImpact',
      desc: '',
      args: [],
    );
  }

  /// `The record leaves your history and your totals. This can't be undone.`
  String get deleteServiceImpact {
    return Intl.message(
      'The record leaves your history and your totals. This can\'t be undone.',
      name: 'deleteServiceImpact',
      desc: '',
      args: [],
    );
  }

  /// `Delete {name} for good?`
  String deleteForeverTitle(String name) {
    return Intl.message(
      'Delete $name for good?',
      name: 'deleteForeverTitle',
      desc: '',
      args: [name],
    );
  }

  /// `Delete permanently`
  String get deletePermanently {
    return Intl.message(
      'Delete permanently',
      name: 'deletePermanently',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Can't delete: 1 service uses this record.} other{Can't delete: {count} services use this record.}}`
  String cantDeleteLinkedServices(int count) {
    return Intl.plural(
      count,
      one: 'Can\'t delete: 1 service uses this record.',
      other: 'Can\'t delete: $count services use this record.',
      name: 'cantDeleteLinkedServices',
      desc: '',
      args: [count],
    );
  }

  /// `"{name}" is already in your catalog, archived. Restore it?`
  String catalogItemArchivedRestorePrompt(String name) {
    return Intl.message(
      '"$name" is already in your catalog, archived. Restore it?',
      name: 'catalogItemArchivedRestorePrompt',
      desc: '',
      args: [name],
    );
  }

  /// `Archived clients`
  String get archivedClients {
    return Intl.message(
      'Archived clients',
      name: 'archivedClients',
      desc: '',
      args: [],
    );
  }

  /// `Archived catalog`
  String get archivedCatalogItems {
    return Intl.message(
      'Archived catalog',
      name: 'archivedCatalogItems',
      desc: '',
      args: [],
    );
  }

  /// `Error archiving the catalog item.`
  String get errorToArchiveCatalogItem {
    return Intl.message(
      'Error archiving the catalog item.',
      name: 'errorToArchiveCatalogItem',
      desc: '',
      args: [],
    );
  }

  /// `Error restoring the catalog item.`
  String get errorToRestoreCatalogItem {
    return Intl.message(
      'Error restoring the catalog item.',
      name: 'errorToRestoreCatalogItem',
      desc: '',
      args: [],
    );
  }

  /// `Error archiving the client.`
  String get errorToArchiveClient {
    return Intl.message(
      'Error archiving the client.',
      name: 'errorToArchiveClient',
      desc: '',
      args: [],
    );
  }

  /// `Error restoring the client.`
  String get errorToRestoreClient {
    return Intl.message(
      'Error restoring the client.',
      name: 'errorToRestoreClient',
      desc: '',
      args: [],
    );
  }

  /// `You already have a client under this document: {name}.`
  String clientSameDocument(String name) {
    return Intl.message(
      'You already have a client under this document: $name.',
      name: 'clientSameDocument',
      desc: '',
      args: [name],
    );
  }

  /// `{name} is on file under this document, archived. Restore them instead of creating another.`
  String clientSameDocumentArchived(String name) {
    return Intl.message(
      '$name is on file under this document, archived. Restore them instead of creating another.',
      name: 'clientSameDocumentArchived',
      desc: '',
      args: [name],
    );
  }

  /// `Attention`
  String get attention {
    return Intl.message('Attention', name: 'attention', desc: '', args: []);
  }

  /// `{count, plural, one{The service already performed stays in your history. Only the contact details are erased. This can't be undone.} other{The {count} services already performed stay in your history. Only the contact details are erased. This can't be undone.}}`
  String deleteClientImpact(int count) {
    return Intl.plural(
      count,
      one:
          'The service already performed stays in your history. Only the contact details are erased. This can\'t be undone.',
      other:
          'The $count services already performed stay in your history. Only the contact details are erased. This can\'t be undone.',
      name: 'deleteClientImpact',
      desc: '',
      args: [count],
    );
  }

  /// `Couldn't check whether this document is already on file. Try again.`
  String get errorToVerifyDocument {
    return Intl.message(
      'Couldn\'t check whether this document is already on file. Try again.',
      name: 'errorToVerifyDocument',
      desc: '',
      args: [],
    );
  }

  /// `There is already an item with this name. Use another name or edit the one that exists.`
  String get catalogItemDuplicateName {
    return Intl.message(
      'There is already an item with this name. Use another name or edit the one that exists.',
      name: 'catalogItemDuplicateName',
      desc: '',
      args: [],
    );
  }

  /// `An archived item does not show up when you register a service, but it keeps naming the services it was already used in.`
  String get archivedCatalogNote {
    return Intl.message(
      'An archived item does not show up when you register a service, but it keeps naming the services it was already used in.',
      name: 'archivedCatalogNote',
      desc: '',
      args: [],
    );
  }

  /// `An archived client disappears from searches and from the form, but stays in the history of the services already registered.`
  String get archivedClientsNote {
    return Intl.message(
      'An archived client disappears from searches and from the form, but stays in the history of the services already registered.',
      name: 'archivedClientsNote',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{used in 1 service} other{used in {count} services}}`
  String usedInServices(int count) {
    return Intl.plural(
      count,
      one: 'used in 1 service',
      other: 'used in $count services',
      name: 'usedInServices',
      desc: '',
      args: [count],
    );
  }

  /// `free`
  String get freeToDelete {
    return Intl.message('free', name: 'freeToDelete', desc: '', args: []);
  }

  /// `Clear`
  String get clear {
    return Intl.message('Clear', name: 'clear', desc: '', args: []);
  }

  /// `No catalog item by that name.`
  String get nothingFoundInCatalog {
    return Intl.message(
      'No catalog item by that name.',
      name: 'nothingFoundInCatalog',
      desc: '',
      args: [],
    );
  }

  /// `No services`
  String get noServices {
    return Intl.message('No services', name: 'noServices', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<KaziLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<KaziLocalizations> load(Locale locale) =>
      KaziLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
