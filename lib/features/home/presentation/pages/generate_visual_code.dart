import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visual_book/core/utils/font.dart';

import '../../../../core/constant/app_assets.dart';

class GenerateVirtualCode extends StatefulWidget {
  const GenerateVirtualCode({super.key});

  @override
  State<GenerateVirtualCode> createState() => _GenerateVirtualCodeState();
}

class _GenerateVirtualCodeState extends State<GenerateVirtualCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              child: Image.asset(
                AppAssets.vsLogo,
                height: 80,
                width: 80,
              ),
            ),
            const Gap(20),
            TextBold('Who are you pre')
          ],
        ),
      ),
    );
  }
}
