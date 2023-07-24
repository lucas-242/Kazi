// Mocks generated by Mockito 5.4.2 from annotations
// in kazi/test/lib/app/views/services_type/service_types_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:kazi/app/models/app_user.dart' as _i9;
import 'package:kazi/app/models/service.dart' as _i7;
import 'package:kazi/app/models/service_type.dart' as _i4;
import 'package:kazi/app/repositories/service_type_repository/service_type_repository.dart'
    as _i2;
import 'package:kazi/app/repositories/services_repository/services_repository.dart'
    as _i6;
import 'package:kazi/app/services/auth_service/auth_service.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ServiceTypeRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockServiceTypeRepository extends _i1.Mock
    implements _i2.ServiceTypeRepository {
  MockServiceTypeRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.ServiceType> add(_i4.ServiceType? serviceType) =>
      (super.noSuchMethod(
        Invocation.method(
          #add,
          [serviceType],
        ),
        returnValue:
            _i3.Future<_i4.ServiceType>.value(_i5.dummyValue<_i4.ServiceType>(
          this,
          Invocation.method(
            #add,
            [serviceType],
          ),
        )),
      ) as _i3.Future<_i4.ServiceType>);
  @override
  _i3.Future<void> delete(String? id) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<List<_i4.ServiceType>> get(String? userId) => (super.noSuchMethod(
        Invocation.method(
          #get,
          [userId],
        ),
        returnValue:
            _i3.Future<List<_i4.ServiceType>>.value(<_i4.ServiceType>[]),
      ) as _i3.Future<List<_i4.ServiceType>>);
  @override
  _i3.Future<void> update(_i4.ServiceType? serviceType) => (super.noSuchMethod(
        Invocation.method(
          #update,
          [serviceType],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [ServicesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockServicesRepository extends _i1.Mock
    implements _i6.ServicesRepository {
  MockServicesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i7.Service>> add(
    _i7.Service? service, [
    int? quantity = 1,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #add,
          [
            service,
            quantity,
          ],
        ),
        returnValue: _i3.Future<List<_i7.Service>>.value(<_i7.Service>[]),
      ) as _i3.Future<List<_i7.Service>>);
  @override
  _i3.Future<void> delete(String? id) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<List<_i7.Service>> get(
    String? userId,
    DateTime? startDate, [
    DateTime? endDate,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [
            userId,
            startDate,
            endDate,
          ],
        ),
        returnValue: _i3.Future<List<_i7.Service>>.value(<_i7.Service>[]),
      ) as _i3.Future<List<_i7.Service>>);
  @override
  _i3.Future<void> update(_i7.Service? service) => (super.noSuchMethod(
        Invocation.method(
          #update,
          [service],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<int> count(
    String? userId, [
    String? typeId,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #count,
          [
            userId,
            typeId,
          ],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i8.AuthService {
  MockAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set user(_i9.AppUser? _user) => super.noSuchMethod(
        Invocation.setter(
          #user,
          _user,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.Future<bool> signInWithPassword() => (super.noSuchMethod(
        Invocation.method(
          #signInWithPassword,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<bool> signInWithGoogle() => (super.noSuchMethod(
        Invocation.method(
          #signInWithGoogle,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<void> signOut() => (super.noSuchMethod(
        Invocation.method(
          #signOut,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Stream<_i9.AppUser?> userChanges() => (super.noSuchMethod(
        Invocation.method(
          #userChanges,
          [],
        ),
        returnValue: _i3.Stream<_i9.AppUser?>.empty(),
      ) as _i3.Stream<_i9.AppUser?>);
}
