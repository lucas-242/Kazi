import 'package:flutter/widgets.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/models/service_type.dart';
import 'package:my_services/app/shared/utils/base_state.dart';
import 'package:my_services/app/views/home/home.dart';

abstract class AppOnboarding {
  static const totalSteps = 6;

  static final stepOne = GlobalKey();
  static final stepTwo = GlobalKey();
  static final stepThree = GlobalKey();
  static final stepFour = GlobalKey();
  static final stepFive = GlobalKey();
  static final stepSix = GlobalKey();

  static const defaultServiceType = ServiceType(
    userId: 'aaaaa',
    name: 'Corte cabelo',
    defaultValue: 30,
    discountPercent: 5,
  );
  static final defaultService = Service(
    userId: 'aaaaa',
    value: 30,
    discountPercent: 5,
    type: defaultServiceType,
  );

  static final homeState = HomeState(
    status: BaseStateStatus.success,
    services: [
      defaultService,
      defaultService.copyWith(
        type: defaultServiceType.copyWith(
          defaultValue: 20,
          name: 'Corte máquina',
        ),
      ),
      defaultService,
      defaultService,
    ],
  );
}
