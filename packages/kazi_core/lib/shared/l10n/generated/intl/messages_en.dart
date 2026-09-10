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

  static String m1(amount) => "${amount} already received";

  static String m2(version, year) => "Kazi ${version} · ${year}";

  static String m3(date) => "Archived on ${date}";

  static String m4(name) => "${name} archived.";

  static String m5(count) =>
      "${Intl.plural(count, one: 'Closes in 1 day', other: 'Closes in ${count} days')}";

  static String m6(day) => "Day ${day}";

  static String m7(count) => "every ${count} days";

  static String m8(range) => "Current cycle: ${range}";

  static String m9(start, end) => "${start} to ${end}";

  static String m10(count, amount) =>
      "${Intl.plural(count, one: 'It names 1 service already registered. Deleting it now would leave that record unidentified.', other: 'It names ${count} services already registered. Deleting it now would leave those records unidentified — and they add up to ${amount} in your history.')}";

  static String m11(count) =>
      "${Intl.plural(count, one: 'Can\'t delete: 1 service uses this record.', other: 'Can\'t delete: ${count} services use this record.')}";

  static String m12(name) => "${name} cannot be deleted";

  static String m13(name) =>
      "\"${name}\" is already in your catalog, archived. Restore it?";

  static String m14(done, total) => "${done}/${total}";

  static String m15(count, name) =>
      "${Intl.plural(count, one: '${name} already exists, with 1 service. If it\'s the same person, use the one already there so the history isn\'t split in two.', other: '${name} already exists, with ${count} services. If it\'s the same person, use the one already there so the history isn\'t split in two.')}";

  static String m16(name, service, date) =>
      "${name} already exists, last seen for ${service} on ${date}. If it\'s the same person, use the one already there so the history isn\'t split in two.";

  static String m17(name) =>
      "${name} already exists. If it\'s the same person, use the one already there so the history isn\'t split in two.";

  static String m18(name) =>
      "You already have a client under this document: ${name}.";

  static String m19(name) =>
      "${name} is on file under this document, archived. Restore them instead of creating another.";

  static String m20(month) => "client since ${month}";

  static String m21(count) =>
      "${Intl.plural(count, one: '1 service in your catalog has no commission', other: '${count} services in your catalog have no commission')}";

  static String m22(percent, amount) => "${percent} of ${amount}";

  static String m23(percent) => "Commission ${percent}";

  static String m24(term) => "Create “${term}” in the catalog";

  static String m25(count) =>
      "This will be applied to ${count} services already registered.";

  static String m26(days) =>
      "${Intl.plural(days, zero: 'closes today', one: 'closes tomorrow', other: 'closes in ${days} days')}";

  static String m27(count, amount) =>
      "${Intl.plural(count, one: 'of ${amount} generated in 1 service', other: 'of ${amount} generated in ${count} services')}";

  static String m28(count) =>
      "${Intl.plural(count, one: 'The service already performed stays in your history. Only the contact details are erased. This can\'t be undone.', other: 'The ${count} services already performed stay in your history. Only the contact details are erased. This can\'t be undone.')}";

  static String m29(name) => "Delete ${name} for good?";

  static String m30(url) => "Could not launch ${url}";

  static String m31(start, end) => "Filtering from ${start} to ${end}";

  static String m32(latest, current) =>
      "Version ${latest} · you\'re on ${current}";

  static String m33(count) => "${count} services in the catalog";

  static String m34(count) => "${count} clients";

  static String m35(count) => "${count} services / month";

  static String m36(start, end) => "From ${start} to ${end}";

  static String m37(amount) => "of ${amount} generated";

  static String m38(amount) => "of ${amount} charged to clients";

  static String m39(person) => "Hi, ${person}!";

  static String m40(property) => "${property} is being used";

  static String m41(property) => "${property} is invalid";

  static String m42(property) => "${property} is Empty";

  static String m43(count) =>
      "${Intl.plural(count, one: '1 item', other: '${count} items')}";

  static String m44(date) => "Last on ${date}";

  static String m45(privacy) => "By continuing, you accept the ${privacy}.";

  static String m46(count) =>
      "${Intl.plural(count, one: 'Mark the 1 pending as received', other: 'Mark the ${count} pending as received')}";

  static String m47(amount) =>
      "${amount} in total. This changes no value and no date — it only records that the payment came in.";

  static String m48(count) =>
      "${Intl.plural(count, one: 'Mark 1 service as received?', other: 'Mark ${count} services as received?')}";

  static String m49(count) =>
      "${Intl.plural(count, one: 'The 1 service already received is not touched.', other: 'The ${count} services already received are not touched.')}";

  static String m50(term) => "Nothing found for “${term}”";

  static String m51(amount) => "of ${amount}";

  static String m52(price) => "${price}/month";

  static String m53(price) => "7 days free, then ${price}/month.";

  static String m54(amount) => "${amount} pending";

  static String m55(period) => "${period} · your earnings";

  static String m56(count) =>
      "${Intl.plural(count, one: 'Changing the price here applies to the next records. The service already registered keeps the value of its time.', other: 'Changing the price here applies to the next records. The ${count} services already registered keep the value of their time.')}";

  static String m57(date) => "Received on ${date}";

  static String m58(property) => "${property} is required";

  static String m59(name) => "${name} restored.";

  static String m60(count, amount) =>
      "${Intl.plural(count, one: '1 service', other: '${count} services')} · ${amount} for you";

  static String m61(count) =>
      "${Intl.plural(count, zero: 'No service', one: 'See 1 service', other: 'See ${count} services')}";

  static String m62(month) => "See the ${month} summary";

  static String m63(count) =>
      "${Intl.plural(count, one: 'See the 1 service', other: 'See the ${count} services')}";

  static String m64(count) =>
      "${Intl.plural(count, one: '1 service', other: '${count} services')}";

  static String m65(count) => "Continue with ${count}";

  static String m66(day) => "day ${day}";

  static String m67(total, percent) => "of ${total} · ${percent} commission";

  static String m68(count) => "Show all (${count})";

  static String m69(count) =>
      "${Intl.plural(count, one: 'Today · 1 service', other: 'Today · ${count} services')}";

  static String m70(name) => "Use the ${name} that already exists";

  static String m71(count) =>
      "${Intl.plural(count, one: 'used in 1 service', other: 'used in ${count} services')}";

  static String m72(count) =>
      "${Intl.plural(count, one: '1 use', other: '${count} uses')}";

  static String m73(count) => "View archived · ${count}";

  static String m74(version) => "Version ${version}";

  static String m75(item) => "Would you like to delete ${item}?";

  static String m76(amount) => "Your earnings: ${amount}";

  static String m77(amount) => "${amount} is yours";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "actions": MessageLookupByLibrary.simpleMessage("Actions"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addClient": MessageLookupByLibrary.simpleMessage("Add client"),
    "address": MessageLookupByLibrary.simpleMessage("Address"),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "allClients": MessageLookupByLibrary.simpleMessage("All clients"),
    "allReceipts": MessageLookupByLibrary.simpleMessage("All"),
    "alreadyExists": m0,
    "alreadyHasAccont": MessageLookupByLibrary.simpleMessage(
      "Already has an account? ",
    ),
    "alreadyReceived": m1,
    "amount": MessageLookupByLibrary.simpleMessage("Amount"),
    "appSubtitle": MessageLookupByLibrary.simpleMessage(
      "Organize your services",
    ),
    "appVersionFooter": m2,
    "applyFilters": MessageLookupByLibrary.simpleMessage("Apply Filters"),
    "archive": MessageLookupByLibrary.simpleMessage("Archive"),
    "archived": MessageLookupByLibrary.simpleMessage("Archived"),
    "archivedCatalogItems": MessageLookupByLibrary.simpleMessage(
      "Archived catalog",
    ),
    "archivedCatalogNote": MessageLookupByLibrary.simpleMessage(
      "Archived catalog items do not show up when you register a service, but they keep naming the services they were already used in.",
    ),
    "archivedClients": MessageLookupByLibrary.simpleMessage("Archived clients"),
    "archivedClientsNote": MessageLookupByLibrary.simpleMessage(
      "An archived client disappears from searches and from the form, but stays in the history of the services already registered.",
    ),
    "archivedOn": m3,
    "archivedSectionLabel": MessageLookupByLibrary.simpleMessage("Archived"),
    "archivedSnackbar": m4,
    "attention": MessageLookupByLibrary.simpleMessage("Attention"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "billingCycle": MessageLookupByLibrary.simpleMessage("Pay cycle"),
    "billingCycleClosesInDays": m5,
    "billingCycleDay": m6,
    "billingCycleDescription": MessageLookupByLibrary.simpleMessage(
      "Kazi adds up your earnings within that period. It\'s what sets the big number on Home.",
    ),
    "billingCycleFortnightly": MessageLookupByLibrary.simpleMessage(
      "Fortnightly",
    ),
    "billingCycleFrequency": m7,
    "billingCycleLastDay": MessageLookupByLibrary.simpleMessage("Last day"),
    "billingCycleMonthly": MessageLookupByLibrary.simpleMessage("Monthly"),
    "billingCycleOther": MessageLookupByLibrary.simpleMessage("Other"),
    "billingCyclePayday": MessageLookupByLibrary.simpleMessage(
      "Day I get paid",
    ),
    "billingCyclePaydayWeekday": MessageLookupByLibrary.simpleMessage(
      "Weekday I get paid",
    ),
    "billingCyclePayoutDayGroup": MessageLookupByLibrary.simpleMessage(
      "You get paid on",
    ),
    "billingCyclePreview": m8,
    "billingCycleRange": m9,
    "billingCycleSave": MessageLookupByLibrary.simpleMessage("Save cycle"),
    "billingCycleWeekly": MessageLookupByLibrary.simpleMessage("Weekly"),
    "birthDate": MessageLookupByLibrary.simpleMessage("Birthday"),
    "byCatalogItem": MessageLookupByLibrary.simpleMessage("By service"),
    "calculator": MessageLookupByLibrary.simpleMessage("Calculator"),
    "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
    "call": MessageLookupByLibrary.simpleMessage("Call"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cantDeleteBody": m10,
    "cantDeleteLinkedServices": m11,
    "cantDeleteReassurance": MessageLookupByLibrary.simpleMessage(
      "Archived is enough: the item no longer shows up when you register a new service.",
    ),
    "cantDeleteTitle": m12,
    "catalogAll": MessageLookupByLibrary.simpleMessage("All"),
    "catalogItem": MessageLookupByLibrary.simpleMessage("Service"),
    "catalogItemArchivedRestorePrompt": m13,
    "catalogItemDuplicateName": MessageLookupByLibrary.simpleMessage(
      "There is already an item with this name. Use another name or edit the one that exists.",
    ),
    "catalogItemFormHint": MessageLookupByLibrary.simpleMessage(
      "Price and commission come from the catalog. You can change them for this record only.",
    ),
    "catalogItems": MessageLookupByLibrary.simpleMessage("Catalog"),
    "catalogMostUsed": MessageLookupByLibrary.simpleMessage("Most used"),
    "catalogWithoutCommission": MessageLookupByLibrary.simpleMessage(
      "No commission",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "checklistBuildCatalog": MessageLookupByLibrary.simpleMessage(
      "Build your catalog",
    ),
    "checklistFinished": MessageLookupByLibrary.simpleMessage(
      "Done. From here on, it is just registering.",
    ),
    "checklistFirstService": MessageLookupByLibrary.simpleMessage(
      "Register your first service",
    ),
    "checklistMarkReceived": MessageLookupByLibrary.simpleMessage(
      "Mark a service as received",
    ),
    "checklistProgress": m14,
    "checklistSeeSummary": MessageLookupByLibrary.simpleMessage(
      "See your monthly summary",
    ),
    "checklistThreeServices": MessageLookupByLibrary.simpleMessage(
      "Register 3 services in a row",
    ),
    "checklistTitle": MessageLookupByLibrary.simpleMessage("Make Kazi yours"),
    "clear": MessageLookupByLibrary.simpleMessage("Clear"),
    "clearAll": MessageLookupByLibrary.simpleMessage("Clear all"),
    "client": MessageLookupByLibrary.simpleMessage("Client"),
    "clientFormHint": MessageLookupByLibrary.simpleMessage(
      "Optional. It feeds the history and the per-client summary.",
    ),
    "clientNamesake": m15,
    "clientNamesakeLastService": m16,
    "clientNamesakePlain": m17,
    "clientSameDocument": m18,
    "clientSameDocumentArchived": m19,
    "clientSince": m20,
    "clientSinceLabel": MessageLookupByLibrary.simpleMessage("Client since"),
    "clients": MessageLookupByLibrary.simpleMessage("Clients"),
    "clientsEmptyExplained": MessageLookupByLibrary.simpleMessage(
      "Your clients show up here as you register services. You can also add one now.",
    ),
    "clipperCut": MessageLookupByLibrary.simpleMessage("Clipper cut"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "color": MessageLookupByLibrary.simpleMessage("Color"),
    "colorSwipeAll": MessageLookupByLibrary.simpleMessage(
      "Color · swipe to see all",
    ),
    "commission": MessageLookupByLibrary.simpleMessage("Commission"),
    "commissionGapsBody": MessageLookupByLibrary.simpleMessage(
      "Without it they count toward the total generated, but not toward what you receive.",
    ),
    "commissionGapsCta": MessageLookupByLibrary.simpleMessage(
      "Set now · 30 sec",
    ),
    "commissionGapsTitle": m21,
    "commissionOfGross": m22,
    "commissionPercent": m23,
    "commissionPercentage": MessageLookupByLibrary.simpleMessage(
      "Commission percentage",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmAction": MessageLookupByLibrary.simpleMessage("Confirm Action"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "contact": MessageLookupByLibrary.simpleMessage("Contact"),
    "contactEmail": MessageLookupByLibrary.simpleMessage(
      "guimaraeslucas242@gmail.com",
    ),
    "contactOptionsTitle": MessageLookupByLibrary.simpleMessage("Get in touch"),
    "continueAction": MessageLookupByLibrary.simpleMessage("Continue"),
    "continueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Continue with Google",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create an Account"),
    "createAndUse": MessageLookupByLibrary.simpleMessage("Create and use"),
    "createAnyway": MessageLookupByLibrary.simpleMessage("Create anyway"),
    "createInCatalog": m24,
    "currency": MessageLookupByLibrary.simpleMessage("Currency"),
    "currencyAED": MessageLookupByLibrary.simpleMessage("UAE dirham"),
    "currencyAOA": MessageLookupByLibrary.simpleMessage("Angolan kwanza"),
    "currencyARS": MessageLookupByLibrary.simpleMessage("Argentine peso"),
    "currencyBOB": MessageLookupByLibrary.simpleMessage("Bolivian boliviano"),
    "currencyBRL": MessageLookupByLibrary.simpleMessage("Brazilian real"),
    "currencyCAD": MessageLookupByLibrary.simpleMessage("Canadian dollar"),
    "currencyCHF": MessageLookupByLibrary.simpleMessage("Swiss franc"),
    "currencyCLP": MessageLookupByLibrary.simpleMessage("Chilean peso"),
    "currencyCNY": MessageLookupByLibrary.simpleMessage("Chinese yuan"),
    "currencyCOP": MessageLookupByLibrary.simpleMessage("Colombian peso"),
    "currencyCRC": MessageLookupByLibrary.simpleMessage("Costa Rican colón"),
    "currencyCUP": MessageLookupByLibrary.simpleMessage("Cuban peso"),
    "currencyChangeNote": MessageLookupByLibrary.simpleMessage(
      "Changing the currency changes the symbol and the format. Amounts already registered are not converted.",
    ),
    "currencyChangeNoteEmphasis": MessageLookupByLibrary.simpleMessage(
      "are not converted",
    ),
    "currencyDOP": MessageLookupByLibrary.simpleMessage("Dominican peso"),
    "currencyETB": MessageLookupByLibrary.simpleMessage("Ethiopian birr"),
    "currencyEUR": MessageLookupByLibrary.simpleMessage("Euro"),
    "currencyGBP": MessageLookupByLibrary.simpleMessage("Pound sterling"),
    "currencyGHS": MessageLookupByLibrary.simpleMessage("Ghanaian cedi"),
    "currencyGTQ": MessageLookupByLibrary.simpleMessage("Guatemalan quetzal"),
    "currencyHNL": MessageLookupByLibrary.simpleMessage("Honduran lempira"),
    "currencyHTG": MessageLookupByLibrary.simpleMessage("Haitian gourde"),
    "currencyINR": MessageLookupByLibrary.simpleMessage("Indian rupee"),
    "currencyJPY": MessageLookupByLibrary.simpleMessage("Japanese yen"),
    "currencyKES": MessageLookupByLibrary.simpleMessage("Kenyan shilling"),
    "currencyKRW": MessageLookupByLibrary.simpleMessage("South Korean won"),
    "currencyMAD": MessageLookupByLibrary.simpleMessage("Moroccan dirham"),
    "currencyMXN": MessageLookupByLibrary.simpleMessage("Mexican peso"),
    "currencyMigrationApplying": MessageLookupByLibrary.simpleMessage(
      "Updating your services…",
    ),
    "currencyMigrationChangeLater": MessageLookupByLibrary.simpleMessage(
      "You can change this later in Settings.",
    ),
    "currencyMigrationDescription": MessageLookupByLibrary.simpleMessage(
      "Kazi now supports several currencies. Tell us which one your existing services were registered in so your totals add up correctly.",
    ),
    "currencyMigrationServicesCount": m25,
    "currencyMigrationTitle": MessageLookupByLibrary.simpleMessage(
      "Which currency do you work in?",
    ),
    "currencyNGN": MessageLookupByLibrary.simpleMessage("Nigerian naira"),
    "currencyNIO": MessageLookupByLibrary.simpleMessage("Nicaraguan córdoba"),
    "currencyPAB": MessageLookupByLibrary.simpleMessage("Panamanian balboa"),
    "currencyPEN": MessageLookupByLibrary.simpleMessage("Peruvian sol"),
    "currencyPYG": MessageLookupByLibrary.simpleMessage("Paraguayan guaraní"),
    "currencyRUB": MessageLookupByLibrary.simpleMessage("Russian ruble"),
    "currencySAR": MessageLookupByLibrary.simpleMessage("Saudi riyal"),
    "currencySGD": MessageLookupByLibrary.simpleMessage("Singapore dollar"),
    "currencyTRY": MessageLookupByLibrary.simpleMessage("Turkish lira"),
    "currencyUGX": MessageLookupByLibrary.simpleMessage("Ugandan shilling"),
    "currencyUSD": MessageLookupByLibrary.simpleMessage("US dollar"),
    "currencyUYU": MessageLookupByLibrary.simpleMessage("Uruguayan peso"),
    "currencyVES": MessageLookupByLibrary.simpleMessage("Venezuelan bolívar"),
    "currencyXAF": MessageLookupByLibrary.simpleMessage(
      "Central African CFA franc",
    ),
    "currencyXOF": MessageLookupByLibrary.simpleMessage(
      "West African CFA franc",
    ),
    "currencyZAR": MessageLookupByLibrary.simpleMessage("South African rand"),
    "currentCycle": MessageLookupByLibrary.simpleMessage("Current cycle"),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Current Password"),
    "cycleClosesIn": m26,
    "cycleConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Kazi now groups your earnings by the period you get paid in. We are adding up by month, from the 1st to the last day. Is that right?",
    ),
    "cycleConfirmNo": MessageLookupByLibrary.simpleMessage(
      "I get paid differently",
    ),
    "cycleConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "One question, then back to your work",
    ),
    "cycleConfirmYes": MessageLookupByLibrary.simpleMessage("That is right"),
    "cycleGeneratedIn": m27,
    "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "date": MessageLookupByLibrary.simpleMessage("Date"),
    "defaultCurrency": MessageLookupByLibrary.simpleMessage("Default currency"),
    "defaultPrice": MessageLookupByLibrary.simpleMessage("Default price"),
    "defaultValue": MessageLookupByLibrary.simpleMessage("Default Value"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteClientImpact": m28,
    "deleteForeverTitle": m29,
    "deleteNoServicesImpact": MessageLookupByLibrary.simpleMessage(
      "It appears in no service, so nothing in your history changes. This can\'t be undone.",
    ),
    "deletePermanently": MessageLookupByLibrary.simpleMessage(
      "Delete permanently",
    ),
    "deleteServiceImpact": MessageLookupByLibrary.simpleMessage(
      "The record leaves your history and your totals. This can\'t be undone.",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "details": MessageLookupByLibrary.simpleMessage("Details"),
    "didntReceiveAnything": MessageLookupByLibrary.simpleMessage(
      "Didn\'t receive anything? ",
    ),
    "discountPercentage": MessageLookupByLibrary.simpleMessage(
      "Discount percentage",
    ),
    "document": MessageLookupByLibrary.simpleMessage("Document"),
    "documentHint": MessageLookupByLibrary.simpleMessage(
      "Tax id, national id or other",
    ),
    "documentPrivacyHint": MessageLookupByLibrary.simpleMessage(
      "Only so you can identify the person and issue a receipt. Kazi neither validates this number nor sends it anywhere.",
    ),
    "doesntHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Doesn\'t have an account? ",
    ),
    "earnedYou": MessageLookupByLibrary.simpleMessage("Earned you"),
    "earningsPerWeek": MessageLookupByLibrary.simpleMessage(
      "your earnings per week",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editService": MessageLookupByLibrary.simpleMessage("Edit Service"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "employee": MessageLookupByLibrary.simpleMessage("Employee"),
    "employees": MessageLookupByLibrary.simpleMessage("Employees"),
    "errorAccessDenied": MessageLookupByLibrary.simpleMessage("Access Denied"),
    "errorCantDeleteCatalogItem": MessageLookupByLibrary.simpleMessage(
      "This service can\'t be removed from the catalog because it is in use",
    ),
    "errorCredentialIsInvalid": MessageLookupByLibrary.simpleMessage(
      "The credential is invalid",
    ),
    "errorDataIsSafe": MessageLookupByLibrary.simpleMessage(
      "Your data is saved — just try again.",
    ),
    "errorEmailIsInvalid": MessageLookupByLibrary.simpleMessage(
      "Email is invalid or badly formatted",
    ),
    "errorEmailWasNotFound": MessageLookupByLibrary.simpleMessage(
      "Email was not found, please create an account",
    ),
    "errorIncorrectEmailOrPassword": MessageLookupByLibrary.simpleMessage(
      "Incorrect email or password",
    ),
    "errorLaunchUrl": m30,
    "errorMethodNotAllowed": MessageLookupByLibrary.simpleMessage(
      "Method not allowed. Please try another account or contact support for help",
    ),
    "errorNotFound": MessageLookupByLibrary.simpleMessage("Url not found."),
    "errorThereIsAnotherAccount": MessageLookupByLibrary.simpleMessage(
      "There is already an account with this credential",
    ),
    "errorTimeout": MessageLookupByLibrary.simpleMessage(
      "The server took a long time to respond. Please try again later or contact us.",
    ),
    "errorToAddCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Error adding the service to the catalog.",
    ),
    "errorToAddClient": MessageLookupByLibrary.simpleMessage(
      "Error to add client.",
    ),
    "errorToAddService": MessageLookupByLibrary.simpleMessage(
      "Error to add service.",
    ),
    "errorToArchiveCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Error archiving the catalog item.",
    ),
    "errorToArchiveClient": MessageLookupByLibrary.simpleMessage(
      "Error archiving the client.",
    ),
    "errorToCountServices": MessageLookupByLibrary.simpleMessage(
      "Error to count services.",
    ),
    "errorToDeleteCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Error removing the service from the catalog.",
    ),
    "errorToDeleteClient": MessageLookupByLibrary.simpleMessage(
      "Error to delete client.",
    ),
    "errorToDeleteService": MessageLookupByLibrary.simpleMessage(
      "Error to delete service.",
    ),
    "errorToGetCatalogItems": MessageLookupByLibrary.simpleMessage(
      "Error loading your catalog.",
    ),
    "errorToGetClients": MessageLookupByLibrary.simpleMessage(
      "Error to get clients.",
    ),
    "errorToGetServices": MessageLookupByLibrary.simpleMessage(
      "Error to get service.",
    ),
    "errorToGetUserSettings": MessageLookupByLibrary.simpleMessage(
      "We couldn\'t load your settings.",
    ),
    "errorToMarkReceived": MessageLookupByLibrary.simpleMessage(
      "Error marking the services as received",
    ),
    "errorToMigrateCurrency": MessageLookupByLibrary.simpleMessage(
      "We couldn\'t update your services. Please try again.",
    ),
    "errorToOpenApp": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t open the app.",
    ),
    "errorToResetPassword": MessageLookupByLibrary.simpleMessage(
      "Error to reset password.",
    ),
    "errorToRestoreCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Error restoring the catalog item.",
    ),
    "errorToRestoreClient": MessageLookupByLibrary.simpleMessage(
      "Error restoring the client.",
    ),
    "errorToSaveUserSettings": MessageLookupByLibrary.simpleMessage(
      "We couldn\'t save your settings.",
    ),
    "errorToSendEmail": MessageLookupByLibrary.simpleMessage(
      "Error to send email.",
    ),
    "errorToSignIn": MessageLookupByLibrary.simpleMessage(
      "Error to sign in. Try again later or contact the support.",
    ),
    "errorToSignUp": MessageLookupByLibrary.simpleMessage(
      "Error to sign up. Try again later or contact the support.",
    ),
    "errorToUpdateCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Error updating the service in the catalog.",
    ),
    "errorToUpdateClient": MessageLookupByLibrary.simpleMessage(
      "Error to update client.",
    ),
    "errorToUpdateService": MessageLookupByLibrary.simpleMessage(
      "Error to update service.",
    ),
    "errorToVerifyDocument": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t check whether this document is already on file. Try again.",
    ),
    "errorTokenExpired": MessageLookupByLibrary.simpleMessage(
      "Your login expired. Please, login and try again.",
    ),
    "errorUnknowError": MessageLookupByLibrary.simpleMessage(
      "An unknown exception occurred.",
    ),
    "errorUserHasBeenDisabled": MessageLookupByLibrary.simpleMessage(
      "This user has been disabled. Please contact support for help",
    ),
    "errorVerificationCodeIsInvalid": MessageLookupByLibrary.simpleMessage(
      "The verification code entered is invalid",
    ),
    "errorVerificationIdIsInvalid": MessageLookupByLibrary.simpleMessage(
      "The verification ID entered is invalid",
    ),
    "exit": MessageLookupByLibrary.simpleMessage("Exit"),
    "featureNoAds": MessageLookupByLibrary.simpleMessage("No ads"),
    "featureUnlimitedCatalog": MessageLookupByLibrary.simpleMessage(
      "Unlimited catalog",
    ),
    "featureUnlimitedClients": MessageLookupByLibrary.simpleMessage(
      "Unlimited clients",
    ),
    "featureUnlimitedServices": MessageLookupByLibrary.simpleMessage(
      "Unlimited services",
    ),
    "field": MessageLookupByLibrary.simpleMessage("Field"),
    "filteringFromTo": m31,
    "filteringLastMonth": MessageLookupByLibrary.simpleMessage(
      "Filtering by last month",
    ),
    "filteringToday": MessageLookupByLibrary.simpleMessage(
      "Filtering by today",
    ),
    "filters": MessageLookupByLibrary.simpleMessage("Filters"),
    "finish": MessageLookupByLibrary.simpleMessage("Finish"),
    "forcedUpdateButton": MessageLookupByLibrary.simpleMessage("Update now"),
    "forcedUpdateMessage": MessageLookupByLibrary.simpleMessage(
      "Update to continue — your data is saved and appears as soon as the app opens.",
    ),
    "forcedUpdateTitle": MessageLookupByLibrary.simpleMessage(
      "This version of Kazi has stopped working",
    ),
    "forcedUpdateVersions": m32,
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password"),
    "forgotPasswordConfirmation1": MessageLookupByLibrary.simpleMessage(
      "We have sent an email to ",
    ),
    "forgotPasswordConfirmation2": MessageLookupByLibrary.simpleMessage(
      " to recover your password. Once you receive the email, follow the link provided to sign in.",
    ),
    "forgotPasswordInfo": MessageLookupByLibrary.simpleMessage(
      "Please, enter your email address to receive a link to reset your password.",
    ),
    "forgotYourPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot your password?",
    ),
    "fortnight": MessageLookupByLibrary.simpleMessage("15 days"),
    "freeLimitAds": MessageLookupByLibrary.simpleMessage("With ads"),
    "freeLimitCatalogItems": m33,
    "freeLimitClients": m34,
    "freeLimitServices": m35,
    "freePlan": MessageLookupByLibrary.simpleMessage("Free"),
    "freeToDelete": MessageLookupByLibrary.simpleMessage("free"),
    "fromTo": m36,
    "generated": MessageLookupByLibrary.simpleMessage("Generated"),
    "generatedFromAmount": m37,
    "generatedFromClients": m38,
    "generatedInPeriod": MessageLookupByLibrary.simpleMessage(
      "Generated in the period",
    ),
    "generatedSoFar": MessageLookupByLibrary.simpleMessage("Generated so far"),
    "goPremium": MessageLookupByLibrary.simpleMessage("Go Premium"),
    "googleSignIn": MessageLookupByLibrary.simpleMessage("Sign in with Google"),
    "hi": m39,
    "hintFabBody": MessageLookupByLibrary.simpleMessage(
      "Every time you finish a job, tap the K in the middle of the bar. Choose the service, confirm, and it is registered.",
    ),
    "hintFabTitle": MessageLookupByLibrary.simpleMessage(
      "This is where you register",
    ),
    "hintFiltersBody": MessageLookupByLibrary.simpleMessage(
      "With some history behind you, the filters find a client, a period or a service.",
    ),
    "hintFiltersTitle": MessageLookupByLibrary.simpleMessage("Narrow the list"),
    "hintGotIt": MessageLookupByLibrary.simpleMessage("Got it"),
    "hintReceivedBody": MessageLookupByLibrary.simpleMessage(
      "Marking a service as received closes the loop between what you earned and what you were paid.",
    ),
    "hintReceivedTitle": MessageLookupByLibrary.simpleMessage(
      "Mark it when the money lands",
    ),
    "hintSummaryBody": MessageLookupByLibrary.simpleMessage(
      "The summary shows what you generated, what is yours and what has already been paid.",
    ),
    "hintSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Your month, in one place",
    ),
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "howToUseClientEarningsBody": MessageLookupByLibrary.simpleMessage(
      "Open a client and tap \"See in the summary\" to know what they generated and what you were paid.",
    ),
    "howToUseClientEarningsTitle": MessageLookupByLibrary.simpleMessage(
      "See what each client is worth",
    ),
    "howToUseCloseCycleBody": MessageLookupByLibrary.simpleMessage(
      "On the Services header, mark everything still pending as received in one tap.",
    ),
    "howToUseCloseCycleTitle": MessageLookupByLibrary.simpleMessage(
      "Close the whole period at once",
    ),
    "howToUseKazi": MessageLookupByLibrary.simpleMessage("How to use Kazi"),
    "howToUseStartBody": MessageLookupByLibrary.simpleMessage(
      "The yellow button in the middle of the bar opens the screen to register a service.",
    ),
    "howToUseStartHere": MessageLookupByLibrary.simpleMessage("Start here"),
    "howToUseStartTitle": MessageLookupByLibrary.simpleMessage(
      "Register a service",
    ),
    "inUse": m40,
    "invalidIntNumber": MessageLookupByLibrary.simpleMessage(
      "Please, inform a valid integer number",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage(
      "Please, inform a valid number",
    ),
    "invalidProperty": m41,
    "isEmpty": m42,
    "itemsCount": m43,
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "languageRestartNote": MessageLookupByLibrary.simpleMessage(
      "The app restarts to apply the language. Nothing you registered is lost.",
    ),
    "lastMonth": MessageLookupByLibrary.simpleMessage("Last Month"),
    "lastServiceOn": m44,
    "lastServices": MessageLookupByLibrary.simpleMessage("Last services"),
    "leaveApp": MessageLookupByLibrary.simpleMessage(
      "Do you really want to leave the app?",
    ),
    "lightMode": MessageLookupByLibrary.simpleMessage("Light Mode"),
    "limitReachedCatalogTitle": MessageLookupByLibrary.simpleMessage(
      "You reached your catalog limit",
    ),
    "limitReachedClientsTitle": MessageLookupByLibrary.simpleMessage(
      "You reached the client limit",
    ),
    "limitReachedServicesTitle": MessageLookupByLibrary.simpleMessage(
      "You reached this month\'s service limit",
    ),
    "limitReachedSubtitle": MessageLookupByLibrary.simpleMessage(
      "Go Premium to keep adding without limits.",
    ),
    "list": MessageLookupByLibrary.simpleMessage("List"),
    "loadMore": MessageLookupByLibrary.simpleMessage("Load more"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "loginHeadline": MessageLookupByLibrary.simpleMessage(
      "Your work, made clear.",
    ),
    "loginLegal": m45,
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Sign in to see how much you make and how much you keep.",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
      "Do you really want to logout?",
    ),
    "managePlan": MessageLookupByLibrary.simpleMessage("Manage plan"),
    "markAsReceived": MessageLookupByLibrary.simpleMessage("Mark as received"),
    "markListedReceived": m46,
    "markListedReceivedBody": m47,
    "markListedReceivedConfirm": m48,
    "markListedReceivedUntouched": m49,
    "markReceived": MessageLookupByLibrary.simpleMessage("Mark received"),
    "markedAsReceived": MessageLookupByLibrary.simpleMessage(
      "Marked as received",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Menu"),
    "month": MessageLookupByLibrary.simpleMessage("Month"),
    "mostGets": MessageLookupByLibrary.simpleMessage("Mostly gets"),
    "myWork": MessageLookupByLibrary.simpleMessage("My work"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "newCatalogItem": MessageLookupByLibrary.simpleMessage("New service"),
    "newClient": MessageLookupByLibrary.simpleMessage("New Client"),
    "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
    "newService": MessageLookupByLibrary.simpleMessage("New service"),
    "newShort": MessageLookupByLibrary.simpleMessage("+ New"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noCatalogItems": MessageLookupByLibrary.simpleMessage(
      "Your catalog is empty. Tap the button above to add your first service.",
    ),
    "noCatalogItemsDescription": MessageLookupByLibrary.simpleMessage(
      "Register what you do and for how much.",
    ),
    "noClientsDescription": MessageLookupByLibrary.simpleMessage(
      "They are created on their own as you register services. Or add the first one now.",
    ),
    "noClientsFound": MessageLookupByLibrary.simpleMessage("No clients found"),
    "noColor": MessageLookupByLibrary.simpleMessage("No color"),
    "noResults": MessageLookupByLibrary.simpleMessage("No results"),
    "noServiceForThisClient": MessageLookupByLibrary.simpleMessage(
      "No service registered for this person yet.",
    ),
    "noServiceYet": MessageLookupByLibrary.simpleMessage("No service yet"),
    "noServices": MessageLookupByLibrary.simpleMessage("No services"),
    "noServicesForFilters": MessageLookupByLibrary.simpleMessage(
      "No service matches these filters.",
    ),
    "noServicesFound": MessageLookupByLibrary.simpleMessage(
      "No services found.",
    ),
    "noServicesToday": MessageLookupByLibrary.simpleMessage(
      "No services registered today",
    ),
    "noServicesTodayDescription": MessageLookupByLibrary.simpleMessage(
      "Register one and it shows up here.",
    ),
    "noServicesYet": MessageLookupByLibrary.simpleMessage("No services yet"),
    "notReceived": MessageLookupByLibrary.simpleMessage("Not received yet"),
    "nothingFoundFor": m50,
    "nothingFoundForDescription": MessageLookupByLibrary.simpleMessage(
      "No service, client or catalog item by that name.",
    ),
    "nothingFoundInCatalog": MessageLookupByLibrary.simpleMessage(
      "No catalog item by that name.",
    ),
    "numberBiggerThan100": MessageLookupByLibrary.simpleMessage(
      "Please, inform a number equal or lesser than 100",
    ),
    "numberLesserThanZero": MessageLookupByLibrary.simpleMessage(
      "Please, inform a number equal or greater than 0",
    ),
    "observation": MessageLookupByLibrary.simpleMessage("Note"),
    "observationHint": MessageLookupByLibrary.simpleMessage(
      "Allergy, preference, usual time",
    ),
    "ofGross": m51,
    "optional": MessageLookupByLibrary.simpleMessage("optional"),
    "optionalUpdateMessage": MessageLookupByLibrary.simpleMessage(
      "A new version of Kazi is available with improvements. Would you like to update now?",
    ),
    "optionalUpdateTitle": MessageLookupByLibrary.simpleMessage(
      "Update available",
    ),
    "or": MessageLookupByLibrary.simpleMessage("or"),
    "orderAlphabetical": MessageLookupByLibrary.simpleMessage("A–Z"),
    "orderBy": MessageLookupByLibrary.simpleMessage("Sort by"),
    "orderDateAsc": MessageLookupByLibrary.simpleMessage("Oldest first"),
    "orderDateDesc": MessageLookupByLibrary.simpleMessage("Newest first"),
    "orderLastService": MessageLookupByLibrary.simpleMessage("Last service"),
    "orderTopEarning": MessageLookupByLibrary.simpleMessage("Top earning"),
    "orderValueAsc": MessageLookupByLibrary.simpleMessage("Lowest value"),
    "orderValueDesc": MessageLookupByLibrary.simpleMessage("Highest value"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "paywallPricePerMonth": m52,
    "paywallRenewInfo": MessageLookupByLibrary.simpleMessage(
      "Auto-renews monthly. Cancel anytime.",
    ),
    "paywallRestore": MessageLookupByLibrary.simpleMessage("Restore purchase"),
    "paywallStartTrial": MessageLookupByLibrary.simpleMessage(
      "Start 7-day free trial",
    ),
    "paywallSubscribe": MessageLookupByLibrary.simpleMessage("Subscribe"),
    "paywallSubtitle": MessageLookupByLibrary.simpleMessage(
      "Remove every limit and all ads.",
    ),
    "paywallTitle": MessageLookupByLibrary.simpleMessage("Unlock Kazi Premium"),
    "paywallTrialThenPrice": m53,
    "pendingAmount": m54,
    "pendingReceipt": MessageLookupByLibrary.simpleMessage("Pending"),
    "period": MessageLookupByLibrary.simpleMessage("Period"),
    "periodYourEarnings": m55,
    "phone": MessageLookupByLibrary.simpleMessage("Phone"),
    "phoneHint": MessageLookupByLibrary.simpleMessage("To reach them later"),
    "pickDate": MessageLookupByLibrary.simpleMessage("Pick"),
    "pickDates": MessageLookupByLibrary.simpleMessage("Pick dates"),
    "planComparisonTitle": MessageLookupByLibrary.simpleMessage(
      "Free vs Premium",
    ),
    "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
    "premiumPlan": MessageLookupByLibrary.simpleMessage("Premium"),
    "premiumUnlimited": MessageLookupByLibrary.simpleMessage(
      "Everything unlimited, no ads",
    ),
    "presetCleaning": MessageLookupByLibrary.simpleMessage(
      "Cleaning and housekeeping",
    ),
    "presetCleaningDeepClean": MessageLookupByLibrary.simpleMessage(
      "Deep clean",
    ),
    "presetCleaningFullDay": MessageLookupByLibrary.simpleMessage("Full day"),
    "presetCleaningHalfDay": MessageLookupByLibrary.simpleMessage("Half day"),
    "presetCleaningIroning": MessageLookupByLibrary.simpleMessage(
      "Ironing, per hour",
    ),
    "presetCleaningPostConstruction": MessageLookupByLibrary.simpleMessage(
      "Post-construction clean",
    ),
    "presetDesign": MessageLookupByLibrary.simpleMessage("Design and creative"),
    "presetDesignBrandIdentity": MessageLookupByLibrary.simpleMessage(
      "Brand identity",
    ),
    "presetDesignHourly": MessageLookupByLibrary.simpleMessage("Hourly rate"),
    "presetDesignLandingPage": MessageLookupByLibrary.simpleMessage(
      "Landing page",
    ),
    "presetDesignLogo": MessageLookupByLibrary.simpleMessage("Logo"),
    "presetDesignSocialPost": MessageLookupByLibrary.simpleMessage(
      "Social media post",
    ),
    "presetEsthetics": MessageLookupByLibrary.simpleMessage(
      "Esthetics and brows",
    ),
    "presetEstheticsBrowDesign": MessageLookupByLibrary.simpleMessage(
      "Brow shaping",
    ),
    "presetEstheticsBrowHenna": MessageLookupByLibrary.simpleMessage(
      "Brow shaping with henna",
    ),
    "presetEstheticsFacialCleansing": MessageLookupByLibrary.simpleMessage(
      "Facial cleansing",
    ),
    "presetEstheticsFullLegWax": MessageLookupByLibrary.simpleMessage(
      "Full leg wax",
    ),
    "presetEstheticsLashExtensions": MessageLookupByLibrary.simpleMessage(
      "Lash extensions",
    ),
    "presetEstheticsPeeling": MessageLookupByLibrary.simpleMessage("Peel"),
    "presetEstheticsUnderarmWax": MessageLookupByLibrary.simpleMessage(
      "Underarm wax",
    ),
    "presetEstheticsUpperLipWax": MessageLookupByLibrary.simpleMessage(
      "Upper lip wax",
    ),
    "presetHair": MessageLookupByLibrary.simpleMessage("Hair and barbering"),
    "presetHairBeard": MessageLookupByLibrary.simpleMessage("Beard trim"),
    "presetHairBlowDry": MessageLookupByLibrary.simpleMessage("Blow-dry"),
    "presetHairColoring": MessageLookupByLibrary.simpleMessage("Colouring"),
    "presetHairConditioning": MessageLookupByLibrary.simpleMessage(
      "Deep conditioning",
    ),
    "presetHairCutAndBeard": MessageLookupByLibrary.simpleMessage(
      "Haircut and beard",
    ),
    "presetHairHighlights": MessageLookupByLibrary.simpleMessage("Highlights"),
    "presetHairMensCut": MessageLookupByLibrary.simpleMessage("Men\'s haircut"),
    "presetHairWomensCut": MessageLookupByLibrary.simpleMessage(
      "Women\'s haircut",
    ),
    "presetHandyman": MessageLookupByLibrary.simpleMessage(
      "Assembly and repairs",
    ),
    "presetHandymanBed": MessageLookupByLibrary.simpleMessage("Bed assembly"),
    "presetHandymanCallout": MessageLookupByLibrary.simpleMessage(
      "Call-out visit",
    ),
    "presetHandymanShelf": MessageLookupByLibrary.simpleMessage(
      "Shelf or bracket",
    ),
    "presetHandymanTvMount": MessageLookupByLibrary.simpleMessage(
      "TV mounting",
    ),
    "presetHandymanWardrobe": MessageLookupByLibrary.simpleMessage(
      "Wardrobe assembly",
    ),
    "presetMakeup": MessageLookupByLibrary.simpleMessage("Makeup"),
    "presetMakeupBride": MessageLookupByLibrary.simpleMessage("Bridal makeup"),
    "presetMakeupBridesmaid": MessageLookupByLibrary.simpleMessage(
      "Bridesmaid makeup",
    ),
    "presetMakeupClass": MessageLookupByLibrary.simpleMessage(
      "Self-makeup class",
    ),
    "presetMakeupGraduation": MessageLookupByLibrary.simpleMessage(
      "Graduation makeup",
    ),
    "presetMakeupSocial": MessageLookupByLibrary.simpleMessage("Event makeup"),
    "presetManicure": MessageLookupByLibrary.simpleMessage(
      "Manicure and pedicure",
    ),
    "presetManicureExtensionRemoval": MessageLookupByLibrary.simpleMessage(
      "Extension removal",
    ),
    "presetManicureFootSpa": MessageLookupByLibrary.simpleMessage("Foot spa"),
    "presetManicureGelExtension": MessageLookupByLibrary.simpleMessage(
      "Gel extensions",
    ),
    "presetManicureGelRefill": MessageLookupByLibrary.simpleMessage(
      "Gel refill",
    ),
    "presetManicureHandsAndFeet": MessageLookupByLibrary.simpleMessage(
      "Hands and feet",
    ),
    "presetManicurePolishFeet": MessageLookupByLibrary.simpleMessage(
      "Foot polish",
    ),
    "presetManicurePolishHands": MessageLookupByLibrary.simpleMessage(
      "Hand polish",
    ),
    "presetManicureStrengthening": MessageLookupByLibrary.simpleMessage(
      "Nail strengthening",
    ),
    "presetMassage": MessageLookupByLibrary.simpleMessage(
      "Massage and wellness",
    ),
    "presetMassageContouring": MessageLookupByLibrary.simpleMessage(
      "Contouring massage",
    ),
    "presetMassageHotStone": MessageLookupByLibrary.simpleMessage(
      "Hot stone massage",
    ),
    "presetMassageLymphatic": MessageLookupByLibrary.simpleMessage(
      "Lymphatic drainage",
    ),
    "presetMassagePackTen": MessageLookupByLibrary.simpleMessage(
      "Pack of 10 sessions",
    ),
    "presetMassageRelaxing": MessageLookupByLibrary.simpleMessage(
      "Relaxing massage, 60 min",
    ),
    "presetOther": MessageLookupByLibrary.simpleMessage("Another profession"),
    "presetPersonalAssessment": MessageLookupByLibrary.simpleMessage(
      "Fitness assessment",
    ),
    "presetPersonalMonthlyPlan": MessageLookupByLibrary.simpleMessage(
      "Monthly, 3× a week",
    ),
    "presetPersonalOnlineProgram": MessageLookupByLibrary.simpleMessage(
      "Online program",
    ),
    "presetPersonalPackEight": MessageLookupByLibrary.simpleMessage(
      "Pack of 8 sessions",
    ),
    "presetPersonalSingleSession": MessageLookupByLibrary.simpleMessage(
      "Single session",
    ),
    "presetPersonalTrainer": MessageLookupByLibrary.simpleMessage(
      "Personal training",
    ),
    "pricayPoliceLinks": MessageLookupByLibrary.simpleMessage(
      "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.",
    ),
    "pricayPoliceLinksTitle": MessageLookupByLibrary.simpleMessage(
      "Links to Other Sites",
    ),
    "priceChangeNote": m56,
    "privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
    "privacyPolice": MessageLookupByLibrary.simpleMessage("Privacy Police"),
    "privacyPoliceAnalytics": MessageLookupByLibrary.simpleMessage(
      "To understand where the app gets in the way and why people stop using it, I collect usage events: which screens you open, which actions you complete, which errors you are shown, and technical attributes such as app version, language and device type.\nThese events describe behaviour, never content. They never carry the amounts you record, the names of your clients, your e-mail address, or any free text you type — the app strips those before anything is sent.\nThis is based on my legitimate interest in improving the Service, and you can object to it at any time in Menu > Privacy.\nProcessors: Google Firebase Analytics (Google LLC) and PostHog (PostHog, Inc.), whose data for this app is hosted in the European Union.",
    ),
    "privacyPoliceAnalyticsTitle": MessageLookupByLibrary.simpleMessage(
      "Usage Analytics",
    ),
    "privacyPoliceChanges": MessageLookupByLibrary.simpleMessage(
      "I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.\nThis policy is effective as of 2026-08-20.",
    ),
    "privacyPoliceChangesTitle": MessageLookupByLibrary.simpleMessage(
      "Changes to This Privacy Policy",
    ),
    "privacyPoliceChildren": MessageLookupByLibrary.simpleMessage(
      "These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.",
    ),
    "privacyPoliceChildrenTitle": MessageLookupByLibrary.simpleMessage(
      "Children’s Privacy",
    ),
    "privacyPoliceContact": MessageLookupByLibrary.simpleMessage(
      "If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at ",
    ),
    "privacyPoliceContactTitle": MessageLookupByLibrary.simpleMessage(
      "Contact Us",
    ),
    "privacyPoliceCookies": MessageLookupByLibrary.simpleMessage(
      "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device\'s internal memory.\nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.",
    ),
    "privacyPoliceCookiesTitle": MessageLookupByLibrary.simpleMessage(
      "Cookies",
    ),
    "privacyPoliceEnd": MessageLookupByLibrary.simpleMessage(
      "This privacy policy page was created at privacypolicytemplate.net and modified/generated by App Privacy Policy Generator",
    ),
    "privacyPoliceInformation": MessageLookupByLibrary.simpleMessage(
      "For a better experience, while using our Service, I may require you to provide certain personally identifiable information, including but not limited to your name and e-mail address, which come from the Google account you sign in with. That information, together with the services, clients and settings you register, is stored in your account so it is available on every device you sign in from.\nThe app also uses third-party services that may collect information used to identify you.\nLink to the privacy policy of third-party service providers used by the app:\n",
    ),
    "privacyPoliceInformation1": MessageLookupByLibrary.simpleMessage(
      "Google Play Services",
    ),
    "privacyPoliceInformation2": MessageLookupByLibrary.simpleMessage("AdMob"),
    "privacyPoliceInformation3": MessageLookupByLibrary.simpleMessage(
      "Google Analytics",
    ),
    "privacyPoliceInformation4": MessageLookupByLibrary.simpleMessage(
      "Firebase Crashlytics",
    ),
    "privacyPoliceInformation5": MessageLookupByLibrary.simpleMessage(
      "RevenueCat",
    ),
    "privacyPoliceInformation6": MessageLookupByLibrary.simpleMessage(
      "PostHog",
    ),
    "privacyPoliceInformationTitle": MessageLookupByLibrary.simpleMessage(
      "Information Collection and Use",
    ),
    "privacyPoliceLogData": MessageLookupByLibrary.simpleMessage(
      "I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.",
    ),
    "privacyPoliceLogDataTitle": MessageLookupByLibrary.simpleMessage(
      "Log Data",
    ),
    "privacyPoliceReplay": MessageLookupByLibrary.simpleMessage(
      "With your explicit permission, and only then, the app may record a session as a series of screenshots, so I can see where people get stuck.\nEvery text and every image is masked on your device before anything is sent. What is stored shows layout, taps and scrolling — not what is written on the screen.\nRecording is never on by default. You are asked once, and you can withdraw permission at any time in Menu > Privacy, which stops it immediately. Not every session is recorded: a sample is, plus sessions where the app detects that something went wrong.",
    ),
    "privacyPoliceReplayTitle": MessageLookupByLibrary.simpleMessage(
      "Session Recording",
    ),
    "privacyPoliceRetention": MessageLookupByLibrary.simpleMessage(
      "Your services, clients and settings are kept for as long as your account exists, and are deleted when you ask for the account to be deleted.\nUsage events and session recordings are kept for a limited period by the analytics providers and are deleted automatically afterwards. Crash reports are kept for up to 90 days.",
    ),
    "privacyPoliceRetentionTitle": MessageLookupByLibrary.simpleMessage(
      "Data Retention",
    ),
    "privacyPoliceRights": MessageLookupByLibrary.simpleMessage(
      "Under Brazil\'s General Data Protection Law (LGPD, Law 13.709/2018) and equivalent legislation, you have the right to confirm that your data is processed, to access it, to correct it, to request its anonymisation, blocking or deletion, to request portability, to know who it is shared with, and to object to processing based on legitimate interest.\nThe two switches in Menu > Privacy let you exercise the right to object directly in the app, without asking anyone. For anything else, write to me at the address below and I will respond.",
    ),
    "privacyPoliceRightsTitle": MessageLookupByLibrary.simpleMessage(
      "Your Rights",
    ),
    "privacyPoliceSecurity": MessageLookupByLibrary.simpleMessage(
      "I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.",
    ),
    "privacyPoliceSecurityTitle": MessageLookupByLibrary.simpleMessage(
      "Security",
    ),
    "privacyPoliceServices": MessageLookupByLibrary.simpleMessage(
      "I may employ third-party companies and individuals due to the following reasons:\n\nTo facilitate our Service;\nTo provide the Service on our behalf;\nTo perform Service-related services; or\nTo assist us in analyzing how our Service is used.\nI want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.",
    ),
    "privacyPoliceServicesTitle": MessageLookupByLibrary.simpleMessage(
      "Service Providers",
    ),
    "privacyPoliceStart": MessageLookupByLibrary.simpleMessage(
      "Lucas Guimarães built the Kazi app as an Ad Supported app. This SERVICE is provided by Lucas Guimarães at no cost and is intended for use as is.\nThis page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.\nIf you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Kazi unless otherwise defined in this Privacy Policy.",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy policy"),
    "privacySessionRecording": MessageLookupByLibrary.simpleMessage(
      "Session recording",
    ),
    "privacySessionRecordingDescription": MessageLookupByLibrary.simpleMessage(
      "Records a masked replay of some sessions. Every text and image is hidden.",
    ),
    "privacyUsageData": MessageLookupByLibrary.simpleMessage(
      "Help improve Kazi",
    ),
    "privacyUsageDataDescription": MessageLookupByLibrary.simpleMessage(
      "Sends anonymous usage events so we can find what is not working. Never your amounts or your clients.",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "quantity": MessageLookupByLibrary.simpleMessage("Quantity"),
    "quantityHint": MessageLookupByLibrary.simpleMessage(
      "How many times the service was performed",
    ),
    "rateApp": MessageLookupByLibrary.simpleMessage("Rate the app"),
    "ratesUnavailable": MessageLookupByLibrary.simpleMessage(
      "Exchange rates unavailable",
    ),
    "ratesUnavailableDescription": MessageLookupByLibrary.simpleMessage(
      "Connect to the internet to see your totals converted.",
    ),
    "received": MessageLookupByLibrary.simpleMessage("Received"),
    "receivedOn": m57,
    "receivedPlural": MessageLookupByLibrary.simpleMessage("Received"),
    "registerService": MessageLookupByLibrary.simpleMessage("Register service"),
    "removeFilters": MessageLookupByLibrary.simpleMessage("Remove filters"),
    "replayConsentAccept": MessageLookupByLibrary.simpleMessage(
      "Allow recording",
    ),
    "replayConsentBody": MessageLookupByLibrary.simpleMessage(
      "We record taps and screens to find where Kazi gets in your way. Amounts, client names and anything you type are hidden from the recording.\n\nYou can turn it off anytime, in Menu > Session recording.",
    ),
    "replayConsentDecline": MessageLookupByLibrary.simpleMessage("Not now"),
    "replayConsentLearnMore": MessageLookupByLibrary.simpleMessage(
      "How this is used",
    ),
    "replayConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Can we record how you use the app?",
    ),
    "requiredProperty": m58,
    "resendEmail": MessageLookupByLibrary.simpleMessage("Resend Email"),
    "resetedPassword": MessageLookupByLibrary.simpleMessage(
      "Password reseted successfully",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Restore"),
    "restoredSnackbar": m59,
    "role": MessageLookupByLibrary.simpleMessage("Role"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saving": MessageLookupByLibrary.simpleMessage("Saving…"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchByName": MessageLookupByLibrary.simpleMessage("Search by name"),
    "searchClientsHint": MessageLookupByLibrary.simpleMessage("Search by name"),
    "searchIgnoresPeriod": MessageLookupByLibrary.simpleMessage(
      "Search ignores the period: it looks through everything you have registered.",
    ),
    "searchServiceTypeHint": MessageLookupByLibrary.simpleMessage(
      "Search a type",
    ),
    "searchServicesFound": m60,
    "searchServicesHint": MessageLookupByLibrary.simpleMessage(
      "Type, client or note",
    ),
    "seeInList": MessageLookupByLibrary.simpleMessage("See in the list"),
    "seeInSummary": MessageLookupByLibrary.simpleMessage("See in the summary"),
    "seeNServices": m61,
    "seeSummaryOf": m62,
    "seeTheServices": m63,
    "selectCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Select the service",
    ),
    "selectClient": MessageLookupByLibrary.simpleMessage("Select the client"),
    "selectCurrency": MessageLookupByLibrary.simpleMessage("Select a currency"),
    "sendEmail": MessageLookupByLibrary.simpleMessage("Send Email"),
    "service": MessageLookupByLibrary.simpleMessage("Service"),
    "serviceAdded": MessageLookupByLibrary.simpleMessage(
      "Service added successfully",
    ),
    "serviceCatalog": MessageLookupByLibrary.simpleMessage("Service catalog"),
    "serviceCurrencyHint": MessageLookupByLibrary.simpleMessage(
      "The currency the service was charged in",
    ),
    "serviceDeleted": MessageLookupByLibrary.simpleMessage(
      "Service deleted successfully",
    ),
    "serviceType": MessageLookupByLibrary.simpleMessage("Service type"),
    "serviceUpdated": MessageLookupByLibrary.simpleMessage(
      "Service updated successfully",
    ),
    "serviceValue": MessageLookupByLibrary.simpleMessage("Service Value"),
    "services": MessageLookupByLibrary.simpleMessage("Services"),
    "servicesCount": m64,
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "setupCatalogAddAnother": MessageLookupByLibrary.simpleMessage(
      "Add another service",
    ),
    "setupCatalogBlankPrice": MessageLookupByLibrary.simpleMessage(
      "Do not know the price? Leave it blank — Kazi asks when you register.",
    ),
    "setupCatalogContinueWith": m65,
    "setupCatalogDuplicate": MessageLookupByLibrary.simpleMessage(
      "You already have a service with this name.",
    ),
    "setupCatalogSubtitle": MessageLookupByLibrary.simpleMessage(
      "Untick anything you do not do, and tap the price to set your own.",
    ),
    "setupCatalogTitle": MessageLookupByLibrary.simpleMessage(
      "Are these the services you offer?",
    ),
    "setupCatalogTypedSubtitle": MessageLookupByLibrary.simpleMessage(
      "Start with the most common one. You can add as many as you want later.",
    ),
    "setupCatalogTypedTitle": MessageLookupByLibrary.simpleMessage(
      "Which services do you offer?",
    ),
    "setupCatalogYourPrices": MessageLookupByLibrary.simpleMessage(
      "Your prices",
    ),
    "setupCommissionPerItem": MessageLookupByLibrary.simpleMessage(
      "Tap a service to change just that one.",
    ),
    "setupCommissionSubtitle": MessageLookupByLibrary.simpleMessage(
      "It is the salon\'s commission. If you work for yourself, choose 100%.",
    ),
    "setupCommissionTitle": MessageLookupByLibrary.simpleMessage(
      "How much of each service do you keep?",
    ),
    "setupContinue": MessageLookupByLibrary.simpleMessage("Continue"),
    "setupCycleMonthlyDetail": m66,
    "setupCycleSubtitle": MessageLookupByLibrary.simpleMessage(
      "Kazi adds up your earnings within that period.",
    ),
    "setupCycleTitle": MessageLookupByLibrary.simpleMessage(
      "When do you get paid?",
    ),
    "setupEmployed": MessageLookupByLibrary.simpleMessage(
      "I work for a salon or company",
    ),
    "setupEmployedDetail": MessageLookupByLibrary.simpleMessage(
      "I get a commission",
    ),
    "setupExitMessage": MessageLookupByLibrary.simpleMessage(
      "What you have answered is saved. You can pick it up from the home screen.",
    ),
    "setupExitTitle": MessageLookupByLibrary.simpleMessage("Leave the setup?"),
    "setupFirstServiceOtherDay": MessageLookupByLibrary.simpleMessage(
      "Another day",
    ),
    "setupFirstServicePastCycle": MessageLookupByLibrary.simpleMessage(
      "This service goes into the previous cycle.",
    ),
    "setupFirstServiceRegister": MessageLookupByLibrary.simpleMessage(
      "Register",
    ),
    "setupFirstServiceSkip": MessageLookupByLibrary.simpleMessage(
      "I have not worked yet — I will do this later",
    ),
    "setupFirstServiceSubtitle": MessageLookupByLibrary.simpleMessage(
      "It can be today\'s. It takes 10 seconds.",
    ),
    "setupFirstServiceTitle": MessageLookupByLibrary.simpleMessage(
      "Let\'s record a service you have already done.",
    ),
    "setupFirstServiceWhen": MessageLookupByLibrary.simpleMessage(
      "When was it?",
    ),
    "setupPriceSheetKeep": MessageLookupByLibrary.simpleMessage(
      "What you keep",
    ),
    "setupPriceSheetName": MessageLookupByLibrary.simpleMessage("Service name"),
    "setupPriceSheetValue": MessageLookupByLibrary.simpleMessage(
      "What you charge",
    ),
    "setupProfessionField": MessageLookupByLibrary.simpleMessage("Profession"),
    "setupProfessionNoMatch": MessageLookupByLibrary.simpleMessage(
      "Did not find it? Just keep writing.",
    ),
    "setupProfessionSubtitle": MessageLookupByLibrary.simpleMessage(
      "That way Kazi starts out with your services already set up.",
    ),
    "setupProfessionTitle": MessageLookupByLibrary.simpleMessage(
      "Before we start, tell me what you do.",
    ),
    "setupProfessionTypedSubtitle": MessageLookupByLibrary.simpleMessage(
      "Write it your way. If I know it, I will bring a ready-made list.",
    ),
    "setupProfessionTypedTitle": MessageLookupByLibrary.simpleMessage(
      "What do you do?",
    ),
    "setupResultBreakdown": m67,
    "setupResultCta": MessageLookupByLibrary.simpleMessage("See my Kazi"),
    "setupResultLabel": MessageLookupByLibrary.simpleMessage(
      "Service registered",
    ),
    "setupResultReadySubtitle": MessageLookupByLibrary.simpleMessage(
      "As soon as you finish a job, tap the K in the middle of the bar.",
    ),
    "setupResultReadyTitle": MessageLookupByLibrary.simpleMessage(
      "Your Kazi is ready.",
    ),
    "setupResultYours": MessageLookupByLibrary.simpleMessage("is yours"),
    "setupSelfEmployed": MessageLookupByLibrary.simpleMessage(
      "I work for myself",
    ),
    "setupSelfEmployedDetail": MessageLookupByLibrary.simpleMessage(
      "I keep 100%",
    ),
    "setupUnknownProfessionSubtitle": MessageLookupByLibrary.simpleMessage(
      "No problem — Kazi learns it from you in a minute. First: how do you get paid?",
    ),
    "setupUnknownProfessionTitle": MessageLookupByLibrary.simpleMessage(
      "I do not know that work yet.",
    ),
    "share": MessageLookupByLibrary.simpleMessage("Share"),
    "showAllTypes": m68,
    "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
    "signOut": MessageLookupByLibrary.simpleMessage("Sign out of account"),
    "signOutConfirm": MessageLookupByLibrary.simpleMessage("Sign out"),
    "signOutConfirmation": MessageLookupByLibrary.simpleMessage(
      "Your services stay saved. To see them again, just sign in with the same account.",
    ),
    "signOutTitle": MessageLookupByLibrary.simpleMessage(
      "Sign out of account?",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "signUpSuccess": MessageLookupByLibrary.simpleMessage(
      "Account created successfully",
    ),
    "situation": MessageLookupByLibrary.simpleMessage("Status"),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "splashSignature": MessageLookupByLibrary.simpleMessage("kazi · work"),
    "statusPending": MessageLookupByLibrary.simpleMessage("Pending"),
    "success": MessageLookupByLibrary.simpleMessage("Action done successfully"),
    "summary": MessageLookupByLibrary.simpleMessage("Summary"),
    "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeChangeNote": MessageLookupByLibrary.simpleMessage(
      "The change is immediate and applies to the whole app. The sheet stays open so you can compare.",
    ),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "themeSystemDetail": MessageLookupByLibrary.simpleMessage(
      "follows the device",
    ),
    "thisCatalogItem": MessageLookupByLibrary.simpleMessage("this service"),
    "thisClient": MessageLookupByLibrary.simpleMessage("this client"),
    "thisService": MessageLookupByLibrary.simpleMessage("this service"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "todaySection": m69,
    "todaysServices": MessageLookupByLibrary.simpleMessage("Today\'s services"),
    "topClients": MessageLookupByLibrary.simpleMessage(
      "Clients who earned the most",
    ),
    "total": MessageLookupByLibrary.simpleMessage("Total value"),
    "tourAppBarDescription": MessageLookupByLibrary.simpleMessage(
      "Here you build your service catalog and log out of your account.",
    ),
    "tourAppBarTitle": MessageLookupByLibrary.simpleMessage("Perfil Area"),
    "tourBottomNavigationServicesDescription": MessageLookupByLibrary.simpleMessage(
      "In this menu you will find all the services you have performed, and also being able to register a new service.",
    ),
    "tourBottomNavigationServicesTitle": MessageLookupByLibrary.simpleMessage(
      "Services Area",
    ),
    "tourCatalogItemsDescription": MessageLookupByLibrary.simpleMessage(
      "Name the service, such as \"Lashes - Brazilian Volume\", and fill in its default price and the commission you receive for it.",
    ),
    "tourCatalogItemsTitle": MessageLookupByLibrary.simpleMessage("Catalog"),
    "tourHomeBalanceDescription": MessageLookupByLibrary.simpleMessage(
      "Here your daily earnings are displayed, also the total discount and the total received.",
    ),
    "tourHomeBalanceTitle": MessageLookupByLibrary.simpleMessage("Balance"),
    "tourHomeServicesDescription": MessageLookupByLibrary.simpleMessage(
      "These are the services you performed today.",
    ),
    "tourHomeServicesTitle": MessageLookupByLibrary.simpleMessage(
      "Daily Services",
    ),
    "tourProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Here you build your catalog: the services you offer, with price and commission ready for every entry.",
    ),
    "tourProfileTitle": MessageLookupByLibrary.simpleMessage("Actions"),
    "tourServiceDetailsDescription": MessageLookupByLibrary.simpleMessage(
      "You can click in the services to see all the information, update or delete it.",
    ),
    "tourServiceDetailsTitle": MessageLookupByLibrary.simpleMessage(
      "Service Details",
    ),
    "tourServicesForm1Description": MessageLookupByLibrary.simpleMessage(
      "Pick a service from your catalog and the amounts come filled in. You can adjust them for this entry alone.",
    ),
    "tourServicesForm1Title": MessageLookupByLibrary.simpleMessage(
      "New Service",
    ),
    "tourServicesForm2Description": MessageLookupByLibrary.simpleMessage(
      "Just select the date and the number of services performed, and fill in a description or note if you wish.",
    ),
    "tourServicesForm2Title": MessageLookupByLibrary.simpleMessage(
      "New Service",
    ),
    "tourServicesInfoDescription": MessageLookupByLibrary.simpleMessage(
      "Here you can filter and sort your services and view the balance for the selected period. You can also register performed services.",
    ),
    "tourServicesInfoTitle": MessageLookupByLibrary.simpleMessage("Services"),
    "tourServicesListDescription": MessageLookupByLibrary.simpleMessage(
      "These are all the jobs you\'ve provided in a given period of time. By default you will see all the services for the current month.",
    ),
    "tourServicesListTitle": MessageLookupByLibrary.simpleMessage("Services"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
    "understood": MessageLookupByLibrary.simpleMessage("Got it"),
    "undo": MessageLookupByLibrary.simpleMessage("Undo"),
    "unmarkAsReceived": MessageLookupByLibrary.simpleMessage(
      "Mark as not received",
    ),
    "updateLater": MessageLookupByLibrary.simpleMessage("Later"),
    "updateNow": MessageLookupByLibrary.simpleMessage("Update"),
    "updatePassword": MessageLookupByLibrary.simpleMessage("Update Password"),
    "useExistingClient": m70,
    "usedIn": MessageLookupByLibrary.simpleMessage("Used in"),
    "usedInServices": m71,
    "userTermsAlert1": MessageLookupByLibrary.simpleMessage(
      "By continuing, you agree to the ",
    ),
    "userTermsAlert2": MessageLookupByLibrary.simpleMessage(
      "Terms of Service ",
    ),
    "userTermsAlert3": MessageLookupByLibrary.simpleMessage(
      "and confirm that you have read our ",
    ),
    "userTermsAlert4": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "usesCount": m72,
    "validatorConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Passwords don\'t match",
    ),
    "validatorEmail": MessageLookupByLibrary.simpleMessage(
      "Email is invalid or badly formatted",
    ),
    "validatorPassword": MessageLookupByLibrary.simpleMessage(
      "Your password must have a minimum of 8 characters and a maximum of 16",
    ),
    "viewArchived": m73,
    "week": MessageLookupByLibrary.simpleMessage("7 days"),
    "whatWasDone": MessageLookupByLibrary.simpleMessage("What was done"),
    "whatsNewSubtitle": MessageLookupByLibrary.simpleMessage(
      "Three things, written by us — not discovered in the middle of a job.",
    ),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("What changed"),
    "whatsNewVersion": m74,
    "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "whoWasServed": MessageLookupByLibrary.simpleMessage("Who you served"),
    "withoutCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Not in the catalog",
    ),
    "withoutCommission": MessageLookupByLibrary.simpleMessage("no commission"),
    "wouldYouLikeDelete": m75,
    "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "youKeep": MessageLookupByLibrary.simpleMessage("You keep"),
    "yourEarnings": MessageLookupByLibrary.simpleMessage("Your earnings"),
    "yourEarningsAmount": m76,
    "yoursFromThis": m77,
  };
}
