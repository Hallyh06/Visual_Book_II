import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:visual_book/core/constant/app_assets.dart';
import 'package:visual_book/core/utils/busy_button.dart';
import 'package:visual_book/core/utils/flushbar_notification.dart';
import 'package:visual_book/features/auth/presentation/auth_notifier/auth_notifier.dart';

import '../../../../core/utils/font.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.params,
  });
  final LoginArguement params;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthNootifier>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: Image.asset(
                    AppAssets.vsLogo,
                    height: 100,
                    width: 100,
                  ),
                ),
                const Gap(70),
                Align(
                  child: TextBold(
                    widget.params.email,
                    fontSize: 16,
                    color: Colors.black,
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
                          color: Color(0xffDBD2C2),
                        ),
                        const Gap(10),
                        Expanded(
                          child: TextFormField(
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            obscureText: true,
                            controller: passwordController,
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
                const Gap(40),
                BusyButton(
                  ttitle: 'Sign In',
                  onTap: () {
                    if (passwordController.text.isEmpty) {
                      return FlushbarNotification.showErrorMessage(context,
                          message: 'Complete the form to create account');
                    } else {
                      authProvider.signIn(
                        context,
                        email: widget.params.email,
                        password: passwordController.text,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginArguement {
  LoginArguement({
    required this.email,
  });
  final String email;
}
