import 'dart:isolate';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterapp/firebase_options.dart';
import 'package:flutterapp/services/auth_provider.dart';
import 'package:flutterapp/services/auth_user.dart';
import 'package:flutterapp/services/auth_execption.dart';
import 'package:flutterapp/services/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    // TODO: implement createUser
    try {
      await firebase_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedAuthException();
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GennericAuthException();
      }
    } catch (_) {
      throw GennericAuthException();
    }
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser {
    final user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    // TODO: implement logIn
    try {
      await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedAuthException();
      }
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GennericAuthException();
      }
    } catch (_) {
      throw GennericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    // TODO: implement logOut
    final user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      await firebase_auth.FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedAuthException();
    }
  }
  
  @override
  Future<void> initialize() async {
    // TODO: implement initialize
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
