import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:visual_book/core/utils/flushbar_notification.dart';

class FirebaseApi {
  static UploadTask? uploadFile(
      BuildContext context, String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      FlushbarNotification.showErrorMessage(
        context,
        message: e.toString(),
      );
    }
  }

  static UploadTask? uploadBytes(
      BuildContext context, String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      FlushbarNotification.showErrorMessage(
        context,
        message: e.toString(),
      );
    }
  }
}
