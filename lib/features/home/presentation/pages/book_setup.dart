import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visual_book/core/constant/app_assets.dart';
import 'package:visual_book/core/utils/busy_button.dart';
import 'package:visual_book/core/utils/font.dart';
import 'package:visual_book/core/navigator/router.dart';

class BookSetup extends StatefulWidget {
  const BookSetup({super.key});

  @override
  State<BookSetup> createState() => _BookSetupState();
}

class _BookSetupState extends State<BookSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  child: Image.asset(
                    AppAssets.vsLogo,
                    height: 80,
                    width: 80,
                  ),
                ),
                const Gap(10),
                TextBold(
                  'Setting Up A New Book Or Received Gift?',
                  fontSize: 20,
                  color: Colors.black,
                ),
                const Gap(20),
                TextSemiBold(
                  'Before setting a new book,  inviting others and adding your virtual code for gift books, Scan the QR code on the book first.',
                  fontSize: 14,
                  color: Colors.black,
                  maxLines: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                BusyButton(
                  ttitle: 'Scan And Connect',
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.qrScanner);
                  },
                ),
                const Gap(20),
                BusyButton(
                    ttitle: 'Generate a virtual code',
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.virtualBookFor);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
