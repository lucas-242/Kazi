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

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
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

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
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

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
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

  /// `Action done successfully`
  String get success {
    return Intl.message(
      'Action done successfully',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to delete`
  String get wouldYouLikeDelete {
    return Intl.message(
      'Would you like to delete',
      name: 'wouldYouLikeDelete',
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

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
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

  /// `Name is invalid`
  String get invalidName {
    return Intl.message(
      'Name is invalid',
      name: 'invalidName',
      desc: '',
      args: [],
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

  /// `You can not create an account with this method. Please try another account or contact support for help`
  String get cantCreateAccountWithMethod {
    return Intl.message(
      'You can not create an account with this method. Please try another account or contact support for help',
      name: 'cantCreateAccountWithMethod',
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
