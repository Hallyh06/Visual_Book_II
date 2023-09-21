import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visual_book/core/utils/font.dart';
import 'package:visual_book/features/home/presentation/pages/creat_gift.dart';

import '../../../../core/constant/app_assets.dart';
import '../../../../core/navigator/router.dart';

class GiftVirtualCode extends StatefulWidget {
  const GiftVirtualCode({super.key, required this.params});
  final GiftArguement params;
  @override
  State<GiftVirtualCode> createState() => _GiftVirtualCodeState();
}

class _GiftVirtualCodeState extends State<GiftVirtualCode> {
  String firstTrhree = '';
  String lastThree = '';
  void generateFirstThree() {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 3; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    firstTrhree = rndnumber;
    print(firstTrhree);
  }

  void generateLastThree() {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 3; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    lastThree = rndnumber;
    print(lastThree);
  }

  @override
  void initState() {
    generateFirstThree();
    generateLastThree();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Align(
                    child: Image.asset(
                      AppAssets.vsLogo,
                      height: 80,
                      width: 80,
                    ),
                  ),
                  const Gap(20),
                  TextBold(
                    'We have emailed you the code for later',
                    fontSize: 20,
                  ),
                  const Gap(20),
                  TextSemiBold(
                    'Prepare a heartwarming gift by adding a personal message, photos and videos.\n\nshare the code below with.\n\n',
                    fontSize: 15,
                    maxLines: 10,
                  ),
                  Align(
                    child: TextBold(
                      widget.params.name,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(10),
                  Align(
                    child: TextBold(
                      '$firstTrhree-$lastThree',
                      fontSize: 25,
                      color: const Color(0xffDBD2C2),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteName.creatGift,
                        arguments: CreateGiftParams(
                            name: widget.params.name,
                            visualCode: '$firstTrhree$lastThree'),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 3,
                          color: const Color(0xffDBD2C2),
                        ),
                      ),
                      child: Center(
                        child: TextSemiBold(
                          'Next',
                          fontSize: 14,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  const Gap(30),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GiftArguement {
  GiftArguement({
    required this.name,
  });
  final String name;
}
