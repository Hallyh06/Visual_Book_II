import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visual_book/core/constant/app_assets.dart';
import 'package:visual_book/core/utils/busy_button.dart';
import 'package:visual_book/core/utils/flushbar_notification.dart';
import 'package:visual_book/core/utils/font.dart';
import 'package:visual_book/core/navigator/router.dart';
import 'package:visual_book/features/auth/presentation/pages/login.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Align(
                child: Image.asset(
                  AppAssets.vsLogo,
                  height: 100,
                  width: 100,
                ),
              ),
              const Gap(10),
              TextSemiBold(
                'Time to create interactive and\n immersive way to capture and\n preserve memories',
                maxLines: 10,
                fontSize: 13,
                color: Colors.black,
                textAlign: TextAlign.center,
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
                ttitle: 'Sign In',
                onTap: () {
                  if (emailController.text.isEmpty) {
                    return FlushbarNotification.showErrorMessage(context,
                        message: 'Complete the form to create account');
                  } else {
                    Navigator.pushNamed(
                      context,
                      RouteName.loginScreen,
                      arguments: LoginArguement(email: emailController.text),
                    );
                  }
                },
              ),
              const Gap(20),
              BusyButton(
                ttitle: 'Create Account',
                onTap: () {
                  if (emailController.text.isEmpty) {
                    return FlushbarNotification.showErrorMessage(context,
                        message: 'Complete the form to create account');
                  } else {
                    Navigator.pushNamed(
                      context,
                      RouteName.signUp,
                      arguments: LoginArguement(email: emailController.text),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
