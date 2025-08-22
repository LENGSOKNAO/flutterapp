import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth_provider.dart';
import 'package:flutterapp/services/auth_service.dart' as _authProvider;
import 'package:flutterapp/services/auth_user.dart';
import 'package:flutterapp/services/firebase_auth_provider.dart';

class AuthService extends AuthProvider {
  final AuthProvider _authProvider;
  AuthService(this._authProvider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) => _authProvider.createUser(email: email, password: password);
  @override
  AuthUser? get currentUser => _authProvider.currentUser;

  @override
  Future<AuthUser> logIn({required String email, required String password}) =>
      _authProvider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => _authProvider.logOut();
  @override
  Future<void> sendEmailVerification() => _authProvider.sendEmailVerification();

  @override
  Future<void> initialize() => _authProvider.initialize();

  void createUserWithEmailAndPassword({required String email, required String password}) {}
}
