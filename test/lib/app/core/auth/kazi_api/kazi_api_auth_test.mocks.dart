// Mocks generated by Mockito 5.4.2 from annotations
// in kazi/test/lib/app/core/auth/kazi_api/kazi_api_auth_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:kazi/app/data/connection/kazi_connection.dart' as _i4;
import 'package:kazi/app/data/repositories/auth_repository/auth_repository.dart'
    as _i6;
import 'package:kazi/app/models/api_response.dart' as _i2;
import 'package:kazi/app/models/user.dart' as _i3;
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

class _FakeApiResponse_0 extends _i1.SmartFake implements _i2.ApiResponse {
  _FakeApiResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUser_1 extends _i1.SmartFake implements _i3.User {
  _FakeUser_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [KaziConnection].
///
/// See the documentation for Mockito's code generation for more information.
class MockKaziConnection extends _i1.Mock implements _i4.KaziConnection {
  MockKaziConnection() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.ApiResponse> get(
    String? url, {
    Map<String, dynamic>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#parameters: parameters},
        ),
        returnValue: _i5.Future<_i2.ApiResponse>.value(_FakeApiResponse_0(
          this,
          Invocation.method(
            #get,
            [url],
            {#parameters: parameters},
          ),
        )),
      ) as _i5.Future<_i2.ApiResponse>);
  @override
  _i5.Future<_i2.ApiResponse> post(
    String? url, {
    Object? body,
    Map<String, dynamic>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #body: body,
            #parameters: parameters,
          },
        ),
        returnValue: _i5.Future<_i2.ApiResponse>.value(_FakeApiResponse_0(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #body: body,
              #parameters: parameters,
            },
          ),
        )),
      ) as _i5.Future<_i2.ApiResponse>);
  @override
  _i5.Future<_i2.ApiResponse> put(
    String? url, {
    Object? body,
    Map<String, dynamic>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #body: body,
            #parameters: parameters,
          },
        ),
        returnValue: _i5.Future<_i2.ApiResponse>.value(_FakeApiResponse_0(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #body: body,
              #parameters: parameters,
            },
          ),
        )),
      ) as _i5.Future<_i2.ApiResponse>);
  @override
  _i5.Future<_i2.ApiResponse> patch(
    String? url, {
    Object? body,
    Map<String, dynamic>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #body: body,
            #parameters: parameters,
          },
        ),
        returnValue: _i5.Future<_i2.ApiResponse>.value(_FakeApiResponse_0(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #body: body,
              #parameters: parameters,
            },
          ),
        )),
      ) as _i5.Future<_i2.ApiResponse>);
  @override
  _i5.Future<_i2.ApiResponse> delete(
    String? url, {
    Object? body,
    Map<String, dynamic>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #body: body,
            #parameters: parameters,
          },
        ),
        returnValue: _i5.Future<_i2.ApiResponse>.value(_FakeApiResponse_0(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #body: body,
              #parameters: parameters,
            },
          ),
        )),
      ) as _i5.Future<_i2.ApiResponse>);
  @override
  void handleResponse(_i2.ApiResponse? response) => super.noSuchMethod(
        Invocation.method(
          #handleResponse,
          [response],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i6.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.User> signInWithPassword(
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
        returnValue: _i5.Future<_i3.User>.value(_FakeUser_1(
          this,
          Invocation.method(
            #signInWithPassword,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i5.Future<_i3.User>);
  @override
  _i5.Future<_i3.User> signInWithGoogle() => (super.noSuchMethod(
        Invocation.method(
          #signInWithGoogle,
          [],
        ),
        returnValue: _i5.Future<_i3.User>.value(_FakeUser_1(
          this,
          Invocation.method(
            #signInWithGoogle,
            [],
          ),
        )),
      ) as _i5.Future<_i3.User>);
  @override
  _i5.Future<void> signUp(_i3.User? user) => (super.noSuchMethod(
        Invocation.method(
          #signUp,
          [user],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<_i3.User> refreshSession(String? refreshToken) =>
      (super.noSuchMethod(
        Invocation.method(
          #refreshSession,
          [refreshToken],
        ),
        returnValue: _i5.Future<_i3.User>.value(_FakeUser_1(
          this,
          Invocation.method(
            #refreshSession,
            [refreshToken],
          ),
        )),
      ) as _i5.Future<_i3.User>);
  @override
  _i5.Future<void> forgotPassword(String? email) => (super.noSuchMethod(
        Invocation.method(
          #forgotPassword,
          [email],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> resetPassword(String? password) => (super.noSuchMethod(
        Invocation.method(
          #resetPassword,
          [password],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}