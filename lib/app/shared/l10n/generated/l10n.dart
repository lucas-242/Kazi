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

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
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

  /// `Calculator`
  String get calculator {
    return Intl.message(
      'Calculator',
      name: 'calculator',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Clipper cut`
  String get clipperCut {
    return Intl.message(
      'Clipper cut',
      name: 'clipperCut',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
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

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
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

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Discounts`
  String get discounts {
    return Intl.message(
      'Discounts',
      name: 'discounts',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
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

  /// `Edit Type`
  String get editServiceType {
    return Intl.message(
      'Edit Type',
      name: 'editServiceType',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Field`
  String get field {
    return Intl.message(
      'Field',
      name: 'field',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
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

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Fortnight`
  String get fortnight {
    return Intl.message(
      'Fortnight',
      name: 'fortnight',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Hi, $person!',
      name: 'hi',
      desc: '',
      args: [person],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Last Month`
  String get lastMonth {
    return Intl.message(
      'Last Month',
      name: 'lastMonth',
      desc: '',
      args: [],
    );
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

  /// `Light Mode`
  String get lightMode {
    return Intl.message(
      'Light Mode',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
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

  /// `My balance`
  String get myBalance {
    return Intl.message(
      'My balance',
      name: 'myBalance',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `New service`
  String get newService {
    return Intl.message(
      'New service',
      name: 'newService',
      desc: '',
      args: [],
    );
  }

  /// `New Service Type`
  String get newServiceType {
    return Intl.message(
      'New Service Type',
      name: 'newServiceType',
      desc: '',
      args: [],
    );
  }

  /// `New Type`
  String get newType {
    return Intl.message(
      'New Type',
      name: 'newType',
      desc: '',
      args: [],
    );
  }

  /// `No results`
  String get noResults {
    return Intl.message(
      'No results',
      name: 'noResults',
      desc: '',
      args: [],
    );
  }

  /// `It seems you don't have any service registered yet, click on the button above to register a new one.\n\nRemember, by default this screen shows the services you made this month. Try changing the filters above to see different dates.`
  String get noServices {
    return Intl.message(
      'It seems you don\'t have any service registered yet, click on the button above to register a new one.\n\nRemember, by default this screen shows the services you made this month. Try changing the filters above to see different dates.',
      name: 'noServices',
      desc: '',
      args: [],
    );
  }

  /// `It seems you don't have any service registered today yet, click on the button above to register a new one.\n\nRemember, this screen shows only the services that you made today. Go to the services page to see other dates.`
  String get noServicesHome {
    return Intl.message(
      'It seems you don\'t have any service registered today yet, click on the button above to register a new one.\n\nRemember, this screen shows only the services that you made today. Go to the services page to see other dates.',
      name: 'noServicesHome',
      desc: '',
      args: [],
    );
  }

  /// `It seems you don't have any service type registered yet, click on the button above to register a new one.`
  String get noServiceTypes {
    return Intl.message(
      'It seems you don\'t have any service type registered yet, click on the button above to register a new one.',
      name: 'noServiceTypes',
      desc: '',
      args: [],
    );
  }

  /// `This smart tool is designed to help you better manage your services.`
  String get onboardingSubtitle {
    return Intl.message(
      'This smart tool is designed to help you better manage your services.',
      name: 'onboardingSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Calculate the\nearnings from `
  String get onboardingTitle1 {
    return Intl.message(
      'Calculate the\nearnings from ',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `your\nservices`
  String get onboardingTitle2 {
    return Intl.message(
      'your\nservices',
      name: 'onboardingTitle2',
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

  /// `Order by`
  String get orderBy {
    return Intl.message(
      'Order by',
      name: 'orderBy',
      desc: '',
      args: [],
    );
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

  /// `Period`
  String get period {
    return Intl.message(
      'Period',
      name: 'period',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
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

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Save Type`
  String get saveType {
    return Intl.message(
      'Save Type',
      name: 'saveType',
      desc: '',
      args: [],
    );
  }

  /// `Save Service`
  String get saveService {
    return Intl.message(
      'Save Service',
      name: 'saveService',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Select the service type`
  String get selectServiceType {
    return Intl.message(
      'Select the service type',
      name: 'selectServiceType',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get service {
    return Intl.message(
      'Service',
      name: 'service',
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
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Service Type`
  String get serviceType {
    return Intl.message(
      'Service Type',
      name: 'serviceType',
      desc: '',
      args: [],
    );
  }

  /// `Service Types`
  String get serviceTypes {
    return Intl.message(
      'Service Types',
      name: 'serviceTypes',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Total value`
  String get total {
    return Intl.message(
      'Total value',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Total received`
  String get totalReceived {
    return Intl.message(
      'Total received',
      name: 'totalReceived',
      desc: '',
      args: [],
    );
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

  /// `Here you can register the types of services you perform and log out of your account.`
  String get tourAppBarDescription {
    return Intl.message(
      'Here you can register the types of services you perform and log out of your account.',
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

  /// `Here you will find some actions available, including the one to register a new type of service. The service type allows you to easily identify a service provided.`
  String get tourProfileDescription {
    return Intl.message(
      'Here you will find some actions available, including the one to register a new type of service. The service type allows you to easily identify a service provided.',
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

  /// `To register a new service provided, first select one of the types of service that you previously registered and the values will be filled in automatically according to the data of that type of service. If you wish, you can change the values for that specific service.`
  String get tourServicesForm1Description {
    return Intl.message(
      'To register a new service provided, first select one of the types of service that you previously registered and the values will be filled in automatically according to the data of that type of service. If you wish, you can change the values for that specific service.',
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

  /// `Service Type`
  String get tourServiceTypesTitle {
    return Intl.message(
      'Service Type',
      name: 'tourServiceTypesTitle',
      desc: '',
      args: [],
    );
  }

  /// `This information will help you to easily register the services you will perform. You can give a name, such as "Lashes - Brazilian Volume", fill in the default value, and if applicable, the percentage that is normally deducted from this service.`
  String get tourServiceTypesDescription {
    return Intl.message(
      'This information will help you to easily register the services you will perform. You can give a name, such as "Lashes - Brazilian Volume", fill in the default value, and if applicable, the percentage that is normally deducted from this service.',
      name: 'tourServiceTypesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
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

  /// `Please, inform a number equal or greater than 0`
  String get numberLesserThanZero {
    return Intl.message(
      'Please, inform a number equal or greater than 0',
      name: 'numberLesserThanZero',
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

  /// `The service type can't be deleted because it is being used`
  String get cantDeleteServiceType {
    return Intl.message(
      'The service type can\'t be deleted because it is being used',
      name: 'cantDeleteServiceType',
      desc: '',
      args: [],
    );
  }

  /// `An unknown exception occurred`
  String get unknowError {
    return Intl.message(
      'An unknown exception occurred',
      name: 'unknowError',
      desc: '',
      args: [],
    );
  }

  /// `The link has expired`
  String get linkHasExpired {
    return Intl.message(
      'The link has expired',
      name: 'linkHasExpired',
      desc: '',
      args: [],
    );
  }

  /// `The link has already been used`
  String get linkHasBeenUsed {
    return Intl.message(
      'The link has already been used',
      name: 'linkHasBeenUsed',
      desc: '',
      args: [],
    );
  }

  /// `Password is too weak. Please, try a different one`
  String get passwordIsWeak {
    return Intl.message(
      'Password is too weak. Please, try a different one',
      name: 'passwordIsWeak',
      desc: '',
      args: [],
    );
  }

  /// `Email is invalid or badly formatted`
  String get emailIsInvalid {
    return Intl.message(
      'Email is invalid or badly formatted',
      name: 'emailIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `This user has been disabled. Please contact support for help`
  String get userHasBeenDisabled {
    return Intl.message(
      'This user has been disabled. Please contact support for help',
      name: 'userHasBeenDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Email was not found, please create an account`
  String get emailWasNotFound {
    return Intl.message(
      'Email was not found, please create an account',
      name: 'emailWasNotFound',
      desc: '',
      args: [],
    );
  }

  /// `There is already an account with this credential`
  String get thereIsAnotherAccount {
    return Intl.message(
      'There is already an account with this credential',
      name: 'thereIsAnotherAccount',
      desc: '',
      args: [],
    );
  }

  /// `The credential is invalid`
  String get credentialIsInvalid {
    return Intl.message(
      'The credential is invalid',
      name: 'credentialIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The verification code entered is invalid`
  String get verificationCodeIsInvalid {
    return Intl.message(
      'The verification code entered is invalid',
      name: 'verificationCodeIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The verification ID entered is invalid`
  String get verificationIdIsInvalid {
    return Intl.message(
      'The verification ID entered is invalid',
      name: 'verificationIdIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Method not allowed. Please try another account or contact support for help`
  String get methodNotAllowed {
    return Intl.message(
      'Method not allowed. Please try another account or contact support for help',
      name: 'methodNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password`
  String get incorrectEmailOrPassword {
    return Intl.message(
      'Incorrect email or password',
      name: 'incorrectEmailOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `Error to add service type`
  String get errorToAddServiceType {
    return Intl.message(
      'Error to add service type',
      name: 'errorToAddServiceType',
      desc: '',
      args: [],
    );
  }

  /// `Error to delete service type`
  String get errorToDeleteServiceType {
    return Intl.message(
      'Error to delete service type',
      name: 'errorToDeleteServiceType',
      desc: '',
      args: [],
    );
  }

  /// `Error to get service types`
  String get errorToGetServiceTypes {
    return Intl.message(
      'Error to get service types',
      name: 'errorToGetServiceTypes',
      desc: '',
      args: [],
    );
  }

  /// `Error to update service type`
  String get errorToUpdateServiceType {
    return Intl.message(
      'Error to update service type',
      name: 'errorToUpdateServiceType',
      desc: '',
      args: [],
    );
  }

  /// `Error to add service`
  String get errorToAddService {
    return Intl.message(
      'Error to add service',
      name: 'errorToAddService',
      desc: '',
      args: [],
    );
  }

  /// `Error to count services`
  String get errorToCountServices {
    return Intl.message(
      'Error to count services',
      name: 'errorToCountServices',
      desc: '',
      args: [],
    );
  }

  /// `Error to delete service`
  String get errorToDeleteService {
    return Intl.message(
      'Error to delete service',
      name: 'errorToDeleteService',
      desc: '',
      args: [],
    );
  }

  /// `Error to get service`
  String get errorToGetServices {
    return Intl.message(
      'Error to get service',
      name: 'errorToGetServices',
      desc: '',
      args: [],
    );
  }

  /// `Error to update service`
  String get errorToUpdateService {
    return Intl.message(
      'Error to update service',
      name: 'errorToUpdateService',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
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
