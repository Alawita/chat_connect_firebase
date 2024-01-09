import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password provided for that user.');
      } else {
        throw AuthException(e.message!);
      }
    }
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password provided for that user.');
      } else {
        throw AuthException(e.message!);
      }
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      if (userCredential.user != null) {
        await saveUserInfoToFirebase(
            userCredential.user!.uid.toString(),
            userCredential.user!.displayName.toString(),
            userCredential.user!.email.toString());
      }

      return userCredential.user;
    } catch (e) {
      debugPrint(e.toString());
      throw AuthException(e.toString());
    }
  }

  Future<void> saveUserInfoToFirebase(
      String userId, String userName, String email,) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          "userID" : userId,
          'username': userName,
          'email': email,
          'userLocation': null,
        },
      );
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      throw AuthException(e.toString());
    }
  }
}

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}