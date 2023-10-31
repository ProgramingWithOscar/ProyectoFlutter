import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:storemap/database/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  User? _user;

  final Completer<void> _completer = Completer();

  AuthenticationRepositoryImpl(this._firebaseAuth) {
    _init();
  }
  @override
  // TODO: implement user
  Future<User?> get user async {
    await _completer.future;
    _user;
  }

  void _init() async {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (!_completer.isCompleted) {
        _completer.complete();
      }
      _user = user;
    });
  }
}
