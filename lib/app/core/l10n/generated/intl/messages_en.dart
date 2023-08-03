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

  static String m1(start, end) => "From ${start} to ${end}";

  static String m2(person) => "Hi, ${person}!";

  static String m3(property) => "${property} is being used";

  static String m4(property) => "${property} is invalid";

  static String m5(property) => "${property} is Empty";

  static String m6(property) => "${property} is required";

  static String m7(item) => "Would you like to delete ${item}?";

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
        "clipperCut": MessageLookupByLibrary.simpleMessage("Clipper cut"),
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
        "editServiceType": MessageLookupByLibrary.simpleMessage("Edit Type"),
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
        "field": MessageLookupByLibrary.simpleMessage("Field"),
        "filteringLastMonth":
            MessageLookupByLibrary.simpleMessage("Filtering by last month"),
        "filters": MessageLookupByLibrary.simpleMessage("Filters"),
        "finish": MessageLookupByLibrary.simpleMessage("Finish"),
        "fortnight": MessageLookupByLibrary.simpleMessage("Fortnight"),
        "fromTo": m1,
        "googleSignIn":
            MessageLookupByLibrary.simpleMessage("Sign in with Google"),
        "hi": m2,
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "inUse": m3,
        "incorrectEmailOrPassword":
            MessageLookupByLibrary.simpleMessage("Incorrect email or password"),
        "invalidNumber": MessageLookupByLibrary.simpleMessage(
            "Please, inform a valid number"),
        "invalidProperty": m4,
        "isEmpty": m5,
        "lastMonth": MessageLookupByLibrary.simpleMessage("Last Month"),
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
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "noResults": MessageLookupByLibrary.simpleMessage("No results"),
        "noServiceTypes": MessageLookupByLibrary.simpleMessage(
            "It seems you don\'t have any service type registered yet, click on the button above to register a new one."),
        "noServices": MessageLookupByLibrary.simpleMessage(
            "It seems you don\'t have any service registered yet, click on the button above to register a new one.\n\nRemember, by default this screen shows the services you made this month. Try changing the filters above to see different dates."),
        "noServicesHome": MessageLookupByLibrary.simpleMessage(
            "It seems you don\'t have any service registered today yet, click on the button above to register a new one.\n\nRemember, this screen shows only the services that you made today. Go to the services page to see other dates."),
        "numberLesserThanZero": MessageLookupByLibrary.simpleMessage(
            "Please, inform a number equal or greater than 0"),
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
        "requiredProperty": m6,
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveService": MessageLookupByLibrary.simpleMessage("Save Service"),
        "saveType": MessageLookupByLibrary.simpleMessage("Save Type"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "selectServiceType":
            MessageLookupByLibrary.simpleMessage("Select the service type"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
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
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "success":
            MessageLookupByLibrary.simpleMessage("Action done successfully"),
        "thereIsAnotherAccount": MessageLookupByLibrary.simpleMessage(
            "There is already an account with this credential"),
        "thisService": MessageLookupByLibrary.simpleMessage("this service"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "total": MessageLookupByLibrary.simpleMessage("Total value"),
        "totalReceived": MessageLookupByLibrary.simpleMessage("Total received"),
        "tourAppBarDescription": MessageLookupByLibrary.simpleMessage(
            "Here you can register the types of services you perform and log out of your account."),
        "tourAppBarTitle": MessageLookupByLibrary.simpleMessage("Perfil Area"),
        "tourBottomNavigationServicesDescription":
            MessageLookupByLibrary.simpleMessage(
                "In this menu you will find all the services you have performed, and also being able to register a new service."),
        "tourBottomNavigationServicesTitle":
            MessageLookupByLibrary.simpleMessage("Services Area"),
        "tourHomeBalanceDescription": MessageLookupByLibrary.simpleMessage(
            "Here your daily earnings are displayed, also the total discount and the total received."),
        "tourHomeBalanceTitle": MessageLookupByLibrary.simpleMessage("Balance"),
        "tourHomeServicesDescription": MessageLookupByLibrary.simpleMessage(
            "These are the services you performed today."),
        "tourHomeServicesTitle":
            MessageLookupByLibrary.simpleMessage("Daily Services"),
        "tourProfileDescription": MessageLookupByLibrary.simpleMessage(
            "Here you will find some actions available, including the one to register a new type of service. The service type allows you to easily identify a service provided."),
        "tourProfileTitle": MessageLookupByLibrary.simpleMessage("Actions"),
        "tourServiceDetailsDescription": MessageLookupByLibrary.simpleMessage(
            "You can click in the services to see all the information, update or delete it."),
        "tourServiceDetailsTitle":
            MessageLookupByLibrary.simpleMessage("Service Details"),
        "tourServiceTypesDescription": MessageLookupByLibrary.simpleMessage(
            "This information will help you to easily register the services you will perform. You can give a name, such as \"Lashes - Brazilian Volume\", fill in the default value, and if applicable, the percentage that is normally deducted from this service."),
        "tourServiceTypesTitle":
            MessageLookupByLibrary.simpleMessage("Service Type"),
        "tourServicesForm1Description": MessageLookupByLibrary.simpleMessage(
            "To register a new service provided, first select one of the types of service that you previously registered and the values will be filled in automatically according to the data of that type of service. If you wish, you can change the values for that specific service."),
        "tourServicesForm1Title":
            MessageLookupByLibrary.simpleMessage("New Service"),
        "tourServicesForm2Description": MessageLookupByLibrary.simpleMessage(
            "Just select the date and the number of services performed, and fill in a description or note if you wish."),
        "tourServicesForm2Title":
            MessageLookupByLibrary.simpleMessage("New Service"),
        "tourServicesInfoDescription": MessageLookupByLibrary.simpleMessage(
            "Here you can filter and sort your services and view the balance for the selected period. You can also register performed services."),
        "tourServicesInfoTitle":
            MessageLookupByLibrary.simpleMessage("Services"),
        "tourServicesListDescription": MessageLookupByLibrary.simpleMessage(
            "These are all the jobs you\'ve provided in a given period of time. By default you will see all the services for the current month."),
        "tourServicesListTitle":
            MessageLookupByLibrary.simpleMessage("Services"),
        "unknowError": MessageLookupByLibrary.simpleMessage(
            "An unknown exception occurred"),
        "userHasBeenDisabled": MessageLookupByLibrary.simpleMessage(
            "This user has been disabled. Please contact support for help"),
        "verificationCodeIsInvalid": MessageLookupByLibrary.simpleMessage(
            "The verification code entered is invalid"),
        "verificationIdIsInvalid": MessageLookupByLibrary.simpleMessage(
            "The verification ID entered is invalid"),
        "week": MessageLookupByLibrary.simpleMessage("Week"),
        "wouldYouLikeDelete": m7,
        "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday")
      };
}
