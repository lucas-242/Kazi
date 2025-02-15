import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:kazi/app/shared/errors/errors.dart';

class ErrorWithMessage<T extends AppError> extends CustomMatcher {

  ErrorWithMessage(this.message)
      : super(
            'Error should be ${T.runtimeType} with message: $message',
            'Error and message',
            throwsA(predicate((e) => e is T && e.message == message)),);
  final String message;
}

class IsTheSameServiceType extends Matcher {

  IsTheSameServiceType(this.compareObject, {this.checkEqualsId = false});
  final ServiceType compareObject;
  final bool checkEqualsId;

  @override
  bool matches(Object? item, Map matchState) {
    final serviceType = item as ServiceType;

    final isEquals = (checkEqualsId
            ? serviceType.id == compareObject.id
            : serviceType.id.isNotEmpty) &&
        serviceType.name == compareObject.name &&
        serviceType.discountPercent == compareObject.discountPercent &&
        serviceType.defaultValue == compareObject.defaultValue &&
        serviceType.userId == compareObject.userId;

    return isEquals;
  }

  @override
  Description describe(Description description) {
    return description.add('ServiceType is equals to another one');
  }
}

class IsTheSameService extends Matcher {

  IsTheSameService(this.compareObject, {this.checkEqualsId = false});
  final Service compareObject;
  final bool checkEqualsId;

  @override
  bool matches(Object? item, Map matchState) {
    final service = item as Service;

    final isEquals = (checkEqualsId
            ? service.id == compareObject.id
            : service.id.isNotEmpty) &&
        service.description == compareObject.description &&
        service.discountPercent == compareObject.discountPercent &&
        service.value == compareObject.value &&
        service.date == compareObject.date &&
        service.typeId == compareObject.typeId &&
        service.userId == compareObject.userId;

    return isEquals;
  }

  @override
  Description describe(Description description) {
    return description.add('Service is equals to another one');
  }
}
