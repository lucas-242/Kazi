// Mocks generated by Mockito 5.4.4 from annotations
// in kazi/test/lib/app/features/services/services_type/service_types_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:kazi/domain/repositories/service_type_repository.dart' as _i3;
import 'package:kazi/domain/repositories/services_repository.dart' as _i5;
import 'package:kazi/domain/services/auth_service.dart' as _i6;
import 'package:kazi_core/kazi_core.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
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
  _i4.Future<List<_i2.Service>> add(
    _i2.Service? service, [
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
        returnValue: _i4.Future<List<_i2.Service>>.value(<_i2.Service>[]),
      ) as _i4.Future<List<_i2.Service>>);

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
  _i4.Future<List<_i2.Service>> get(_i2.ServicesFilter? servicesFilter) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [servicesFilter],
        ),
        returnValue: _i4.Future<List<_i2.Service>>.value(<_i2.Service>[]),
      ) as _i4.Future<List<_i2.Service>>);

  @override
  _i4.Future<void> update(_i2.Service? service) => (super.noSuchMethod(
        Invocation.method(
          #update,
          [service],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [Auth].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuth extends _i1.Mock implements _i6.AuthService {
  MockAuth() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set user(_i2.User? _user) => super.noSuchMethod(
        Invocation.setter(
          #user,
          _user,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Stream<_i2.User?> get userChanges => (super.noSuchMethod(
        Invocation.getter(#userChanges),
        returnValue: _i4.Stream<_i2.User?>.empty(),
      ) as _i4.Stream<_i2.User?>);

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
  _i4.Future<void> signUp(_i2.User? user) => (super.noSuchMethod(
        Invocation.method(
          #signUp,
          [user],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> forgotPassword(String? email) => (super.noSuchMethod(
        Invocation.method(
          #forgotPassword,
          [email],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> resetPassword(
    String? token,
    String? newPassword,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #resetPassword,
          [
            token,
            newPassword,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> changePassword(
    String? currentPassword,
    String? newPassword,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #changePassword,
          [
            currentPassword,
            newPassword,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
