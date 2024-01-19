import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_r5_app/core/core.dart';

@lazySingleton
@injectable
class AuthService {
  final FirebaseAuth _auth = getIt.get<FirebaseAuth>();

  Future createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print(e.message);
        }
        return 1;
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print(e.message);
        }
        return 2;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        if (kDebugMode) {
          print(e.message);
        }
        return 1;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future signOut() async => await _auth.signOut();
}
