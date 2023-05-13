import 'package:flutter/widgets.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/models/service_type.dart';
import 'package:my_services/app/services/services_service/local/local_services_service.dart';
import 'package:my_services/app/services/time_service/local/local_time_service.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/utils/base_state.dart';
import 'package:my_services/app/views/home/home.dart';
import 'package:my_services/app/views/services/services.dart';

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

  static List<GlobalKey> get stepList => [
        AppOnboarding.stepOne,
        AppOnboarding.stepTwo,
        AppOnboarding.stepThree,
        AppOnboarding.stepFour,
        AppOnboarding.stepFive,
        AppOnboarding.stepSix,
        AppOnboarding.stepSeven,
        AppOnboarding.stepEight,
        AppOnboarding.stepNine,
        AppOnboarding.stepTen,
        AppOnboarding.stepEleven,
      ];

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
}
