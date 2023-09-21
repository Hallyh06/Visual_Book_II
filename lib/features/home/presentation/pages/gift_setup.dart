import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visual_book/core/navigator/router.dart';
import 'package:visual_book/core/utils/busy_button.dart';
import 'package:visual_book/core/utils/font.dart';

import '../../../../core/constant/app_assets.dart';

class GiftSetup extends StatefulWidget {
  const GiftSetup({super.key});

  @override
  State<GiftSetup> createState() => _GiftSetupState();
}

class _GiftSetupState extends State<GiftSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
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
              const Gap(30),
              TextBold(
                'Gifting A Visual Book',
                fontSize: 20,
                color: const Color(0xff000000),
              ),
              const Gap(20),
              TextSemiBold(
                'Easily generate a special virtual code from anywhere in the world and gift it to yoour loved ones.\nif you have the box annd would love to gift in person, choose the QR code option located on the packaging.',
                fontSize: 16,
                color: const Color(0xff000000),
                maxLines: 10,
              ),
              const Gap(60),
              BusyButton(
                  ttitle: 'Generate a virtual code',
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.virtualBookFor);
                  }),
              const Gap(20),
              BusyButton(
                ttitle: 'Scan the QR code',
                onTap: () {},
              )
            ],
          ),
        ),
      )),
    );
  }
}
