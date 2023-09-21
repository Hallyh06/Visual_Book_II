// ignore_for_file: unused_element

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:visual_book/core/utils/flushbar_notification.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  late double scanArea;
  bool snackbarflag = false;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void didChangeDependencies() {
    scanArea = MediaQuery.of(context).size.width * 0.7;
    Future.delayed(const Duration(seconds: 4), () {
      // Navigator.pushNamed(context, RouteName.virtualBookFor);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ],
        ),
      ),
    );
  }

  FirebaseFirestore storeDeviceCode = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future connectDeviceCode({required String scannedCode}) async {
    try {
      storeDeviceCode
          .collection('pairedDevices')
          .doc(auth.currentUser!.uid)
          .collection('code')
          .add({
        'code': scannedCode,
        'connected': true,
      });
      Navigator.pop(context);
    } catch (e) {
      FlushbarNotification.showErrorMessage(context, message: e.toString());
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
