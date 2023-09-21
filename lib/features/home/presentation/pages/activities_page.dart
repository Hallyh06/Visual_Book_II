import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visual_book/core/constant/app_assets.dart';
import 'package:visual_book/core/utils/font.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.home,
                      size: 50,
                      color: Color(0xffDBD2C2),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.settings,
                      size: 50,
                      color: Color(0xffDBD2C2),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            TextSemiBold(
              'Account Activities',
              fontSize: 16,
              color: const Color(0xffC2B1A3),
            ),
            const Gap(20),
            /* Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 5)
                ],
              ),
              child: Center(
               
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
