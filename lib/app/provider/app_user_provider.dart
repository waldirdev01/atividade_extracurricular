import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class AppUserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  AppUser? _user;

  AppUser? get user => _user;

  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) {
      return null;
    }

    final userData = await _db.collection('users').doc(user.uid).get();
    _user = AppUser.fromJson(userData.data()!);
    notifyListeners();
    return _user;
  }



  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password) async {
    final credentials = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final userData =
        await _db.collection('users').doc(credentials.user!.uid).get();

    _user = AppUser.fromJson(userData.data()!);
    notifyListeners();
    return _user;
  }

  Future<AppUser?> findUserById(String id) async {
    final userData = await _db.collection('users').doc(id).get();
    if (userData.exists) {
      return AppUser.fromJson(userData.data()!);
    } else {
      return null;
    }
  }

  Future<AppUser?> createUserWithEmailAndPassword(
      String email, String password, UserType type) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final userData = {
      'id': credentials.user!.uid,
      'email': email,
      'type': type.string,
      'password': password,
    };
    await _db.collection('users').doc(credentials.user!.uid).set(userData);

    _user = AppUser.fromJson(userData);
    notifyListeners();

    return _user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUser(AppUser updatedUser) async {
    await _db
        .collection('users')
        .doc(updatedUser.id)
        .update(updatedUser.toJson());

    _user = updatedUser;
    notifyListeners();
  }
}
