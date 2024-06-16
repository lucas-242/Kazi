import 'package:flutter/material.dart';
import 'package:kazi/core/constants/app_keys.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/domain/services/local_storage.dart';
import 'package:kazi/infra/services/local_services_service.dart';
import 'package:kazi/infra/services/local_time_service.dart';
import 'package:kazi/presenter/home/home.dart';
import 'package:kazi/presenter/services/services.dart';
import 'package:kazi/service_locator.dart';
import 'package:kazi_core/kazi_core.dart';

abstract class AppOnboarding {
  static final stepOne = GlobalKey(debugLabel: 'Onboarding step 1');
  static final stepTwo = GlobalKey(debugLabel: 'Onboarding step 2');
  static final stepThree = GlobalKey(debugLabel: 'Onboarding step 3');
  static final stepFour = GlobalKey(debugLabel: 'Onboarding step 4');
  static final stepFive = GlobalKey(debugLabel: 'Onboarding step 5');
  static final stepSix = GlobalKey(debugLabel: 'Onboarding step 6');
  static final stepSeven = GlobalKey(debugLabel: 'Onboarding step 7');
  static final stepEight = GlobalKey(debugLabel: 'Onboarding step 8');
  static final stepNine = GlobalKey(debugLabel: 'Onboarding step 9');
  static final stepTen = GlobalKey(debugLabel: 'Onboarding step 10');
  static final stepEleven = GlobalKey(debugLabel: 'Onboarding step 11');
  static final stepTwelve = GlobalKey(debugLabel: 'Onboarding step 12');
  static final stepThirteen = GlobalKey(debugLabel: 'Onboarding step 13');

  static final _defaultServiceType = ServiceType.toCreate(
    userId: 1,
    name: AppLocalizations.current.clipperCut,
    defaultValue: 30,
    discountPercent: 5,
  );
  static final _defaultService = Service.toCreate(
    employeeId: 1,
    value: 30,
    discountPercent: 5,
    serviceType: _defaultServiceType,
  );

  static final _defaultService2 = _defaultService.copyWith(
    serviceType: _defaultServiceType.copyWith(
      defaultValue: 20,
      name: AppLocalizations.current.clipperCut,
    ),
  );

  static final homeState = HomeState(
    status: BaseStateStatus.success,
    services: [
      _defaultService,
      _defaultService2,
      _defaultService,
      _defaultService,
    ],
  );

  static final servicesState = ServiceLandingState(
    status: BaseStateStatus.success,
    startDate: LocalServicesService(LocalTimeService()).now,
    endDate: LocalServicesService(LocalTimeService()).now,
    services: [
      _defaultService,
      _defaultService2,
      _defaultService,
      _defaultService,
    ],
  );

  //Removing guided onboarding due to package issues
  // static final instance = TutorialCoachMark(
  //   targets: [
  //     _targetOne(),
  //     _targetOne1(),
  //     _targetOne2(),
  //     _targetTwo(),
  //     _targetThree(),
  //     _targetFour(),
  //     _targetFive(),
  //     _targetSix(),
  //     _targetSeven(),
  //     _targetEight(),
  //     _targetNine(),
  //     _targetTen(),
  //     _targetEleven(),
  //   ],
  //   textSkip: AppLocalizations.current.skip,
  //   pulseEnable: false,
  //   opacityShadow: 0.6,
  //   skipWidget: KaziPillButton(
  //     onTap: null,
  //     child: Text(AppLocalizations.current.skip),
  //   ),
  //   onFinish: () {
  //     print('finish');
  //   },
  //   onClickTarget: (target) {
  //     print('onClickTarget: $target');
  //   },
  //   onClickTargetWithTapPosition: (target, tapDetails) {
  //     print('target: $target');
  //     print(
  //         'clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}');
  //   },
  //   onClickOverlay: (target) {
  //     print('onClickOverlay: $target');
  //   },
  //   onSkip: () {
  //     print('skip');
  //   },
  // );

