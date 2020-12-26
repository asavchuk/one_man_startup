import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // final _controller = StreamController<String>();
  //
  // Stream<String> get onAuthStateChanged {
  //   User user = _firebaseAuth.currentUser;
  //   _controller.add(user?.uid);
  //   return _controller.stream;
  // }

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);

  Future<String> createUserWithEmailAndPassword(String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    //update the usermane
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
    return currentUser.uid;
  }

  Future<String> singInWithEmailAndPassword(String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).uid;
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Future sendPasswordResetEmail(String email) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Name can\'t be empty';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    if (value.length > 50) {
      return 'Name must be less than 50 characters long';
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return ('Email can\'t be empty');
    } else {
      return null;
    }
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return ('Password can\'t be empty');
    } else {
      return null;
    }
  }
}
