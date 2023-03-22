// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(property) => "${property} already exists";

  static String m1(person) => "Hi, ${person}!";

  static String m2(property) => "${property} is being used";

  static String m3(property) => "${property} is invalid";

  static String m4(property) => "${property} is required";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "addNewService":
            MessageLookupByLibrary.simpleMessage("Add new service"),
        "addNewServiceType":
            MessageLookupByLibrary.simpleMessage("Add new service type"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "alreadyExists": m0,
        "appSubtitle":
            MessageLookupByLibrary.simpleMessage("Organize your services"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cantDeleteServiceType": MessageLookupByLibrary.simpleMessage(
            "The service type can\'t be deleted because it is being used"),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "credentialIsInvalid":
            MessageLookupByLibrary.simpleMessage("The credential is invalid"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "date": MessageLookupByLibrary.simpleMessage("Date"),
        "defaultValue": MessageLookupByLibrary.simpleMessage("Default Value"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "discountPercentage":
            MessageLookupByLibrary.simpleMessage("Discount percentage"),
        "discounts": MessageLookupByLibrary.simpleMessage("Discounts"),
        "emailIsInvalid": MessageLookupByLibrary.simpleMessage(
            "Email is invalid or badly formatted"),
        "emailWasNotFound": MessageLookupByLibrary.simpleMessage(
            "Email was not found, please create an account"),
        "errorToAddService":
            MessageLookupByLibrary.simpleMessage("Error to add service"),
        "errorToAddServiceType":
            MessageLookupByLibrary.simpleMessage("Error to add service type"),
        "errorToCountServices":
            MessageLookupByLibrary.simpleMessage("Error to count services"),
        "errorToDeleteService":
            MessageLookupByLibrary.simpleMessage("Error to delete service"),
        "errorToDeleteServiceType": MessageLookupByLibrary.simpleMessage(
            "Error to delete service type"),
        "errorToGetServiceTypes":
            MessageLookupByLibrary.simpleMessage("Error to get service types"),
        "errorToGetServices":
            MessageLookupByLibrary.simpleMessage("Error to get service"),
        "errorToUpdateService":
            MessageLookupByLibrary.simpleMessage("Error to update service"),
        "errorToUpdateServiceType": MessageLookupByLibrary.simpleMessage(
            "Error to update service type"),
        "fortnight": MessageLookupByLibrary.simpleMessage("Fortnight"),
        "googleSignIn":
            MessageLookupByLibrary.simpleMessage("Sign in with Google"),
        "hi": m1,
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "inUse": m2,
        "incorrectEmailOrPassword":
            MessageLookupByLibrary.simpleMessage("Incorrect email or password"),
        "invalidProperty": m3,
        "lightMode": MessageLookupByLibrary.simpleMessage("Light Mode"),
        "linkHasBeenUsed": MessageLookupByLibrary.simpleMessage(
            "The link has already been used"),
        "linkHasExpired":
            MessageLookupByLibrary.simpleMessage("The link has expired"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
            "Do you really want to logout?"),
        "methodNotAllowed": MessageLookupByLibrary.simpleMessage(
            "Method not allowed. Please try another account or contact support for help"),
        "month": MessageLookupByLibrary.simpleMessage("Month"),
        "myBalance": MessageLookupByLibrary.simpleMessage("My balance"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "noServiceTypes": MessageLookupByLibrary.simpleMessage(
            "No services types registered"),
        "noServicesInPeriod": MessageLookupByLibrary.simpleMessage(
            "No services in the selected period."),
        "noServicesOnDay":
            MessageLookupByLibrary.simpleMessage("No services on"),
        "orderBy": MessageLookupByLibrary.simpleMessage("Order by"),
        "orderDateAsc": MessageLookupByLibrary.simpleMessage(
            "Date: Least current to most current"),
        "orderDateDesc": MessageLookupByLibrary.simpleMessage(
            "Date: Most current to least current"),
        "orderTypeAsc":
            MessageLookupByLibrary.simpleMessage("Type: From A to Z"),
        "orderTypeDesc":
            MessageLookupByLibrary.simpleMessage("Type: From Z to A"),
        "orderValueAsc":
            MessageLookupByLibrary.simpleMessage("Value: Lowest to highest"),
        "orderValueDesc":
            MessageLookupByLibrary.simpleMessage("Value: Highest to lowest"),
        "passwordIsWeak": MessageLookupByLibrary.simpleMessage(
            "Password is too weak. Please, try a different one"),
        "quantity": MessageLookupByLibrary.simpleMessage("Quantity"),
        "requiredProperty": m4,
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "selectServiceType":
            MessageLookupByLibrary.simpleMessage("Select the service type"),
        "service": MessageLookupByLibrary.simpleMessage("service"),
        "serviceType": MessageLookupByLibrary.simpleMessage("Service type"),
        "serviceTypes": MessageLookupByLibrary.simpleMessage("Service types"),
        "services": MessageLookupByLibrary.simpleMessage("services"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signUpSuccess": MessageLookupByLibrary.simpleMessage(
            "Account created successfully"),
        "success":
            MessageLookupByLibrary.simpleMessage("Action done successfully"),
        "thereIsAnotherAccount": MessageLookupByLibrary.simpleMessage(
            "There is already an account with this credential"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "total": MessageLookupByLibrary.simpleMessage("Total value"),
        "totalReceived": MessageLookupByLibrary.simpleMessage("Total received"),
        "unknowError": MessageLookupByLibrary.simpleMessage(
            "An unknown exception occurred"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "userHasBeenDisabled": MessageLookupByLibrary.simpleMessage(
            "This user has been disabled. Please contact support for help"),
        "verificationCodeIsInvalid": MessageLookupByLibrary.simpleMessage(
            "The verification code entered is invalid"),
        "verificationIdIsInvalid": MessageLookupByLibrary.simpleMessage(
            "The verification ID entered is invalid"),
        "week": MessageLookupByLibrary.simpleMessage("Week"),
        "wouldYouLikeDelete":
            MessageLookupByLibrary.simpleMessage("Would you like to delete")
      };
}