  // static TargetFocus _targetOne() => TargetFocus(
  //       identify: 'stepOne',
  //       keyTarget: AppOnboarding.stepOne,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           padding: const EdgeInsets.only(top: 75),
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourHomeBalanceTitle,
  //             description: AppLocalizations.current.tourHomeBalanceDescription,
  //             currentPage: 1,
  //             onNextCallback: controller.next,
  //             onPreviousCallback: controller.previous,
  //           ),
  //         ),
  //       ],
  //     );

  // static TargetFocus _targetOne1() => TargetFocus(
  //       identify: 'stepOne1',
  //       keyTarget: AppOnboarding.stepTwo,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourHomeBalanceTitle,
  //             description: AppLocalizations.current.tourHomeBalanceDescription,
  //             currentPage: 2,
  //             onNextCallback: controller.next,
  //             onPreviousCallback: controller.previous,
  //           ),
  //         ),
  //       ],
  //     );

  // static TargetFocus _targetOne2() => TargetFocus(
  //       identify: 'stepOne2',
  //       keyTarget: AppOnboarding.stepThree,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           align: ContentAlign.top,
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourHomeBalanceTitle,
  //             description: AppLocalizations.current.tourHomeBalanceDescription,
  //             currentPage: 3,
  //             onNextCallback: controller.next,
  //             onPreviousCallback: controller.previous,
  //           ),
  //         ),
  //       ],
  //     );

  // static TargetFocus _targetTwo() => TargetFocus(
  //       identify: 'stepTwo',
  //       keyTarget: AppOnboarding.stepFour,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           align: ContentAlign.top,
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourHomeServicesTitle,
  //             description: AppLocalizations.current.tourHomeServicesDescription,
  //             currentPage: 4,
  //             onNextCallback: controller.next,
  //             onPreviousCallback: controller.previous,
  //           ),
  //         ),
  //       ],
  //     );

  // static TargetFocus _targetThree() => TargetFocus(
  //       identify: 'stepThree',
  //       keyTarget: AppOnboarding.stepFive,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourAppBarTitle,
  //             description: AppLocalizations.current.tourAppBarDescription,
  //             currentPage: 5,
  //             onNextCallback: () {
  //               controller.next();
  //               context.go(AppRouter.profile);
  //             },
  //             onPreviousCallback: controller.previous,
  //           ),
  //         ),
  //       ],
  //     );

  // static TargetFocus _targetFour() => TargetFocus(
  //       identify: 'stepFour',
  //       keyTarget: AppOnboarding.stepSix,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourProfileTitle,
  //             description: AppLocalizations.current.tourProfileDescription,
  //             currentPage: 6,
  //             onNextCallback: () {
  //               controller.next();
  //               context.read<AppCubit>().changeToAddServicePage();
  //               context.go(AppRouter.addServiceType);
  //             },
  //             onPreviousCallback: () {
  //               controller.previous();
  //               context.go(AppRouter.home);
  //             },
  //           ),
  //         ),
  //       ],
  //     );

  // static TargetFocus _targetFive() => TargetFocus(
  //       identify: 'stepFive',
  //       keyTarget: AppOnboarding.stepSeven,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourServiceTypesTitle,
  //             description: AppLocalizations.current.tourServiceTypesDescription,
  //             currentPage: 7,
  //             onNextCallback: controller.next,
  //             onPreviousCallback: () {
  //               controller.previous();
  //               context.go(AppRouter.profile);
  //             },
  //           ),
  //         ),
  //       ],
  //     );

  // static TargetFocus _targetSix() => TargetFocus(
  //       identify: 'stepSix',
  //       keyTarget: AppOnboarding.stepEight,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           align: ContentAlign.top,
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourBottomNavigationServicesTitle,
  //             description: AppLocalizations
  //                 .current.tourBottomNavigationServicesDescription,
  //             currentPage: 8,
  //             onNextCallback: () {
  //               controller.next();
  //               context.read<AppCubit>().changePage(1);
  //               context.go(AppRouter.services);
  //             },
  //             onPreviousCallback: () {
  //               controller.previous();
  //               context.go(AppRouter.profile);
  //             },
  //           ),
  //         ),
  //       ],
  //     );

