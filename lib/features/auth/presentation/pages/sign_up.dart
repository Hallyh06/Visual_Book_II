// ignore_for_file: unnecessary_const, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:visual_book/core/constant/app_assets.dart';
import 'package:visual_book/core/utils/busy_button.dart';
import 'package:visual_book/core/utils/flushbar_notification.dart';
import 'package:visual_book/core/utils/font.dart';
import 'package:visual_book/core/navigator/router.dart';
import 'package:visual_book/features/auth/presentation/auth_notifier/auth_notifier.dart';
import 'package:visual_book/features/auth/presentation/pages/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.params,
  });
  final LoginArguement params;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthNootifier>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                child: Image.asset(
                  AppAssets.vsLogo,
                  height: 100,
                  width: 100,
                ),
              ),
              const Gap(80),
              TextBold(
                widget.params.email,
                fontSize: 12,
                color: Colors.black,
              ),
              const Gap(20),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: const Color(0xffEBE6E1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: const Color(0xffEBE6E1),
                      ),
                      const Gap(10),
                      Expanded(
                        child: TextFormField(
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          controller: nameController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name',
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
                        Icons.lock,
                        color: const Color(0xffEBE6E1),
                      ),
                      const Gap(10),
                      Expanded(
                        child: TextFormField(
                          controller: passwordController,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          obscureText: true,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
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
                        Icons.lock,
                        color: const Color(0xffEBE6E1),
                      ),
                      const Gap(10),
                      Expanded(
                        child: TextFormField(
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          controller: confirmPasswordController,
                          obscureText: true,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Passwoord',
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
                  ttitle: 'Create Account',
                  onTap: () {
                    if (nameController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      return FlushbarNotification.showErrorMessage(context,
                          message: 'Complete the form to create account');
                    } else {
                      authProvider.signUp(context,
                          email: widget.params.email,
                          name: nameController.text,
                          password: passwordController.text);
                    }
                  }),
              const Gap(40),
              TextSemiBold(
                'Already have an account?',
                fontSize: 10,
                color: Colors.black.withOpacity(0.5),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.loginScreen);
                },
                child: TextBold(
                  'SignIn',
                  fontSize: 15,
                  color: Colors.black.withOpacity(0.3),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
