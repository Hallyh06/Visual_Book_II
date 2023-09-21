// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_book/core/utils/app_loader.dart';
import 'package:visual_book/core/utils/flushbar_notification.dart';

import '../../../../core/navigator/router.dart';

class AuthNootifier extends ChangeNotifier {
  AuthNootifier();
  final auth = FirebaseAuth.instance;
  final firestoreStorage = FirebaseFirestore.instance;
  setvisitStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('LoggedIn', true);
    print('LoggedIn');
  }

  Future<void> signUp(
    BuildContext context, {
    required String email,
    required String name,
    required String password,
  }) async {
    unawaited(AppLoadingPopUp().show(context));
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      firestoreStorage.collection('users').doc(auth.currentUser!.uid).set({
        'name': name,
        'email': email,
      });
      setvisitStatus();
      notifyListeners();
      Navigator.pop(context);
      Navigator.pushNamed(context, RouteName.homeScreen);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      FlushbarNotification.showErrorMessage(context, message: e.toString());
      notifyListeners();
    }
  }

  Future<void> signIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    unawaited(AppLoadingPopUp().show(context));
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
      Navigator.pushNamed(context, RouteName.homeScreen);
      setvisitStatus();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      FlushbarNotification.showErrorMessage(context, message: e.toString());
      notifyListeners();
    }
  }
}
