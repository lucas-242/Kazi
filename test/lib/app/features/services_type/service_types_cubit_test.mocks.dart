// Mocks generated by Mockito 5.4.2 from annotations
// in kazi/test/lib/app/features/services_type/service_types_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:kazi/app/core/auth/auth.dart' as _i7;
import 'package:kazi/app/data/repositories/service_type_repository/service_type_repository.dart'
    as _i3;
import 'package:kazi/app/data/repositories/services_repository/services_repository.dart'
    as _i5;
import 'package:kazi/app/models/app_user.dart' as _i8;
import 'package:kazi/app/models/service.dart' as _i6;
import 'package:kazi/app/models/service_type.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeServiceType_0 extends _i1.SmartFake implements _i2.ServiceType {
  _FakeServiceType_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ServiceTypeRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockServiceTypeRepository extends _i1.Mock
    implements _i3.ServiceTypeRepository {
  MockServiceTypeRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ServiceType> add(_i2.ServiceType? serviceType) =>
      (super.noSuchMethod(
        Invocation.method(
          #add,
          [serviceType],
        ),
        returnValue: _i4.Future<_i2.ServiceType>.value(_FakeServiceType_0(
          this,
          Invocation.method(
            #add,
            [serviceType],
          ),
        )),
      ) as _i4.Future<_i2.ServiceType>);
  @override
  _i4.Future<void> delete(int? id) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<List<_i2.ServiceType>> get() => (super.noSuchMethod(
        Invocation.method(
          #get,
          [],
        ),
        returnValue:
            _i4.Future<List<_i2.ServiceType>>.value(<_i2.ServiceType>[]),
      ) as _i4.Future<List<_i2.ServiceType>>);
  @override
  _i4.Future<void> update(_i2.ServiceType? serviceType) => (super.noSuchMethod(
        Invocation.method(
          #update,
          [serviceType],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [ServicesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockServicesRepository extends _i1.Mock
    implements _i5.ServicesRepository {
  MockServicesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i6.Service>> add(
    _i6.Service? service, [
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
        returnValue: _i4.Future<List<_i6.Service>>.value(<_i6.Service>[]),
      ) as _i4.Future<List<_i6.Service>>);
  @override
  _i4.Future<void> delete(int? id) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<List<_i6.Service>> get(
    DateTime? startDate, [
    DateTime? endDate,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [
            startDate,
            endDate,
          ],
        ),
        returnValue: _i4.Future<List<_i6.Service>>.value(<_i6.Service>[]),
      ) as _i4.Future<List<_i6.Service>>);
  @override
  _i4.Future<void> update(_i6.Service? service) => (super.noSuchMethod(
        Invocation.method(
          #update,
          [service],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i7.Auth {
  MockAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set user(_i8.AppUser? _user) => super.noSuchMethod(
        Invocation.setter(
          #user,
          _user,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Stream<_i8.AppUser?> get userChanges => (super.noSuchMethod(
        Invocation.getter(#userChanges),
        returnValue: _i4.Stream<_i8.AppUser?>.empty(),
      ) as _i4.Stream<_i8.AppUser?>);
  @override
  _i4.Future<bool> signInWithPassword(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signInWithPassword,
          [
            email,
            password,
          ],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<bool> signInWithGoogle() => (super.noSuchMethod(
        Invocation.method(
          #signInWithGoogle,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<void> signOut() => (super.noSuchMethod(
        Invocation.method(
          #signOut,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> signUp(_i8.AppUser? user) => (super.noSuchMethod(
        Invocation.method(
          #signUp,
          [user],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
