import 'package:flutter/material.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:kazi/app/services/services_service/local/local_services_service.dart';
import 'package:kazi/app/services/time_service/local/local_time_service.dart';
import 'package:kazi/app/shared/constants/app_keys.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/utils/base_state.dart';
import 'package:kazi/app/views/home/home.dart';
import 'package:kazi/app/views/services/services.dart';
import 'package:kazi/injector_container.dart';

abstract class AppOnboarding {
  static final stepOne = GlobalKey();
  static final stepTwo = GlobalKey();
  static final stepThree = GlobalKey();
  static final stepFour = GlobalKey();
  static final stepFive = GlobalKey();
  static final stepSix = GlobalKey();
  static final stepSeven = GlobalKey();
  static final stepEight = GlobalKey();
  static final stepNine = GlobalKey();
  static final stepTen = GlobalKey();
  static final stepEleven = GlobalKey();
  static final stepTwelve = GlobalKey();
  static final stepThirteen = GlobalKey();

  static final _defaultServiceType = ServiceType(
    userId: 'aaaaa',
    name: AppLocalizations.current.clipperCut,
    defaultValue: 30,
    discountPercent: 5,
  );
  static final _defaultService = Service(
    userId: 'aaaaa',
    value: 30,
    discountPercent: 5,
    type: _defaultServiceType,
  );

  static final _defaultService2 = _defaultService.copyWith(
    type: _defaultServiceType.copyWith(
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
  //   skipWidget: PillButton(
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

  static Future<void> _completeOnboarding() async => serviceLocator
      .get<LocalStorage>()
      .setBool(AppKeys.showOnboardingStorage, false);

  // static void _cleanForm(BuildContext context) {
  //   final formCubit = context.read<ServiceFormCubit>();
  //   formCubit.cleanState();
  // }

  // static void _updateBottomNavigator(BuildContext context) {
  //   final appCubit = context.read<AppCubit>();
  //   appCubit.changePage(0);
  // }
}
