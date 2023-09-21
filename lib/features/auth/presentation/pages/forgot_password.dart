// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visual_book/core/constant/app_assets.dart';
import 'package:visual_book/core/navigator/router.dart';
import 'package:visual_book/core/utils/app_loader.dart';
import 'package:visual_book/core/utils/busy_button.dart';
import 'package:visual_book/core/utils/flushbar_notification.dart';
import 'package:visual_book/core/utils/font.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> resetPassword(String email) async {
    unawaited(AppLoadingPopUp().show(context));
    try {
      await auth.sendPasswordResetEmail(email: email);
      Navigator.pop(context);
      FlushbarNotification.showSuccessMessage(context,
          message: 'Check your email to reset password');
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      FlushbarNotification.showErrorMessage(
        context,
        message: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Align(
              child: Image.asset(
                AppAssets.vsLogo,
                height: 80,
                width: 80,
              ),
            ),
            const Gap(40),
            TextBold(
              'Forgot Password?',
              fontSize: 20,
              color: const Color(0xff000000),
            ),
            const Gap(20),
            TextSemiBold(
              'Please provide your email address to receive password reset support',
            ),
            const Gap(20),
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: const Color(0xffEBE6E1),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: Color(0xffDBD2C2),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextFormField(
                        controller: emailController,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(40),
            BusyButton(
              ttitle: 'Reset Password',
              onTap: () async {
                if (emailController.text.isEmpty) {
                  return FlushbarNotification.showErrorMessage(context,
                      message: 'Complete the form to create account');
                } else {
                  await resetPassword(emailController.text);
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
