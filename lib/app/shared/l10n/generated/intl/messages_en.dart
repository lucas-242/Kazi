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

  static String m5(item) => "Would you like to delete ${item}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "alreadyExists": m0,
        "appSubtitle":
            MessageLookupByLibrary.simpleMessage("Organize your services"),
        "applyFilters": MessageLookupByLibrary.simpleMessage("Apply Filters"),
        "calculator": MessageLookupByLibrary.simpleMessage("Calculator"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cantDeleteServiceType": MessageLookupByLibrary.simpleMessage(
            "The service type can\'t be deleted because it is being used"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmAction": MessageLookupByLibrary.simpleMessage("Confirm Action"),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "credentialIsInvalid":
            MessageLookupByLibrary.simpleMessage("The credential is invalid"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "date": MessageLookupByLibrary.simpleMessage("Date"),
        "defaultValue": MessageLookupByLibrary.simpleMessage("Default Value"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "details": MessageLookupByLibrary.simpleMessage("Details"),
        "discount": MessageLookupByLibrary.simpleMessage("Discount"),
        "discountPercentage":
            MessageLookupByLibrary.simpleMessage("Discount percentage"),
        "discounts": MessageLookupByLibrary.simpleMessage("Discounts"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editService": MessageLookupByLibrary.simpleMessage("Edit Service"),
        "editServiceType":
            MessageLookupByLibrary.simpleMessage("Edit Service Type"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
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
        "filters": MessageLookupByLibrary.simpleMessage("Filters"),
        "fortnight": MessageLookupByLibrary.simpleMessage("Fortnight"),
        "googleSignIn":
            MessageLookupByLibrary.simpleMessage("Sign in with Google"),
        "hi": m1,
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "inUse": m2,
        "incorrectEmailOrPassword":
            MessageLookupByLibrary.simpleMessage("Incorrect email or password"),
        "invalidProperty": m3,
        "lastServices": MessageLookupByLibrary.simpleMessage("Last services"),
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
        "newService": MessageLookupByLibrary.simpleMessage("New service"),
        "newServiceType":
            MessageLookupByLibrary.simpleMessage("New Service Type"),
        "newType": MessageLookupByLibrary.simpleMessage("New Type"),
        "noResults": MessageLookupByLibrary.simpleMessage("No results"),
        "noServiceTypes": MessageLookupByLibrary.simpleMessage(
            "No services types registered"),
        "noServices": MessageLookupByLibrary.simpleMessage(
            "If you have not yet registered any services, click on the button above to register a new one."),
        "noServicesInPeriod": MessageLookupByLibrary.simpleMessage(
            "No services in the selected period."),
        "noServicesOnDay":
            MessageLookupByLibrary.simpleMessage("No services on"),
        "onboardingSubtitle": MessageLookupByLibrary.simpleMessage(
            "This smart tool is designed to help you better manage your services."),
        "onboardingTitle1": MessageLookupByLibrary.simpleMessage(
            "Calculate the\nearnings from "),
        "onboardingTitle2":
            MessageLookupByLibrary.simpleMessage("your\nservices"),
        "orderAlphabetical":
            MessageLookupByLibrary.simpleMessage("Alphabetical"),
        "orderBy": MessageLookupByLibrary.simpleMessage("Order by"),
        "orderDateAsc": MessageLookupByLibrary.simpleMessage(
            "Least current to most current"),
        "orderDateDesc": MessageLookupByLibrary.simpleMessage(
            "Most current to least current"),
        "orderValueAsc":
            MessageLookupByLibrary.simpleMessage("Lowest to highest"),
        "orderValueDesc":
            MessageLookupByLibrary.simpleMessage("Highest to lowest"),
        "passwordIsWeak": MessageLookupByLibrary.simpleMessage(
            "Password is too weak. Please, try a different one"),
        "period": MessageLookupByLibrary.simpleMessage("Period"),
        "phone": MessageLookupByLibrary.simpleMessage("Phone"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "quantity": MessageLookupByLibrary.simpleMessage("Quantity"),
        "removeFilters": MessageLookupByLibrary.simpleMessage("Remove filters"),
        "requiredProperty": m4,
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveService": MessageLookupByLibrary.simpleMessage("Save Service"),
        "saveType": MessageLookupByLibrary.simpleMessage("Save Type"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "selectServiceType":
            MessageLookupByLibrary.simpleMessage("Select the service type"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceDetails":
            MessageLookupByLibrary.simpleMessage("Service Details"),
        "serviceType": MessageLookupByLibrary.simpleMessage("Service Type"),
        "serviceTypes": MessageLookupByLibrary.simpleMessage("Service Types"),
        "serviceValue": MessageLookupByLibrary.simpleMessage("Service Value"),
        "services": MessageLookupByLibrary.simpleMessage("Services"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "share": MessageLookupByLibrary.simpleMessage("Share"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signUpSuccess": MessageLookupByLibrary.simpleMessage(
            "Account created successfully"),
        "success":
            MessageLookupByLibrary.simpleMessage("Action done successfully"),
        "thereIsAnotherAccount": MessageLookupByLibrary.simpleMessage(
            "There is already an account with this credential"),
        "thisService": MessageLookupByLibrary.simpleMessage("this service"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "total": MessageLookupByLibrary.simpleMessage("Total value"),
        "totalReceived": MessageLookupByLibrary.simpleMessage("Total received"),
        "unknowError": MessageLookupByLibrary.simpleMessage(
            "An unknown exception occurred"),
        "userHasBeenDisabled": MessageLookupByLibrary.simpleMessage(
            "This user has been disabled. Please contact support for help"),
        "verificationCodeIsInvalid": MessageLookupByLibrary.simpleMessage(
            "The verification code entered is invalid"),
        "verificationIdIsInvalid": MessageLookupByLibrary.simpleMessage(
            "The verification ID entered is invalid"),
        "week": MessageLookupByLibrary.simpleMessage("Week"),
        "wouldYouLikeDelete": m5,
        "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday")
      };
}