  // static TargetFocus _targetSeven() => TargetFocus(
  //       identify: 'stepSeven',
  //       keyTarget: AppOnboarding.stepNine,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           align: ContentAlign.top,
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourServicesListTitle,
  //             description: AppLocalizations.current.tourServicesListDescription,
  //             currentPage: 9,
  //             onNextCallback: controller.next,
  //             onPreviousCallback: () {
  //               controller.previous();
  //               context.go(AppRouter.addServiceType);
  //             },
  //           ),
  //         ),
  //       ],
  //     );

  // static TargetFocus _targetEight() => TargetFocus(
  //       identify: 'stepEight',
  //       keyTarget: AppOnboarding.stepTen,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourServicesInfoTitle,
  //             description: AppLocalizations.current.tourServicesInfoDescription,
  //             currentPage: 10,
  //             onNextCallback: controller.next,
  //             onPreviousCallback: controller.previous,
  //           ),
  //         ),
  //       ],
  //     );

  // static TargetFocus _targetNine() => TargetFocus(
  //       identify: 'stepNine',
  //       keyTarget: AppOnboarding.stepEleven,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourServiceDetailsTitle,
  //             description:
  //                 AppLocalizations.current.tourServiceDetailsDescription,
  //             currentPage: 11,
  //             onNextCallback: () {
  //               controller.next();
  //               context.read<AppCubit>().changeToAddServicePage();
  //               context.go(AppRouter.addServices);
  //             },
  //             onPreviousCallback: controller.previous,
  //           ),
  //         ),
  //       ],
  //     );

  // static TargetFocus _targetTen() => TargetFocus(
  //       identify: 'stepTen',
  //       keyTarget: AppOnboarding.stepTwelve,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourServicesForm1Title,
  //             description:
  //                 AppLocalizations.current.tourServicesForm1Description,
  //             currentPage: 12,
  //             onNextCallback: controller.next,
  //             onPreviousCallback: () {
  //               controller.previous();
  //               context.go(AppRouter.services);
  //             },
  //           ),
  //         ),
  //       ],
  //     );

  // static TargetFocus _targetEleven() => TargetFocus(
  //       identify: 'stepEleven',
  //       keyTarget: AppOnboarding.stepThirteen,
  //       enableTargetTab: false,
  //       shape: ShapeLightFocus.RRect,
  //       radius: 18,
  //       alignSkip: Alignment.topRight,
  //       contents: [
  //         TargetContent(
  //           align: ContentAlign.top,
  //           builder: (context, controller) => OnboardingTooltip(
  //             title: AppLocalizations.current.tourServicesForm2Title,
  //             description:
  //                 AppLocalizations.current.tourServicesForm2Description,
  //             currentPage: 13,
  //             onNextCallback: () {
  //               controller.next();
  //               _onCompleteOnboarding(context);
  //             },
  //             onPreviousCallback: controller.previous,
  //           ),
  //         ),
  //       ],
  //     );

  static Future<void> onCompleteOnboarding(BuildContext context) async =>
      _completeOnboarding();

  // static Future<void> _onCompleteOnboarding(BuildContext context) async {
  //   await _completeOnboarding();
  //   _cleanForm(context);
  //   _updateBottomNavigator(context);
  //   //* There is an error using navigator if go method is called directly
  //   context
  //     ..pop()
  //     ..go(AppRouter.home);
  // }

  static Future<void> _completeOnboarding() async =>
      ServiceLocator.get<LocalStorage>()
          .set<bool>(AppKeys.showOnboardingStorage, false);

  // static void _cleanForm(BuildContext context) {
  //   final formCubit = context.read<ServiceFormCubit>();
  //   formCubit.cleanState();
  // }

  // static void _updateBottomNavigator(BuildContext context) {
  //   final appCubit = context.read<AppCubit>();
  //   appCubit.changePage(0);
  // }
}
